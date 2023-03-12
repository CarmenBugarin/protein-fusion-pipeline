#!/bin/bash -l
#SBATCH --job-name=arriba                         
#SBATCH --nodes=1                                    
#SBATCH --ntasks=16                                    
#SBATCH --partition brc                              
#SBATCH --mem=1G


module load apps/samtools


DIR='/scratch/users/myuser/RNA_seq/bams/'$2'/'


bn=$(basename $1)

samtools view -c -F 4 $DIR$1'Aligned.sortedByCoord.out.bam' | awk -vbn=$bn 'END{print bn, $1}' | sort -k1 >> $2'_align_reads.txt'
