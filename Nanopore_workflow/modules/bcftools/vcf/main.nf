#! /usr/bin/env nextflow

/*
 * Generate vcf file
 */
 
 process BCFTOOLS_VCF {
    
    // Using 'copy' mode to ensure the output files are copied to the output directory
    publishDir params.outdir, mode: 'copy'

    input:
        path input_sorted_bam
        path reference_fa_path
        path ref_index
        path input_sorted_bam_bai

    output:
        path "${input_sorted_bam.baseName}.vcf"

    script:
        """
        echo "Running BCFTOOLS_VCF with input_sorted_bam=${input_sorted_bam} and reference_fa_path=${reference_fa_path}"
        bcftools mpileup -Ou -f '${reference_fa_path}' -d 0 '${input_sorted_bam}' | bcftools call -mv -Ov -o '${input_sorted_bam.baseName}.vcf'
        """
}
