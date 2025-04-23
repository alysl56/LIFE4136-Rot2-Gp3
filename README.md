## Overview
LIFE4136 Round 2 Group 3 This repository contains the scripts used by Group 3 when completing Round 2 of the LIFE4136 Group Project module. This project is divided into two parts: Project1 and Project2.
## Project1
## Introduction
This project is centered around a parasitic disease that seriously affects human health, Human African Trypanosomiasis (HAT). It aims to enable students to understand the process of generating RNA sequencing (RNA-Seq) data and master the analysis process to analyze the differences in gene expression of the parasite Trypanosoma brucei under different stages or environmental conditions. The following code shows the sequence of steps to achieve this goal. Please note that most steps require software packages. You can use a separate Conda environment to use these packages.
## Methods
1. QC sequencing
QCing the blood files and fat files to get an idea of ​​sequence length, data quality and adapter contamination). Use fastqc for quality control. Use the following method to install it into the Conda environment:
conda install bioconda::fastqc
- [qc1.sh script](Project1/qc1.sh): Performs quality control.

2.Trim reads
Use trim_galore to properly trim the above dataset (remove adapter sequences and trim low-quality reads) for mapping. The trimming process is performed using the trim-galore package. Install it into the Conda environment using the following method:
conda install bioconda::trim-galore
Use the following script to trim the above data: - [trim.sh script]![image](https://github.com/user-attachments/assets/1ed37d01-db86-468d-b43c-3a16395b6d86)

