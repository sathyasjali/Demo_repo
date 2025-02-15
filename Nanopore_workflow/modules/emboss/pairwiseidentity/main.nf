#! /usr/bin/env nextflow

/*
 * Genrate pairwise alignment sequence
 */
 
process EMBOSS_NEEDLE {
    input:
    path reference_fa_path from params.reference_fa_path
    path consensus_fa_path from params.consensus_fa_path

    output:
    path "${params.outdir}/alignment.needle"

    script:
    """
    mkdir -p ${params.outdir}
    needle -asequence ${reference_fa_path} -bsequence ${consensus_fa_path} -gapopen 10 -gapextend 0.5 -outfile ${params.outdir}/alignment.needle
    """
}