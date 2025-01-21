include { ADD_FOUND_IN_TAG                } from '../../../modules/local/add_found_in_tag/main'
include { CLEAN_SNIFFLES                  } from '../../../modules/local/clean_sniffles/main'
include { SVDB_MERGE                      } from '../../../modules/nf-core/svdb/merge/main'
include { BCFTOOLS_QUERY                  } from '../../../modules/nf-core/bcftools/query/main'
include { BCFTOOLS_REHEADER               } from '../../../modules/nf-core/bcftools/reheader/main'
include { CREATE_SAMPLES_FILE             } from '../../../modules/local/create_samples_file/main'
include { SEVERUS                         } from '../../../modules/nf-core/severus/main'
include { SNIFFLES                        } from '../../../modules/nf-core/sniffles/main'
include { TABIX_TABIX as TABIX_SVDB_MERGE } from '../../../modules/nf-core/tabix/tabix/main'

workflow CALL_SVS {

    take:
    ch_bam_bai        // channel [mandatory]: [ val(meta), path(bam), path(bai) ]
    sv_caller         //     val [mandatory]: Which caller to use
    ch_tandem_repeats // channel  [optional]: [ val(meta), path(bed) ]

    main:
    ch_versions = Channel.empty()
    ch_sv_calls = Channel.empty()

    // Here, we currently want the possiblity to run multiple SV-callers
    // even though only calls from one caller is used for annotation, ranking and filtering.
    // In the future these calls could possibly be merged.

    // Call SVs with Severus
    SEVERUS (
        ch_bam_bai.map { meta, bam, bai -> [ meta, bam, bai, [], [], [] ] },
        ch_tandem_repeats
    )
    ch_versions = ch_versions.mix(SEVERUS.out.versions)

    ch_sv_calls = ch_sv_calls.mix(
        SEVERUS.out.all_vcf
        .map { meta , vcf -> [ meta + [ sv_caller: 'severus' ], vcf ] }
    )

    // Call SVs with Sniffles
    SNIFFLES (
        ch_bam_bai
    )
    ch_versions = ch_versions.mix(SNIFFLES.out.versions)

    CLEAN_SNIFFLES (
        SNIFFLES.out.vcf
    )
    ch_versions = ch_versions.mix(CLEAN_SNIFFLES.out.versions)

    ch_sv_calls = ch_sv_calls.mix(
        CLEAN_SNIFFLES.out.vcf
        .map { meta , vcf -> [ meta + [ sv_caller: 'sniffles' ], vcf ] }
    )

    ch_sv_calls
        .multiMap { meta, vcf ->
            vcf: [ meta, vcf, [] ]
            sv_caller: meta.sv_caller
        }
        .set { ch_add_found_in_tag_input }

    // Annotate with FOUND_IN tag
    ADD_FOUND_IN_TAG (
        ch_add_found_in_tag_input.vcf,
        ch_add_found_in_tag_input.sv_caller,
    )
    ch_versions = ch_versions.mix(ADD_FOUND_IN_TAG.out.versions)

    // Get the sample name from the VCF
    // For Sniffles this is hardcoded as SAMPLE and for Severus it's based on the filename
    BCFTOOLS_QUERY (
        ADD_FOUND_IN_TAG.out.vcf.join(ADD_FOUND_IN_TAG.out.csi),
        [],
        [],
        []
    )
    ch_versions = ch_versions.mix(BCFTOOLS_QUERY.out.versions)

    // Creates a "vcf_sample_name meta.id" file for bcftools reheader
    CREATE_SAMPLES_FILE ( BCFTOOLS_QUERY.out.output )
    ch_versions = ch_versions.mix(CREATE_SAMPLES_FILE.out.versions)

    ADD_FOUND_IN_TAG.out.vcf
        .join( CREATE_SAMPLES_FILE.out.samples )
        .map { meta, vcf, samples -> [ meta, vcf, [], samples ] }
        .set { ch_bcftools_reheader_in }

    // Give meta.id as sample name in the VCF
    BCFTOOLS_REHEADER ( ch_bcftools_reheader_in, [[],[]] )
    ch_versions = ch_versions.mix(BCFTOOLS_REHEADER.out.versions)

    BCFTOOLS_REHEADER.out.vcf
        .map { meta, vcf -> [ [ 'id': meta.family_id, 'sv_caller': meta.sv_caller ], vcf ] }
        .groupTuple()
        .set { ch_svdb_merge_in }

    // Merge the files with new sample names
    SVDB_MERGE (
        ch_svdb_merge_in,
        [],
        true
    )
    ch_versions = ch_versions.mix(SVDB_MERGE.out.versions)

    TABIX_SVDB_MERGE ( SVDB_MERGE.out.vcf )
    ch_versions = ch_versions.mix(TABIX_SVDB_MERGE.out.versions)

    emit:
    sample_vcf = filterAndStripCaller(BCFTOOLS_REHEADER.out.vcf, sv_caller)   // channel: [ val(meta), path(vcf) ]
    sample_tbi = filterAndStripCaller(BCFTOOLS_REHEADER.out.index, sv_caller) // channel: [ val(meta), path(tbi) ]
    family_vcf = filterAndStripCaller(SVDB_MERGE.out.vcf, sv_caller)          // channel: [ val(meta), path(vcf) ]
    family_tbi = filterAndStripCaller(TABIX_SVDB_MERGE.out.tbi, sv_caller)    // channel: [ val(meta), path(tbi) ]
    versions   = ch_versions                                                  // channel: [ path(versions.yml) ]
}

def filterAndStripCaller(ch_vcf, caller) {
    ch_vcf.filter { meta, _vcf ->
            meta.sv_caller == caller
        }
        .map { meta, vcf ->
            [ meta - meta.subMap('sv_caller'), vcf ]
        }
}
