#! /usr/bin/env nextflow

/*
 * Genrate sam file after mapping
 */

process MINIMAP2_ALIGN {

    publishDir params.outdir, mode: 'copy'

    input:
        path input_fastq
        path reference_fa_path

    output:
        path "${input_fastq.baseName.replaceAll('.fastq$', '')}.sam"

    script:
    """
    minimap2 -ax map-ont --secondary=no -k5 '${reference_fa_path}' '${input_fastq}' > '${input_fastq.baseName.replaceAll('.fastq$', '')}.sam'
    """
}