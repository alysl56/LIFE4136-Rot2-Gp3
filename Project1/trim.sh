#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=50g
#SBATCH --time=04:30:00
#SBATCH --job-name=gp3trimfat
#SBATCH --output=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.out
#SBATCH --error=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mbxqa5@exmail.nottingham.ac.uk

source $HOME/.bash_profile

conda activate rotation2

trim_galore /share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/Fat*.fastq.gz -o /share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/trims -q 28 --length 40

