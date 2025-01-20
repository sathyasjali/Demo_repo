#! /usr/bin/env nextflow
/*
 * Pipeline parameters
 */
params.input_fastq = "${projectDir}/data/reads/test_2.fastq"
params.reference_fa_path = "${projectDir}/data/reference/yeast_sk1.fasta"
params.outdir = "results"

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

process SAMTOOLS_INDEX {

    publishDir params.outdir, mode: 'copy'

    input:
        path input_sam

    output:
        path "${input_sam.baseName}.bam"
        path "${input_sam.baseName}.bam.bai"

    script:
    """
    samtools view -Sb '${input_sam}' > '${input_sam.baseName}.bam'
    samtools sort '${input_sam.baseName}.bam' -o '${input_sam.baseName}.sorted.bam'
    samtools index '${input_sam.baseName}.sorted.bam'
    mv '${input_sam.baseName}.sorted.bam.bai' '${input_sam.baseName}.bam.bai'
    mv '${input_sam.baseName}.sorted.bam' '${input_sam.baseName}.bam'
    """
}

workflow {
    // creating channel for inputs
    reads_ch = Channel.fromPath(params.input_fastq)
    reference_ch = Channel.fromPath(params.reference_fa_path)

    // align reads using minimap2
    align_ch = MINIMAP2_ALIGN(reads_ch, reference_ch)

    // create index file for aligned sam file
    SAMTOOLS_INDEX(align_ch)
}