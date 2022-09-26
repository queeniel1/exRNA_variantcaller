#!/bin/bash
bam_folder=$1
outputPath=$2

IFS='/' read -ra ARR <<< "$bam_folder"

mkdir $outputPath/${ARR[1]}

for bam in $bam_folder/*.bam
do
        sh variantCaller.sh $bam KRAS chr12 25245351 25245351 $outputPath/${ARR[1]}
done



# sh multiVariantCaller.sh data/bam_folder output_data
