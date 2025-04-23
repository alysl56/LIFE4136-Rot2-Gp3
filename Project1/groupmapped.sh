#SBATCH --mail-user=mbxqa5@nottingham.ac.uk

source $HOME/.bash_profile
INPUT="/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/trims"
OUTPUT="/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/mapping/fatmapped"
REFERENCE= "/share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/bowtie_index/index"

conda activate bowtie2

for FILE in "$INPUT"/Fat*.fq.gz; do
   BASENAME=$(basename "$FILE")
   OUTPUT_FILE="$OUTPUT/${BASENAME}.sam"

   bowtie2 -x /share/BioinfMSc/Bill_resources/Tbrucei/fastq/Group3/bowtie_index/index/bowtie_index -U "$FILE" -N 1 -p 6 -S "$OUTPUT_FILE"
   echo "Processed $FILE -> $OUTPUT_FILE"
done

echo "All files processed."

conda deactivate
