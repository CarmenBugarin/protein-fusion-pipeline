#!/bin/bash -l
#SBATCH --job-name=arriba                         
#SBATCH --nodes=1                                    
#SBATCH --ntasks=16                                    
#SBATCH --partition brc                              
#SBATCH --mem=40G


#########################################
### BAM file generation & index
##########################################

source /users/myuser/anaconda3/bin/activate arriba

module load apps/samtools/1.9.0-singularity


STAR --runThreadN 8 \
--runMode alignReads \
--genomeDir /users/myuser/anaconda3/envs/arriba/var/lib/arriba/STAR_index_hg38_GENCODE28 \
--outFileNamePrefix $1 \
--readFilesIn /scratch/users/myuser/RNA_seq/fastq/$1_L001_R1_001.fastq.gz /scratch/users/myuser/RNA_seq/fastq/$1_L001_R2_001.fastq.gz --readFilesCommand zcat \
--outSAMtype BAM SortedByCoordinate \
--outFilterMultimapNmax 1 --outFilterMismatchNmax 3 \
--chimSegmentMin 10 --chimOutType WithinBAM SoftClip --chimJunctionOverhangMin 10 --chimScoreMin 1 --chimScoreDropMax 30 --chimScoreJunctionNonGTAG 0 --chimScoreSeparation 1 --alignSJstitchMismatchNmax 5 -1 5 5 --chimSegmentReadGapMax 3 



samtools index $1Aligned.sortedByCoord.out.bam $1Aligned.sortedByCoord.out.bam.bai


if [ -d "bams/${2}" ] 
then
    echo "Directory bams/${2} exists." 
else
    mkdir bams/${2}
fi



mv $1Aligned.sortedByCoord.out.bam bams/${2}
mv $1Aligned.sortedByCoord.out.bam.bai bams/${2}
rm *.out
rm *.tab
