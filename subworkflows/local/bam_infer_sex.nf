include { SOMALIER_EXTRACT                 } from '../../modules/nf-core/somalier/extract/main'
include { SOMALIER_RELATE as RELATE_INFER  } from '../../modules/nf-core/somalier/relate/main'
include { SOMALIER_RELATE as RELATE_RELATE } from '../../modules/nf-core/somalier/relate/main'

workflow BAM_INFER_SEX {

    take:
    ch_bam_bai        // channel: [ val(meta), path(bam), path(bai) ]
    ch_fasta          // channel: [ val(meta), path(fasta) ]
    ch_fai            // channel: [ val(meta), path(fai) ]
    ch_somalier_sites // channel: [ val(meta), path(somalier_sites_vcf) ]
    ch_ped            // channel: [ val(meta), path(ped) ]

    main:
    ch_versions = Channel.empty()

    // Extract sites
    SOMALIER_EXTRACT (
        ch_bam_bai,
        ch_fasta,
        ch_fai,
        ch_somalier_sites
    )
    ch_versions = ch_versions.mix(SOMALIER_EXTRACT.out.versions)

    SOMALIER_EXTRACT.out.extract
        .combine( ch_ped.map { _meta, ped -> ped } )
        .filter { meta, _extract, _ped -> meta.sex == 0 }
        .set { ch_relate_infer_in }

    // 1. Run somalier relate on one sample at a time to infer sex
    RELATE_INFER ( ch_relate_infer_in, [] )
    ch_versions = ch_versions.mix(RELATE_INFER.out.versions)

    RELATE_INFER.out.samples_tsv
        .map { _meta, tsv -> tsv }
        .splitCsv(header: true, sep: '\t')
        .set { somalier_tsv }

    somalier_tsv
        .map { it ->
            // Hard error if sex could not be inferred for unknown sex samples
            assert !(it.original_pedigree_sex == "unknown" && (it.sex.toInteger() != 1 && it.sex.toInteger() != 2)) : "ERROR: Sex could not be automatically inferred for ${it.sample_id}. Please inspect manually and set sex in the samplesheet."

            [ it.sample_id, it ]
        }
        .set { ch_somalier_sex }

    // Branch on samples with known/unknown sex
    ch_bam_bai
        .branch { meta, _bam, _bai ->
            unknown_sex: meta.sex == 0
            known_sex: meta.sex != 0
        }
        .set { ch_samples }

    // Update sex with sex from somalier for samples with unknown sex
    ch_samples.unknown_sex
        .map { meta, bam, bai -> [ meta.id, meta, bam, bai ] }
        .join( ch_somalier_sex )
        .map { _id, meta, bam, bai, somalier ->
            def updated_sex = (meta.sex == 0 ? somalier.sex.toInteger() : meta.sex)
            [ meta + [sex: updated_sex], bam, bai ]
        }
        .set { ch_updated_sex }

    // Add samples with known sex
    ch_updated_sex = ch_updated_sex.mix(ch_samples.known_sex)

    // 2. Run relate on all samples at once to check relatedness
    SOMALIER_EXTRACT.out.extract
        .map { meta, extract -> [ [ id: meta.project ], extract ] }
        .groupTuple()
        .join( ch_ped )
        .set { ch_relate_relate_in }

    RELATE_RELATE ( ch_relate_relate_in, [] )
    ch_versions = ch_versions.mix(RELATE_RELATE.out.versions)

    emit:
    bam              = ch_updated_sex.map { meta, bam, _bai -> [ meta, bam ] } // channel: [ val(meta), path(bam) ]
    bai              = ch_updated_sex.map { meta, _bam, bai -> [ meta, bai ] } // channel: [ val(meta), path(bai) ]
    bam_bai          = ch_updated_sex                                          // channel: [ val(meta), path(bam), path(bai) ]
    somalier_samples = RELATE_RELATE.out.samples_tsv                           // channel: [ val(meta), path(samples_tsv) ]
    somalier_pairs   = RELATE_RELATE.out.pairs_tsv                             // channel: [ val(meta), path(pairs_tsv) ]
    versions = ch_versions                                                     // channel: [ versions.yml ]
}

