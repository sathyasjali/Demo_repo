#! /usr/bin/env nextflow

/*
 * Genrate BAM_inex file
 */
 
 process SAMTOOLS_INDEX {

    publishDir params.outdir, mode: 'copy'

    input:
        path input_sam
        path reference_fa_path
        

    output:
        path "${input_sam.baseName}.bam"
        path "${input_sam.baseName}.sorted.bam"
        path "${input_sam.baseName}.sorted.bam.bai"
        path "${input_sam.baseName}.txt"
        

    script:
    """
    samtools view -Sb '${input_sam}' > '${input_sam.baseName}.bam'
    samtools sort '${input_sam.baseName}.bam' -o '${input_sam.baseName}.sorted.bam'
    samtools index '${input_sam.baseName}.sorted.bam'
    samtools flagstat '${input_sam.baseName}.bam' > '${input_sam.baseName}.txt'
    """
}