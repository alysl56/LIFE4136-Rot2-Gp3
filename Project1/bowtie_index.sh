#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=50g
#SBATCH --time=02:00:00
#SBATCH --job-name=bowtie_index
#SBATCH --output=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.out
#SBATCH --error=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mbxqa5@exmail.nottingham.ac.uk

source $HOME/.bash_profile

conda activate bowtie2

# Building a large index
bowtie2-build --large-index /share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/ref/ref.fasta /share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/bowtie_index

conda deactivate

