#!/bin/bash
inputPath=$1
gene=$2
chr=$3
startPos=$4
stopPos=$5
outputDir=$6 # hold output_data/panc_bams
mainDir=/public/groups/kimlab/queenie/output_data/$7
fa=/public/groups/kimlab/queenie/genome_ref/GRCh38.p13.genome.fa

# $inputPath = data/panc_bams/Panc.10.1.0._Aligned.sorted.bam.etc

# Split by / first to get the bam file
IFS='/' read -ra ARR <<< "$inputPath"

# Split by _ to shorten bam file name
IFS='_' read -ra ARR <<< "${ARR[2]}"

# Make final directory of outputDir/panc_bams/Panc10.1.0
finalPath=$outputDir/${ARR[0]}

mkdir $finalPath

# use ARR[0] instead of variantOutput -> panc10.1.0.$gene.bam etc

fileName=${ARR[0]}

samtools view -b -h $inputPath "$chr:$startPos-$stopPos" -o $fileName.$gene.bam
samtools sort $fileName.$gene.bam -o $fileName.$gene.sorted.bam
samtools index $fileName.$gene.sorted.bam
freebayes -f $fa $fileName.$gene.sorted.bam > $fileName.$gene.vcf


# Move files into created directory

mv *.bam $finalPath
mv *.bam.bai $finalPath
mv *.vcf $finalPath



# sh variantCaller.sh inputPath KRAS chr12 25245351 25245351 outputDir
