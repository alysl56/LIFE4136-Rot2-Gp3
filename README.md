## Overview
LIFE4136 Round 2 Group 3 This repository contains the scripts used by Group 3 when completing Round 2 of the LIFE4136 Group Project module. This project is divided into two parts: Project1 and Project2.
## Project1
## Introduction
This project is centered around a parasitic disease that seriously affects human health, Human African Trypanosomiasis (HAT). It aims to enable students to understand the process of generating RNA sequencing (RNA-Seq) data and master the analysis process to analyze the differences in gene expression of the parasite Trypanosoma brucei under different stages or environmental conditions. The following code shows the sequence of steps to achieve this goal. Please note that most steps require software packages. You can use a separate Conda environment to use these packages.
## Methods
1.QC sequencing
QCing the blood files and fat files to get an idea of ​​sequence length, data quality and adapter contamination). Use fastqc for quality control. Use the following method to install it into the Conda environment:
conda install bioconda::fastqc
- [qc1.sh script](Project1/qc1.sh): Performs quality control.

2.Trim reads
Use trim_galore to properly trim the above dataset (remove adapter sequences and trim low-quality reads) for mapping. The trimming process is performed using the trim-galore package. Install it into the Conda environment using the following method:
conda install bioconda::trim-galore
Use the following script to trim the above data: 
- [trim.sh script](Project1/trim.sh)

3.Align to reference genome
Use bowtie2-build to create bowtie index for mapping. Use bowtie2 package to do this. Install into Conda environment using:
conda install bioconda::bowtie2
Script used: 
- [bowtie_index.sh script](Project1/bowtie_index.sh)

4.Use bowtie2 to map each of the above trimmed fastq files onto the T.brucei genome and create a gzip compressed SAM file as output.
Use the following script:
- [bloodmapped.sh](Project1/bloodmapped.sh)
- [fatmapped.sh](Project1/fatmapped.sh)
- [allmapped.sh](Project1/allmapped.sh)
- [groupmapped.sh](Project1/groupmapped.sh)

5.Read visualization
Install the GUI-based genome viewer IGV and use it to view the distribution of mapped reads for one or more samples in chromosome 1 (Tb927_01_v5.1)
6. Read counts
Use htseq-count to count the number of reads mapped to each gene in the genome. This is done using the htseq-count(v0.11.2)
 package. Install into a Conda environment using:
conda install bioconda::htseq

a.Pcg only (only count for the amount of the sequences for the protein code and genes)
Script used:
- [pcg_all_count.sh](Project1/pcg_all_count.sh)
- [pcg_blood_count.sh](Project1/pcg_blood_count.sh)
- [pcg_fat_count.sh](Project1/pcg_fat_count.sh)

b.Count the reads mapped to each gene in the genome using htseq-count
Scripts used:
- [htseq-count_blood.sh](Project1/htseq-count_blood.sh)
- [htseq-count_fat.sh](Project1/htseq-count_fat.sh)

c.individualpcg_counts
Scripts used:
- [blood_ind_count.sh](Project1/blood_ind_count.sh)
- [fat_ind_count.sh](Project1/fat_ind_count.sh)

7. Find sample outliers
The dataset was loaded into R using the sample table and DESeq2 (v1.34.0)
, and samples that should be excluded were further analyzed.
- [rot2script](Project1/rot2script) used - [Counts1](Project1/Counts1) and showed that Blood6 was an outlier.

Therefore, we used - [rot2script_notb6.R](Project1/rot2script_notb6.R) which cused - [Counts2](Project1/Counts2) (doesn't include Blood6) and that produced the .tsv files we used for gene ontology analysis

## Project2
## Introduction
By analyzing RNA-Seq data from different types of human cancer in public databases, we can identify genes that are significantly differentially expressed under different biological conditions. This study will compare cancer cells from men and women.
## Methods
1.Build a STAR index for the genome. Use the star(v2.7.9a)
 package. Install into the Conda environment using:
conda install bioconda::star
Scripts used:
- [STARindex.sh](Project2/STARindex.sh)

2.Align each sample to the genome index
Scripts used:
- [alignment1.sh](Project2/alignment1.sh)

3.Use DESeq2 to analyse differential expression between your conditions
We used - [part2_averaged.R](Project2/part2_averaged.R) script which used the - [averaged1.txt](Project2/averaged1.txt) file. This produced the .tsv files which we used for gene ontology analysis

## Contributors
All scripts and analysis were completed jointly with Josh and Quayyum Abdullahi, thank you both!!
