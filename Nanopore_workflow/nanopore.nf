#! /usr/bin/env nextflow

// Import modules
include { MINIMAP2_ALIGN } from './modules/minimap2/align/main.nf'

include { SAMTOOLS_INDEX } from './modules/samtools/index/main.nf'

workflow {
    // creating channel for inputs
    reads_ch = Channel.fromPath(params.input_fastq)
    reference_ch = Channel.fromPath(params.reference_fa_path)

    // align reads using minimap2
    align_ch = MINIMAP2_ALIGN(reads_ch, reference_ch)

    // create index file for aligned sam file
    SAMTOOLS_INDEX(align_ch)
}