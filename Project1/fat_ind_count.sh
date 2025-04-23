#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=200g
#SBATCH --time=10:30:00
#SBATCH --job-name=ind_fatcount
#SBATCH --output=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.out
#SBATCH --error=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mbxjy4@nottingham.ac.uk

source $HOME/.bash_profile
INPUT="/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/mapping/fatmapped"
OUTPUT="/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/htseq-count/individualpcg_counts"

conda activate Rotation2

for FILE in "$INPUT"/Fat*.sam; do
   BASENAME=$(basename "$FILE".fq.gz)
   OUTPUT_FILE="$OUTPUT/${BASENAME}count.txt"

htseq-count -f sam -r pos -s no -i ID -t protein_coding_gene "$FILE" /share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/ref/ref.gff > "$OUTPUT_FILE" 
done

echo "All files processed."
