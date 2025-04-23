#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=300g
#SBATCH --time=48:00:00
#SBATCH --job-name=htseq-count_blood
#SBATCH --output=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/htseq-count/htseq-count-blood.txt
#SBATCH --error=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mbxjy4@exmail.nottingham.ac.uk

source $HOME/.bash_profile

conda activate Rotation2

htseq-count /share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/mapped/bloodmapped.sam /share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/ref/ref.gff

conda deactivate
