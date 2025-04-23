
#!/bin/bash

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=50g
#SBATCH --time=02:30:00
#SBATCH --job-name=gp3qc
#SBATCH --output=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.out
#SBATCH --error=/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/logs/slurm-%x-%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mbxjy4@exmail.nottingham.ac.uk

source $HOME/.bash_profile

conda activate Rotation2

fastqc --fastq Blood1.fastq.gz Blood2.fastq.gz Blood3.fastq.gz Blood4.fastq.gz Blood5.fastq.gz Blood6.fastq.gz Fat1.fastq.gz Fat2.fastq.gz Fat3.fastq.gz -o qc_check

conda deactivate

