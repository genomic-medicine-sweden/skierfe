//
// A subworkflow to annotate snvs
//

include { BCFTOOLS_ANNOTATE as ANNOTATE_INDELS } from '../../../modules/nf-core/bcftools/annotate/main'
include { BCFTOOLS_ANNOTATE as RENAME_CHRNAMES } from '../../../modules/nf-core/bcftools/annotate/main'
include { BCFTOOLS_VIEW                        } from '../../../modules/nf-core/bcftools/view/main'
include { CADD                                 } from '../../../modules/nf-core/cadd/main'
include { GAWK as REFERENCE_TO_CADD_CHRNAMES   } from '../../../modules/nf-core/gawk/main'
include { GAWK as CADD_TO_REFERENCE_CHRNAMES   } from '../../../modules/nf-core/gawk/main'
include { TABIX_TABIX as TABIX_ANNOTATE        } from '../../../modules/nf-core/tabix/tabix/main'
include { TABIX_TABIX as TABIX_CADD            } from '../../../modules/nf-core/tabix/tabix/main'

workflow ANNOTATE_CADD {

    take:
    ch_fai                   // channel: [mandatory] [ val(meta), path(fai) ]
    ch_vcf                   // channel: [mandatory] [ val(meta), path(vcfs) ]
    ch_index                 // channel: [mandatory] [ val(meta), path(tbis) ]
    ch_header                // channel: [mandatory] [ val(meta), path(txt) ]
    ch_cadd_resources        // channel: [mandatory] [ val(meta), path(dir) ]
    ch_cadd_prescored_indels // channel: [mandatory] [ val(meta), path(dir) ]

    main:
    ch_versions = Channel.empty()

    REFERENCE_TO_CADD_CHRNAMES ( ch_fai , [] )
    ch_versions = ch_versions.mix(REFERENCE_TO_CADD_CHRNAMES.out.versions)

    CADD_TO_REFERENCE_CHRNAMES ( ch_fai , [] )
    ch_versions = ch_versions.mix(CADD_TO_REFERENCE_CHRNAMES.out.versions)

    ch_vcf
        .join(ch_index)
        .map { meta, vcf, tbi -> [ meta, vcf, tbi, [], [] ] }
        .set { rename_chrnames_in }

    RENAME_CHRNAMES (
        rename_chrnames_in,
        [],
        REFERENCE_TO_CADD_CHRNAMES.out.output.map { _meta, txt -> txt }
    )
    ch_versions = ch_versions.mix(RENAME_CHRNAMES.out.versions)

    BCFTOOLS_VIEW (
        RENAME_CHRNAMES.out.vcf.map { meta, vcf -> [ meta, vcf, [] ] },
        [],
        [],
        []
    )
    ch_versions = ch_versions.mix(BCFTOOLS_VIEW.out.versions)

    CADD ( BCFTOOLS_VIEW.out.vcf, ch_cadd_resources, ch_cadd_prescored_indels )
    ch_versions = ch_versions.mix(CADD.out.versions)

    TABIX_CADD ( CADD.out.tsv )
    ch_versions = ch_versions.mix(TABIX_CADD.out.versions)

    RENAME_CHRNAMES.out.vcf
        .join(CADD.out.tsv)
        .join(TABIX_CADD.out.tbi)
        .map { meta, vcf, annotations, annotations_index -> [ meta, vcf, [], annotations, annotations_index ] }
        .set { ch_annotate_indels_in }

    ANNOTATE_INDELS (
        ch_annotate_indels_in,
        ch_header.map { _meta, header -> header },
        CADD_TO_REFERENCE_CHRNAMES.out.output.map { _meta, txt -> txt }
    )
    ch_versions = ch_versions.mix(ANNOTATE_INDELS.out.versions)

    emit:
    vcf  = ANNOTATE_INDELS.out.vcf // channel: [ val(meta), path(vcf) ]
    tbi  = ANNOTATE_INDELS.out.tbi // channel: [ val(meta), path(tbi) ]
    versions = ch_versions         // channel: [ path(versions.yml) ]
}
