include { ENSEMBLVEP_FILTERVEP          } from '../../../modules/nf-core/ensemblvep/filtervep/main'
include { BCFTOOLS_VIEW                 } from '../../../modules/nf-core/bcftools/view/main'
include { ENSEMBLVEP_VEP } from '../../../modules/nf-core/ensemblvep/vep/main.nf'

workflow FILTER_VARIANTS {

    take:
    ch_vcf      // channel  [optional] [ val(meta), path(vcf) ]
    ch_hgnc_ids // channel: [optional] [ val(meta), path(txt) ]
    filter_hgnc //    bool: should filter_vep be run to filter on hgnc ids

    main:
    ch_versions = Channel.empty()

    if ( filter_hgnc ) {

        ENSEMBLVEP_FILTERVEP (
            ch_vcf,
            ch_hgnc_ids.map { _meta, file -> file }
        )
        ch_versions = ch_versions.mix(ENSEMBLVEP_FILTERVEP.out.versions)

        ch_vcf = ENSEMBLVEP_FILTERVEP.out.output
    }

    BCFTOOLS_VIEW (
        ch_vcf.map { meta, vcf -> [ meta, vcf, [] ] },
        [],
        [],
        []
    )
    ch_versions = ch_versions.mix(BCFTOOLS_VIEW.out.versions)

    emit:
    vcf      = BCFTOOLS_VIEW.out.vcf // channel: [ val(meta), path(vcf) ]
    tbi      = BCFTOOLS_VIEW.out.tbi // channel: [ val(meta), path(tbi) ]
    versions = ch_versions           // channel: [ path(versions.yml) ]
}

