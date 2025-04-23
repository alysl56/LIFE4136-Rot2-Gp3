#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=200g
#SBATCH --time=24:30:00
#SBATCH --job-name=alignment_jy
#SBATCH --output=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.out
#SBATCH --error=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mbxjy4@nottingham.ac.uk

source $HOME/.bash_profile
conda activate STAR

for i in {60..74}; do
  STAR --runThreadN 8 \
       --genomeDir /share/BioinfMSc/rotation2/group3/human/STAR \
       --readFilesIn /share/BioinfMSc/Bill_resources/Hsapiens/fastq/ERR14047${i}_1.fastq.gz \
                     /share/BioinfMSc/Bill_resources/Hsapiens/fastq/ERR14047${i}_2.fastq.gz \
       --readFilesCommand zcat \
       --outSAMtype BAM SortedByCoordinate \
       --quantMode GeneCounts \
       --outFileNamePrefix /share/BioinfMSc/rotation2/group3/human/STAR/Alignments/aln60_74/aln${i}_
done

conda deactivate

