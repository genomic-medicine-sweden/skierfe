//
// A subworkflow to score and rank variants.
//

include { GENMOD_ANNOTATE  } from '../../../modules/nf-core/genmod/annotate/main'
include { GENMOD_MODELS    } from '../../../modules/nf-core/genmod/models/main'
include { GENMOD_SCORE     } from '../../../modules/nf-core/genmod/score/main'
include { GENMOD_COMPOUND  } from '../../../modules/nf-core/genmod/compound/main'
include { BCFTOOLS_SORT    } from '../../../modules/nf-core/bcftools/sort/main'

workflow RANK_VARIANTS {

    take:
    ch_vcf                       // channel: [mandatory] [ val(meta), path(vcf) ]
    ch_ped                       // channel: [mandatory] [ val(meta), path(ped) ]
    ch_genmod_reduced_penetrance // channel: [mandatory] [ val(meta), path(pentrance) ]
    ch_score_config              // channel: [mandatory] [ val(meta), path(ini) ]

    main:
    ch_versions = Channel.empty()

    GENMOD_ANNOTATE ( ch_vcf )
    ch_versions = ch_versions.mix(GENMOD_ANNOTATE.out.versions)

    GENMOD_ANNOTATE.out.vcf
        .join( ch_ped, failOnMismatch: true )
        .set { genmod_models_in }

    GENMOD_MODELS (
        genmod_models_in,
        ch_genmod_reduced_penetrance.map { _meta, file -> file }
    )
    ch_versions = ch_versions.mix(GENMOD_MODELS.out.versions)

    GENMOD_MODELS.out.vcf
        .join( ch_ped, failOnMismatch: true )
        .set { genmod_score_in }

    GENMOD_SCORE (
        genmod_score_in,
        ch_score_config.map { _meta, file -> file }
    )
    ch_versions = ch_versions.mix(GENMOD_SCORE.out.versions)

    GENMOD_COMPOUND ( GENMOD_SCORE.out.vcf )
    ch_versions = ch_versions.mix(GENMOD_COMPOUND.out.versions)

    BCFTOOLS_SORT ( GENMOD_COMPOUND.out.vcf )
    ch_versions = ch_versions.mix(BCFTOOLS_SORT.out.versions)

    emit:
    vcf      = BCFTOOLS_SORT.out.vcf // channel: [ val(meta), path(vcf) ]
    tbi      = BCFTOOLS_SORT.out.tbi // channel: [ val(meta), path(tbi) ]
    versions = ch_versions           // channel: [ path(versions.yml) ]
}
