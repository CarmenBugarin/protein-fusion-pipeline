#!/bin/bash -l
#SBATCH --job-name=arriba                         
#SBATCH --nodes=1                                    
#SBATCH --ntasks=16                                    
#SBATCH --partition brc                              
#SBATCH --mem=30G


source /users/myuser/anaconda3/bin/activate arriba


if [ -d "/scratch/users/myuser/MRD_RNAseq/output/${2}/" ] 
then
    echo "Directory exists." 
else
    mkdir scratch/users/myuser/MRD_RNAseq/output/${2}/
fi


if [ -d "/scratch/users/myuser/MRD_RNAseq/Fusions/${2}" ] 
then
    echo "Directory exists." 
else
    mkdir /scratch/users/myuser/MRD_RNAseq/Fusions/${2}/
fi


arriba -x /scratch/users/myuser/MRD_RNAseq/bams/${2}/${1}Aligned.sortedByCoord.out.bam -T -P -I \
-g /users/myuser/anaconda3/envs/arriba/var/lib/arriba/GENCODE28.gtf.gz \
-a /users/myuser/anaconda3/envs/arriba/var/lib/arriba/hg38.fa.gz \
-b /users/myuser/anaconda3/envs/arriba/var/lib/arriba/blacklist_hg38_GRCh38_2018-11-04.tsv.gz  \
-o /scratch/users/myuser/MRD_RNAseq/output/${2}/${1}.tsv -O /scratch/users/myuser/MRD_RNAseq/output/${2}/${1}.discarded.tsv



##########################################
### Drawing translocations
##########################################


./draw_fusions.R \
--fusions=/scratch/users/myuser/MRD_RNAseq/output/${2}/${1}.tsv \
--alignments=/scratch/users/myuser/MRD_RNAseq/bams/${2}/${1}Aligned.sortedByCoord.out.bam  \
--output=/scratch/users/myuser/MRD_RNAseq/Fusions/${2}/${1}.pdf \
--annotation=/users/myuser/anaconda3/envs/arriba/var/lib/arriba/GENCODE28.gtf.gz \
--cytobands=/users/myuser/anaconda3/envs/arriba/var/lib/arriba/cytobands_hg38_GRCh38_2018-02-23.tsv \
--proteinDomains=/users/myuser/anaconda3/envs/arriba/var/lib/arriba/protein_domains_hg38_GRCh38_2019-07-05.gff3

