include { CRAMINO  } from '../../modules/local/cramino'
include { FASTQC   } from '../../modules/nf-core/fastqc/main'
include { MOSDEPTH } from '../../modules/nf-core/mosdepth/main.nf'

workflow QC_ALIGNED_READS {

    take:
    ch_bam_bai // channel: [ val(meta), [bam, bai] ]
    ch_fasta   // channel: [ val(meta), fasta ]
    ch_bed     // channel: [ val(meta), bed ]

    main:
    ch_versions = Channel.empty()

    FASTQC ( ch_bam_bai.map { meta, bam, _bai -> [ meta, bam ] } )
    ch_versions = ch_versions.mix(FASTQC.out.versions)

    CRAMINO (ch_bam_bai)
    ch_versions = ch_versions.mix(CRAMINO.out.versions)

    ch_bam_bai
        .combine( ch_bed.map { it[1] }.toList() ) // toList() enables passing [] if ch_bed is empty
        .set { mosdepth_in }

    MOSDEPTH ( mosdepth_in, ch_fasta )
    ch_versions = ch_versions.mix(MOSDEPTH.out.versions)

    emit:
    fastqc_zip           = FASTQC.out.zip           // channel: [ val(meta), path(zip) ]
    mosdepth_summary     = MOSDEPTH.out.summary_txt // channel: [ val(meta), path(txt) ]
    mosdepth_global_dist = MOSDEPTH.out.global_txt  // channel: [ val(meta), path(txt) ]
    mosdepth_region_dist = MOSDEPTH.out.regions_txt // channel: [ val(meta), path(txt) ]
    versions             = ch_versions              // channel: [ versions.yml ]
}

