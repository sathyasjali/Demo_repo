#!/bin/bash -ue
minimap2 -ax map-ont --secondary=no -k8 'yeast_sk1.fasta' 'test_2.fastq' > 'test_2.sam'
