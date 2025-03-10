# Pandora-genome
Pandora assembly to annotation

## Oxford nanopore reads
Sanatized basecalled reads ( removes formatting/parsing errors ) to avoid errors in other programs downstream.
```
seqkit sana /lustre/isaac/scratch/madler5/blue_pandora_seq/gDNA_pacbio_ONT/ONT_20241202/calls_2024-12-02_T17-20-58.fastq -o /lustre/isaac/scratch/madler5/blue_pandora_seq/Genome_Assembly/ONT_sanatized/calls-sanatized.fastq
```
Genome size estimation with jellyfish and genomescope

> Jellyfish was used to generate initial k-mer counts and histogram file by concatenating ONT reads and hic reads into a single file
```
jellyfish count -m 21 -s 100M -t 40 -C /lustre/isaac/scratch/jtorre28/telomere/pair-ul.fq
```
histogram text file
```
jellyfish histo -t 30 mer_counts.jf > /lustre/isaac/scratch/jtorre28/telomere/pair-ul.histo
```

21-mer histogram file was then visualized with Genomescope web browser tool

![image](https://github.com/user-attachments/assets/57134b77-16dd-422c-a0b4-c8da8e092f6b)


## Assembly with HiFiasm
Oxford nanopore reads, pacbio hifi reads, and pacbio HiC reads were assembled using HiFiasm
```
./hifiasm -o pacbio-ont-sana-hic-1 -t 48 -l 3 -s 0 --ul /lustre/isaac/scratch/madler5/blue_pandora_seq/basecalling/fastqs/calls-sanatized.fastq.gz --h1 /lustre/isaac/scratch/madler5/blue_pandora_seq/Genome_Assembly/hifiasm/hic/blue-pand-hic_1495777/blue-pand-hic_1495777_S3HiC_R1.fastq.gz,/lustre/isaac/scratch/madler5/blue_pandora_seq/Genome_Assembly/hifiasm/hic/blue-pand-hic_1496192/blue-pand-hic_1496192_S3HiC_R1.fastq.gz --h2 /lustre/isaac/scratch/madler5/blue_pandora_seq/Genome_Assembly/hifiasm/hic/blue-pand-hic_1495777/blue-pand-hic_1495777_S3HiC_R2.fastq.gz,/lustre/isaac/scratch/madler5/blue_pandora_seq/Genome_Assembly/hifiasm/hic/blue-pand-hic_1496192/blue-pand-hic_1496192_S3HiC_R2.fastq.gz /lustre/isaac/scratch/madler5/blue_pandora_seq/gDNA_pacbio_ONT/PacBio_Hifi_20250103/blue_pand_pacbio.fasta.gz 2> /lustre/isaac/scratch/madler5/blue_pandora_seq/Genome_Assembly/hifiasm/pacbio_ont-sana-hic-1.log
```

## Assembly of hifi reads with wtdbg
hifi reads were also assembled with wtdbg2 to merge later with quickmerge

```
wtdbg2 -i /lustre/isaac/scratch/madler5/blue_pandora_seq/gDNA_pacbio_ONT/PacBio_Hifi_20250103/blue_pand_pacbio.fasta -o pandora-wtd -t 45 -g 3.5g -x sq
```

## Assembly of HiFi reads with HiCanu
hifi reads were also assembled with hicanu to merge later with quickmerge

```
canu -p pandora-hi -d /lustre/isaac/scratch/madler5/blue_pandora_seq/Genome_Assembly/hicanu genomeSize=3500m utgReAlign=true overlapper=mhap -pacbio-hifi /lustre/isaac/scratch/madler5/blue_pandora_seq/gDNA_pacbio_ONT/PacBio_Hifi_20250103/blue_pand_pacbio.fasta.gz usegrid=false
```



