#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=100g
#SBATCH --time=10:30:00
#SBATCH --job-name=STARindex
#SBATCH --output=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.out
#SBATCH --error=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mbxqa5@nottingham.ac.uk

source $HOME/.bash_profile
conda activate star

STAR --runMode genomeGenerate --genomeDir /share/BioinfMSc/rotation2/group3/human/STAR \
            --genomeFastaFiles /share/BioinfMSc/rotation2/group3/human/ref/humanref.fa \
            --sjdbGTFfile /share/BioinfMSc/rotation2/group3/human/ref/humanref.gtf \
            --sjdbOverhang 100 --outFileNamePrefix STAR
conda deactivate

