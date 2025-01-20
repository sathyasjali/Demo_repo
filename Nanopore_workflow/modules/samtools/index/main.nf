#! /usr/bin/env nextflow

/*
 * Genrate BAM_inex file
 */
 
 process SAMTOOLS_INDEX {

    publishDir params.outdir, mode: 'copy'

    input:
        path input_sam

    output:
        path "${input_sam.baseName}.sorted.bam"
        path "${input_sam.baseName}.sorted.bam.bai"

    script:
    """
    samtools view -Sb '${input_sam}' > '${input_sam.baseName}.bam'
    samtools sort '${input_sam.baseName}.bam' -o '${input_sam.baseName}.sorted.bam'
    samtools index '${input_sam.baseName}.sorted.bam'
    """
}