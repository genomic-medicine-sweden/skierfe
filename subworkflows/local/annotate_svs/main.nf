include { SVDB_QUERY                         } from '../../../modules/nf-core/svdb/query/main'
include { ENSEMBLVEP_VEP as ENSEMBLVEP_SV    } from '../../../modules/nf-core/ensemblvep/vep/main'
include { TABIX_TABIX as TABIX_ENSEMBLVEP_SV } from '../../../modules/nf-core/tabix/tabix/main'

workflow ANNOTATE_SVS {

    take:
    ch_vcf                // channel: [mandatory] [ val(meta), path(vcf) ]
    ch_fasta              // channel: [mandatory] [ val(meta), path(fasta) ]
    ch_sv_dbs             // channel: [mandatory] [ val(meta), path(csv) ]
    ch_vep_cache          // channel: [mandatory] [ path(cache) ]
    val_vep_cache_version //  string: [mandatory] default: 110
    ch_vep_extra_files    // channel: [mandatory] [ path(files) ]

    main:
    ch_versions = Channel.empty()

    ch_sv_dbs
        .map { _meta, csv -> csv }
        .splitCsv ( header:true )
        .multiMap { row ->
            vcf_dbs:  row.filename
            in_frqs:  row.in_freq_info_key
            in_occs:  row.in_allele_count_info_key
            out_frqs: row.out_freq_info_key
            out_occs: row.out_allele_count_info_key
        }
        .set { ch_svdb_in }

    // Annotate with SVDB VCF "databases"
    SVDB_QUERY (
        ch_vcf,
        ch_svdb_in.in_occs.toList(),
        ch_svdb_in.in_frqs.toList(),
        ch_svdb_in.out_occs.toList(),
        ch_svdb_in.out_frqs.toList(),
        ch_svdb_in.vcf_dbs.toList(),
        []
        )
        ch_versions = ch_versions.mix(SVDB_QUERY.out.versions)

    ENSEMBLVEP_SV (
        SVDB_QUERY.out.vcf.map { meta, vcf -> [ meta, vcf, [] ] },
        "GRCh38",
        "homo_sapiens",
        val_vep_cache_version,
        ch_vep_cache,
        ch_fasta,
        ch_vep_extra_files
    )
    ch_versions = ch_versions.mix(ENSEMBLVEP_SV.out.versions)

    TABIX_ENSEMBLVEP_SV (
        ENSEMBLVEP_SV.out.vcf
    )
    ch_versions = ch_versions.mix(TABIX_ENSEMBLVEP_SV.out.versions)

    emit:
    vcf      = ENSEMBLVEP_SV.out.vcf       // channel: [ val(meta), path(vcf) ]
    tbi      = TABIX_ENSEMBLVEP_SV.out.tbi // channel: [ val(meta), path(tbi) ]
    versions = ch_versions                 // channel: [ path(versions.yml) ]
}
