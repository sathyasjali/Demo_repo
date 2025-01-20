#! /usr/bin/env nextflow

/*
 * Genrate sam file after mapping
 */

process MINIMAP2_ALIGN {

    publishDir params.outdir, mode: 'copy'

    input:
        path input_fastq
        path reference_fa

    output:
        path "${input_fastq.baseName.replaceAll('.fastq$', '')}.sam"

    script:
    """
    minimap2 -ax map-ont --secondary=no -k8 '${reference_fa}' '${input_fastq}' > '${input_fastq.baseName.replaceAll('.fastq$', '')}.sam'
    """
}