process SAMTOOLS_MERGE {
    tag "$meta.id"
    label 'process_medium'

    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/samtools:1.20--h50ea8bc_0' :
        'biocontainers/samtools:1.20--h50ea8bc_0' }"

    input:
    tuple val(meta), path(input_files, stageAs: "?/*")
    tuple val(meta2), path(fasta)
    tuple val(meta3), path(fai)
    val(index_type)
    
    output:
    tuple val(meta), path("${prefix}.bam")  , optional:true, emit: bam
    tuple val(meta), path("${prefix}.cram") , optional:true, emit: cram
    tuple val(meta), path("*.${index_type}"), optional:true, emit: index
    tuple val(meta), path("*.crai")         , optional:true, emit: crai
    path  "versions.yml"                                   , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args   ?: ''
    prefix   = task.ext.prefix ?: "${meta.id}"
    def file_type = input_files instanceof List ? input_files[0].getExtension() : input_files.getExtension()
    def reference = fasta ? "--reference ${fasta}" : ""
    """
    samtools \\
        merge \\
        --threads ${task.cpus-1} \\
        $args \\
        ${reference} \\
        ${prefix}.${file_type}##idx##${prefix}.${file_type}.${index_type} \\
        $input_files

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        samtools: \$(echo \$(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*\$//')
    END_VERSIONS
    """

    stub:
    def args = task.ext.args   ?: ''
    prefix = task.ext.suffix ? "${meta.id}${task.ext.suffix}" : "${meta.id}"
    def file_type = input_files instanceof List ? input_files[0].getExtension() : input_files.getExtension()
    def index = args.contains("--write-index") ? "touch ${prefix}.${file_type}.${index_type}" : ""
    """
    touch ${prefix}.${file_type}.${index_type}
    ${index}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        samtools: \$(echo \$(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*\$//')
    END_VERSIONS
    """
}
