include { ADD_FOUND_IN_TAG                       } from '../../../modules/local/add_found_in_tag/main'
include { TRGT_GENOTYPE                          } from '../../../modules/nf-core/trgt/genotype/main'
include { SAMTOOLS_INDEX as SAMTOOLS_INDEX_TRGT  } from '../../../modules/nf-core/samtools/index/main'
include { SAMTOOLS_SORT as SAMTOOLS_SORT_TRGT    } from '../../../modules/nf-core/samtools/sort/main'
include { BCFTOOLS_SORT as BCFTOOLS_SORT_TRGT    } from '../../../modules/nf-core/bcftools/sort/main'
include { TRGT_MERGE                             } from '../../../modules/nf-core/trgt/merge/main'
include { BCFTOOLS_INDEX                         } from '../../../modules/nf-core/bcftools/index/main'

workflow CALL_REPEAT_EXPANSIONS {

    take:
    ch_bam_bai  // channel: [mandatory] [ val(meta), path(bam), path(bai) ]
    ch_fasta    // channel: [mandatory] [ val(meta), path(fasta) ]
    ch_fai      // channel: [mandatory] [ val(meta), path(fai) ]
    ch_trgt_bed // channel: [mandatory] [ val(meta), path(bed) ]

    main:
    ch_versions         = Channel.empty()

    ch_bam_bai
        .map { meta, bam, bai -> [ meta, bam, bai, meta.sex == 1 ? 'XY' : 'XX' ] }
        .set { ch_trgt_input }

    // Run TGRT
    TRGT_GENOTYPE (
        ch_trgt_input,
        ch_fasta,
        ch_fai,
        ch_trgt_bed
    )
    ch_versions = ch_versions.mix(TRGT_GENOTYPE.out.versions)

    // Sort and index bam
    SAMTOOLS_SORT_TRGT (
        TRGT_GENOTYPE.out.bam,
        [[],[]]
    )
    ch_versions = ch_versions.mix(SAMTOOLS_SORT_TRGT.out.versions)

    SAMTOOLS_INDEX_TRGT ( SAMTOOLS_SORT_TRGT.out.bam )
    ch_versions = ch_versions.mix(SAMTOOLS_INDEX_TRGT.out.versions)

    // Add FOUND_IN=TRGT tag
    ADD_FOUND_IN_TAG (
        TRGT_GENOTYPE.out.vcf.map { meta, vcf -> [ meta, vcf, [] ] },
        "TRGT"
    )

    // Sort and index bcf
    BCFTOOLS_SORT_TRGT ( ADD_FOUND_IN_TAG.out.vcf )
    ch_versions = ch_versions.mix(BCFTOOLS_SORT_TRGT.out.versions)

    BCFTOOLS_SORT_TRGT.out.vcf
        .join( BCFTOOLS_SORT_TRGT.out.tbi )
        .map { meta, bcf, csi -> [ [ id : meta.family_id ], bcf, csi ] }
        .groupTuple()
        .set{ ch_trgt_merge_in }

    TRGT_MERGE (
        ch_trgt_merge_in,
        [[],[]],
        [[],[]],
    )
    ch_versions = ch_versions.mix(TRGT_MERGE.out.versions)

    BCFTOOLS_INDEX(
        TRGT_MERGE.out.vcf
    )
    ch_versions = ch_versions.mix(BCFTOOLS_INDEX.out.versions)


    emit:
    sample_vcf  = BCFTOOLS_SORT_TRGT.out.vcf  // channel: [ val(meta), path(vcf) ]
    sample_tbi  = BCFTOOLS_SORT_TRGT.out.tbi  // channel: [ val(meta), path(tbi) ]
    family_vcf  = TRGT_MERGE.out.vcf          // channel: [ val(meta), path(vcf) ]
    family_tbi  = BCFTOOLS_INDEX.out.tbi      // channel: [ val(meta), path(tbi) ]
    sample_bam  = SAMTOOLS_SORT_TRGT.out.bam  // channel: [ val(meta), path(bam) ]
    sample_bai  = SAMTOOLS_INDEX_TRGT.out.bai // channel: [ val(meta), path(bai) ]
    versions    = ch_versions                 // channel: [ versions.yml ]
}

