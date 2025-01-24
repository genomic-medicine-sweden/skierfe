include { SAMTOOLS_IMPORT } from '../../modules/nf-core/samtools/import/main'
include { SAMTOOLS_FASTQ } from '../../modules/nf-core/samtools/fastq/main'

workflow CONVERT_INPUT_FILES {

    take:
    ch_sample     // channel: [ val(meta), reads ]
    convert_bam   // bool
    convert_fastq // bool

    main:
    ch_versions = Channel.empty()

    ch_sample
        .branch { _meta, reads ->
            fastq: reads.extension == 'gz'
            bam: reads.extension == 'bam'
        }
        .set { ch_filetypes }

    ch_bam   = ch_filetypes.bam
    ch_fastq = ch_filetypes.fastq

    if(convert_bam) {
        SAMTOOLS_FASTQ ( ch_filetypes.bam, false )
        ch_versions = ch_versions.mix(SAMTOOLS_FASTQ.out.versions)

        // Mix converted files back in
        ch_fastq = ch_fastq.mix(SAMTOOLS_FASTQ.out.other)
    }
    if(convert_fastq) {
        SAMTOOLS_IMPORT ( ch_filetypes.fastq )
        ch_versions = ch_versions.mix(SAMTOOLS_IMPORT.out.versions)

        // Mix converted files back in
        ch_bam   = ch_bam.mix(SAMTOOLS_IMPORT.out.bam)
    }

    emit:
    bam      = ch_bam      // channel: [ val(meta), bam ]
    fastq    = ch_fastq    // channel: [ val(meta), fastq ]
    versions = ch_versions // channel: [ versions.yml ]
}

