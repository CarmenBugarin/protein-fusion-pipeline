#!/bin/bash -l
#SBATCH --job-name=arriba                         
#SBATCH --nodes=1                                    
#SBATCH --ntasks=16                                    
#SBATCH --partition brc                              
#SBATCH --mem=1G



# Tidy up files and folders

cd ${1}/processed

mv Undetermined_S0_L001_R1_001.fastq.gz ${1}_Undetermined_S0_L001_R1_001.fastq.gz
mv Undetermined_S0_L001_R2_001.fastq.gz ${1}_Undetermined_S0_L001_R2_001.fastq.gz

ln  *_L001_R1_001.fastq.gz ../../fastq/
ln  *_L001_R2_001.fastq.gz ../../fastq/


# Create a file with ids from the lastest batch

ls | grep -v Interop | grep -v Stats | grep -v Reports | awk -F'_L001' '{print $1}' | grep -v ^Undetermined | sort -u > /scratch/users/myuser/RNA_seq/id_${1}.txt
