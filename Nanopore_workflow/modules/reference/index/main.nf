/*
 * Genrate reference_index file
 */
 
 process REFERENCE_INDEX {

    publishDir params.outdir, mode: 'copy'

    input:
        path reference_fa_path

    output:
        path "${reference_fa_path.baseName}.fasta.fai"

    script:
    """
    samtools faidx "${reference_fa_path}"
    """
}