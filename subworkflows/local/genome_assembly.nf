include { CAT_FASTQ as CAT_FASTQ_PATERNAL } from '../../modules/nf-core/cat/fastq/main'
include { CAT_FASTQ as CAT_FASTQ_MATERNAL } from '../../modules/nf-core/cat/fastq/main'
include { HIFIASM                         } from '../../modules/nf-core/hifiasm'
include { YAK as YAK_PATERNAL             } from '../../modules/local/yak'
include { YAK as YAK_MATERNAL             } from '../../modules/local/yak'
include { GFASTATS as GFASTATS_MATERNAL   } from '../../modules/nf-core/gfastats/main'
include { GFASTATS as GFASTATS_PATERNAL   } from '../../modules/nf-core/gfastats/main'

workflow ASSEMBLY {

    take:
    ch_reads // channel: [ val(meta), fastq ]

    main:
    ch_versions = Channel.empty()
    ch_hifiasm_empty = Channel.value([ [], [], [] ])

    if(params.hifiasm_mode == 'hifi-only') {

        ch_reads
            .groupTuple()
            .set { hifiasm_in }

        HIFIASM ( hifiasm_in, ch_hifiasm_empty, ch_hifiasm_empty )
        ch_versions = ch_versions.mix(HIFIASM.out.versions)

    } else if(params.hifiasm_mode == 'trio-binning') {
        // Multiple trios with different parents may not work?
        ch_reads.groupTuple()
            .map{ meta, _reads -> meta } // Takes meta, then
            // combine to create all possible combinations of [ meta, meta ]
            // but keep only the id of the second meta [ meta, meta.id ]
            .combine(ch_reads.groupTuple().map{ meta, reads -> [meta.id, reads] })
            // This creates [ meta, [ meta.id, reads] ], where
            // meta.id comes from the meta of the reads, and a combination between these
            // and every other sample meta in the samplesheet is created
            //
            // From this we can extract kids (or rather the primary patient), moms, and dads:
            //
            // If any sample has the id of another sample as paternal_id, then that is a dad
            // If any sample has the id of another sample as maternal_id, then that is a mom
            // If any sample has the id of another sample as id, then that is a kid (should be one
            // combination like this for every sample)
            // This means that everyone is a kid (even parents), but not every kid has parents
            .branch{ kid_meta, sample_id, _reads ->
                kid: sample_id == kid_meta.id
                mom: sample_id == kid_meta.maternal_id
                dad: sample_id == kid_meta.paternal_id
            }
            .set{branch_result}

        branch_result
            .kid.map{ meta, _sample_id, reads -> [ meta, reads ] }
            // Then we join the kids, together with dads and moms
            .join(branch_result.dad.map { meta, _sample_id, reads -> [ meta, reads ] }, remainder: true)
            .join(branch_result.mom.map { meta, _sample_id, reads -> [ meta, reads ] }, remainder: true)
            // Since every sample is still a considered a kid,
            // we check if they have both parents, and is therefore a trio
            .branch{ kid_meta, kid_reads, dad_reads, mom_reads ->
                is_trio: dad_reads != null && mom_reads != null
                    return tuple ( kid_meta, kid_reads, dad_reads, mom_reads )
                no_trio: dad_reads == null || mom_reads == null
                    return tuple ( kid_meta, kid_reads, [], [] )
            }
        .set{ ch_samples }

        // We keep using kid_meta for the parental reads, since they need to go toghether into hifiasm
        trio_kids = ch_samples.is_trio.map{ kid_meta, kid_reads, _dad_reads, _mom_reads -> [ kid_meta, kid_reads ] }
        trio_dads = ch_samples.is_trio.map{ kid_meta, _kid_reads, dad_reads, _mom_reads -> [ kid_meta, dad_reads ] }
        trio_moms = ch_samples.is_trio.map{ kid_meta, _kid_reads, _dad_reads, mom_reads -> [ kid_meta, mom_reads ] }

        // These can be someone elses mom or dad (parents)
        non_trio_kids = ch_samples.no_trio.map{ kid_meta, kid_reads, _dad_reads, _mom_reads -> [ kid_meta, kid_reads ] }
        // Should just be a kid_meta with empty reads
        non_trio_dads = ch_samples.no_trio.map{ kid_meta, _kid_reads, dad_reads, _mom_reads -> [ kid_meta, dad_reads ] }
        non_trio_moms = ch_samples.no_trio.map{ kid_meta, _kid_reads, _dad_reads, mom_reads -> [ kid_meta, mom_reads ] }

        // Parental samples needs to be merged before YAK
        // For now merge every sample, even if there's only one copy of reads
        CAT_FASTQ_PATERNAL ( trio_dads )
        ch_versions = ch_versions.mix(CAT_FASTQ_PATERNAL.out.versions)
        CAT_FASTQ_MATERNAL ( trio_moms )
        ch_versions = ch_versions.mix(CAT_FASTQ_MATERNAL.out.versions)

        // Then run YAK
        YAK_PATERNAL( CAT_FASTQ_PATERNAL.out.reads )
        ch_versions = ch_versions.mix(YAK_PATERNAL.out.versions)

        YAK_MATERNAL( CAT_FASTQ_MATERNAL.out.reads )
        ch_versions = ch_versions.mix(YAK_MATERNAL.out.versions)

        paternal_yak_or_empty = YAK_PATERNAL.out.yak.concat(non_trio_dads)
        maternal_yak_or_empty = YAK_MATERNAL.out.yak.concat(non_trio_moms)

        all_kid_reads = trio_kids.concat(non_trio_kids)

        hifiasm_trio_in = all_kid_reads.join(paternal_yak_or_empty).join(maternal_yak_or_empty)

        hifiasm_trio_in
            .multiMap { meta, reads, paternal_yak, maternal_yak ->
                reads : [meta, reads                     ]
                yak   : [meta, paternal_yak, maternal_yak]
            }
            .set { ch_hifiasm_in }
        HIFIASM ( ch_hifiasm_in.reads, ch_hifiasm_in.yak, ch_hifiasm_empty )
        ch_versions = ch_versions.mix(HIFIASM.out.versions)
    }

    // Not the cleanest way, but better than to rely on hap_* in file names..
    GFASTATS_PATERNAL( HIFIASM.out.paternal_contigs,'fasta', '', '', [], [], [], [] )
    ch_versions = ch_versions.mix(GFASTATS_PATERNAL.out.versions)

    GFASTATS_MATERNAL( HIFIASM.out.maternal_contigs,'fasta', '', '', [], [], [], [] )
    ch_versions = ch_versions.mix(GFASTATS_MATERNAL.out.versions)

    GFASTATS_PATERNAL.out.assembly
        .join(GFASTATS_MATERNAL.out.assembly)
        .set{ ch_dual_assembly_fa }

    emit:
    assembled_haplotypes = ch_dual_assembly_fa // channel: [ val(meta), path(paternal_fasta), path(maternal_fasta) ]
    versions = ch_versions                     // channel: [ versions.yml ]
}

