//
// Workflow to call and merge SNVs
//
include { ADD_FOUND_IN_TAG                            } from '../../../modules/local/add_found_in_tag/main'
include { BCFTOOLS_CONCAT                             } from '../../../modules/nf-core/bcftools/concat/main'
include { BCFTOOLS_FILLTAGS                           } from '../../../modules/local/bcftools/filltags/main'
include { BCFTOOLS_NORM as BCFTOOLS_NORM_MULTISAMPLE  } from '../../../modules/nf-core/bcftools/norm/main'
include { BCFTOOLS_NORM as BCFTOOLS_NORM_SINGLESAMPLE } from '../../../modules/nf-core/bcftools/norm/main'
include { DEEPVARIANT_RUNDEEPVARIANT                  } from '../../../modules/nf-core/deepvariant/rundeepvariant/main'
include { DEEPVARIANT_VCFSTATSREPORT                  } from '../../../modules/nf-core/deepvariant/vcfstatsreport/main'
include { GLNEXUS                                     } from '../../../modules/nf-core/glnexus/main'

workflow SHORT_VARIANT_CALLING {

    take:
    ch_bam_bai_bed // channel: [mandatory] [ val(meta), path(bam), path(bai), path(call_region_bed) ]
    ch_fasta       // channel: [mandatory] [ val(meta), path(fasta) ]
    ch_fai         // channel: [mandatory] [ val(meta), path(fai) ]
    ch_bed         // channel: [optional] [ val(meta), path(input_bed) ]
    ch_par_bed     // channel: [mandatory] [ val(meta), path(par_bed) ]

    main:
    ch_versions = Channel.empty()

    ch_bam_bai_bed
        // Add call region to meta so we can group by it later
        .map { meta, bam, bai, bed ->
            [ meta + [ 'region': bed ], bam, bai, bed ]
        }
        .set { ch_deepvariant_in }

    DEEPVARIANT_RUNDEEPVARIANT ( ch_deepvariant_in, ch_fasta, ch_fai, [[],[]], ch_par_bed )
    ch_versions = ch_versions.mix(DEEPVARIANT_RUNDEEPVARIANT.out.versions)

    // First remove region so we can group per sample
    // Then after grouping remove num_intervals since to match the meta of other workflows
    DEEPVARIANT_RUNDEEPVARIANT.out.vcf
        .map { meta, vcf ->
            def new_meta = meta - meta.subMap('region')
            [ groupKey(new_meta, new_meta.num_intervals ), vcf ]
        }
        .groupTuple()
        .join( DEEPVARIANT_RUNDEEPVARIANT.out.vcf_tbi
            .map{ meta, tbi ->
                def new_meta = meta - meta.subMap('region')
                [ groupKey(new_meta, new_meta.num_intervals ), tbi ]
            }
            .groupTuple()
        )
        .map { meta, vcf, tbi ->
            [ meta - meta.subMap('num_intervals'), vcf, tbi ]
        }
        .set{ ch_concat_singlesample_in }

    // This creates a singlesample VCF containing ALL regions
    BCFTOOLS_CONCAT ( ch_concat_singlesample_in )
    ch_versions = ch_versions.mix(BCFTOOLS_CONCAT.out.versions)

    // Which is then normalized, and ready to be used
    // in processes that require SNVs, but not annotated SNVs
    BCFTOOLS_NORM_SINGLESAMPLE ( BCFTOOLS_CONCAT.out.vcf.map { meta, vcf -> [ meta, vcf, [] ] }, ch_fasta )
    ch_versions = ch_versions.mix(BCFTOOLS_NORM_SINGLESAMPLE.out.versions)

    // This creates one multisample VCF per family, with regions from ONE bed file
    DEEPVARIANT_RUNDEEPVARIANT.out.gvcf
        .map { meta, gvcf ->
            [ [ id:meta.region.name, family_id:meta.family_id ], gvcf ]
        }
        .groupTuple() // Groups files from the same family together per region
        .set{ glnexus_in }

    GLNEXUS( glnexus_in, ch_bed )
    ch_versions = ch_versions.mix(GLNEXUS.out.versions)

    // Add allele count tag to multisample bcf
    BCFTOOLS_FILLTAGS ( GLNEXUS.out.bcf )
    ch_versions = ch_versions.mix(BCFTOOLS_FILLTAGS.out.versions)

    // Annotate with FOUND_IN tag
    ADD_FOUND_IN_TAG (
        BCFTOOLS_FILLTAGS.out.vcf.map { meta, vcf -> [ meta, vcf, [] ] },
        "deepvariant"
    )
    ch_versions = ch_versions.mix(ADD_FOUND_IN_TAG.out.versions)

    // Decompose and normalize variants
    BCFTOOLS_NORM_MULTISAMPLE (
        ADD_FOUND_IN_TAG.out.vcf.map { meta, vcf -> [ meta, vcf, [] ] },
        ch_fasta
    )
    ch_versions = ch_versions.mix(BCFTOOLS_NORM_MULTISAMPLE.out.versions)

    // This is run before normalization for each sample to mimic run_deepvariant pipeline
    DEEPVARIANT_VCFSTATSREPORT ( BCFTOOLS_CONCAT.out.vcf )
    ch_versions = ch_versions.mix(DEEPVARIANT_VCFSTATSREPORT.out.versions)

    emit:
    snp_calls_vcf  = BCFTOOLS_NORM_SINGLESAMPLE.out.vcf    // channel: [ val(meta), path(vcf) ]
    snp_calls_tbi  = BCFTOOLS_NORM_SINGLESAMPLE.out.tbi    // channel: [ val(meta), path(tbi) ]
    family_bcf     = BCFTOOLS_NORM_MULTISAMPLE.out.vcf     // channel: [ val(meta), path(bcf) ]
    family_csi     = BCFTOOLS_NORM_MULTISAMPLE.out.csi     // channel: [ val(meta), path(csi) ]
    vcfstatsreport = DEEPVARIANT_VCFSTATSREPORT.out.report // channel: [ val(meta), path(html) ]
    versions       = ch_versions                           // channel: [ path(versions.yml) ]
}
