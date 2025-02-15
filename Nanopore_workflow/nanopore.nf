#! /usr/bin/env nextflow

// Include modules
include { REFERENCE_INDEX } from './modules/reference/index/main.nf'
include { MINIMAP2_ALIGN } from './modules/minimap2/align/main.nf'
include { SAMTOOLS_INDEX } from './modules/samtools/index/main.nf'
include { BCFTOOLS_VCF } from './modules/bcftools/vcf/main.nf'
include {EMBOSS_NEEDLE } from './modules/emboss/pairwiseidentity/main.nf'
//include { SAMTOOLS_QUANT } from './modules/samtocounts/quant/main.nf'
//include { EMBOSS_NEEDLE } from './modules/emboss/pairwiseidentity/main.nf'


workflow {
    // creating channel for inputs
    reads_ch = Channel.fromPath(params.input_fastq)
    reference_ch = Channel.fromPath(params.reference_fa_path)
    refindex_ch = Channel.fromPath(params.ref_index)
    bam_ch = Channel.fromPath(params.input_bam)
    sorted_bam_ch = Channel.fromPath(params.input_sorted_bam)
    consensus_ch = Channel.fromPath(params.consensus_fa_path)
    
    // create index refrence
    ref_index = REFERENCE_INDEX(reference_ch)

    // align reads using minimap2
    align_ch = MINIMAP2_ALIGN(reads_ch, reference_ch)

    // create index file for aligned sam file
    sam_ch = SAMTOOLS_INDEX(align_ch, reference_ch)
    // call variants using bcftools
    vcf_ch = BCFTOOLS_VCF(sorted_bam_ch, reference_ch)

    align_ch = EMBOSS_NEEDLE(consensus_ch, reference_ch)
    }