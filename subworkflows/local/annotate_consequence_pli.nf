//
// A subworkflow to add most severe consequence and pli to a vep annotated vcf
//

include { ADD_MOST_SEVERE_CSQ } from '../../modules/local/add_most_severe_consequence'
include { ADD_MOST_SEVERE_PLI } from '../../modules/local/add_most_severe_pli'
include { TABIX_BGZIPTABIX    } from '../../modules/nf-core/tabix/bgziptabix/main'

workflow ANNOTATE_CSQ_PLI {
    take:
    ch_vcf                  // channel: [mandatory] [ val(meta), path(vcf) ]
    ch_variant_consequences // channel: [mandatory] [ val(meta), path(consequences) ]

    main:
    ch_versions = Channel.empty()

    ADD_MOST_SEVERE_CSQ (ch_vcf, ch_variant_consequences)
    ch_versions = ch_versions.mix(ADD_MOST_SEVERE_CSQ.out.versions)

    ADD_MOST_SEVERE_PLI (ADD_MOST_SEVERE_CSQ.out.vcf)
    ch_versions = ch_versions.mix(ADD_MOST_SEVERE_PLI.out.versions)

    TABIX_BGZIPTABIX (ADD_MOST_SEVERE_PLI.out.vcf)
    ch_versions = ch_versions.mix(TABIX_BGZIPTABIX.out.versions)

    emit:
    vcf      = TABIX_BGZIPTABIX.out.gz_tbi.map { meta, vcf, _tbi -> [ meta, vcf ] } // channel: [ val(meta), path(vcf) ]
    tbi      = TABIX_BGZIPTABIX.out.gz_tbi.map { meta, _vcf, tbi -> [ meta, tbi ] } // channel: [ val(meta), path(tbi) ]
    versions = ch_versions                                                         // channel: [ path(versions.yml) ]
}
