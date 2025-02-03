#! /usr/bin/env nextflow

/*
 * Generate vcf file
 */
 
 process BCFTOOLS_VCF {

    publishDir params.outdir, mode: 'copy'

    input:
        path input_sorted_bam
        path reference_fa_path
        path input_mpileup

    output:
        path "${input_sorted_bam.baseName}.vcf"

    script:
    """
    bcf mpileup -f ${reference_fa_path} ${input_sorted_bam} > ${input_sorted_bam.baseName}.mpileup \
    bcftools view ${input_sorted_bam.baseName}.mpileup -Ob -o ${input_sorted_bam.baseName}.bcf \
    bcftools call -c ${input_sorted_bam.baseName}.bcf -mv -Ov -o ${input_sorted_bam.baseName}.vcf ${input_sorted_bam.baseName}.bcf
    """
}
