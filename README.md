# protein-fusion-pipeline

Requirements:

    - samtools
    - arriba
    

Create a conda environment with the required packages:

```bash
conda config --add channels r
conda config --add channels bioconda
conda config --add channels conda-forge

conda create --n arriba
conda activate arriba

conda install -c bioconda arriba
conda install -c bioconda samtools
```

Run the pipeline

```bash
qsub ExtractSamples.sh batchid

list=$(cat samples_batchid.txt )

for l in $list; do echo ${l}; qsub Alignment.sh ${l} batchid; done

for l in $list; do echo ${l}; qsub ProteinCalling.sh ${l} batchid; done

for l in $list; do echo ${l}; qsub CheckAlignReads.sh ${l} batchid; done
```

>NOTE:https://arriba.readthedocs.io/en/latest/quickstart/