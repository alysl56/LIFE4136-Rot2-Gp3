#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=200g
#SBATCH --time=10:30:00
#SBATCH --job-name=bowtie_map_fat
#SBATCH --output=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.out
#SBATCH --error=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mbxjy4@exmail.nottingham.ac.uk

source $HOME/.bash_profile

cd /share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/trims

conda activate Bowtie2

bowtie2 -x /share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/bowtie_index/index/bowtie_index -U Fat*.fq.gz -N 1 -p 6 -S /share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/mapped/fatmapped.sam

conda deactivate

