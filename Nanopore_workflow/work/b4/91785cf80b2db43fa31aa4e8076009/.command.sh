#!/bin/bash -ue
samtools view -Sb 'test_2.sam' > 'test_2.bam'
samtools sort 'test_2.bam' -o 'test_2.sorted.bam'
samtools index 'test_2.sorted.bam'
