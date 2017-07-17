#!/bin/bash
#
#PBS -l nodes=1:ppn=1
#PBS -l walltime=02:00:00
#

#script to extract required SNPs from Biobank PLINK files, merge them(as extracted from different chr separately), recode according
#to ref allele and make genetic risk score

#the SNP file to extract will need to be in your home directory
#run the file from your home directory
#make a new folder in home directory where we want extracted files to be put - change in script below
#prerequiste txt files which need to be in home directory (or other but need to specify): list of SNP rs numbers; 
#list of SNP rs number and risk alleles;


module load apps/plink-1.90

#lit of SNPs
snp_file="./Locke_SNPs_original_list.txt"

#PLINK files with ".nosex" suffix
rm_nosex="./biobank_bmi/plink_files/*nosex"

#list of chromosome files to be merged into single PLINK files
merge_list="./biobank_bmi/plink_files/chr_files.txt"

#output from chromosome merge
merged_snps="./biobank_bmi/bmi_snps_merged"

#output files from QC
snp_qc="./biobank_bmi/bmi_snps_merged_sample_QC"

flip_strand="./biobank_bmi/BMI_flip.txt"

force_allele="./biobank_bmi/BMI_ref_allele.txt"

#output files from --recode A
recoded_out="./biobank_bmi/bmi_snps_merged_recoded"

#input file with published beta estimates for each SNP
snp_score="./biobank_bmi/BMI_SNP_score.raw"

#output files for GRS
grs_out="./biobank_bmi/bmi_grs"


#mkdir ./biobank_bmi/plink_files

#create loop to go through each chr plink file

for i in {01..22}

do

plink --bfile /panfs/panasas01/shared-biobank/data/bestguess/data_chr${i} \
--extract ${snp_file} --make-bed --out ./biobank_bmi/plink_files/chr${i}

done

rm ${rm_nosex}

#Merge all extracted SNPs from chr together into one file - merging into chr1 so that is not in list


plink --bfile ./biobank_bmi/plink_files/chr01 --merge-list ${merge_list} --make-bed --out ${merged_snps}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Remove consent withdrawn, related individuals, Non-europeans, sex-mismatch, recommended exclusions, withdrawn consent
#generating txt files of both and then removing them using plink command

mkdir ./biobank_all/sample_QC

#relateds - /panfs/panasas01/shared-biobank/data/derived/unrelated_ids/data_exclusion.txt
#Non-Europeans - /projects/MRC-IEU/groups/biobank/derived/Lavinia/NonEuro_exclusion_list.txt
#Sex-mismatch - /projects/MRC-IEU/groups/biobank/derived/Lavinia/sex_mismatch.txt
#Recommended exclusions - /projects/MRC-IEU/groups/biobank/derived/Lavinia/recommended_exclusion_ids.txt

cp /panfs/panasas01/shared-biobank/data/derived/unrelated_ids/data_exclusion.txt ./biobank_all/sample_QC/
cp /panfs/panasas01/shared-biobank/data/derived/bolt_files/NonEuro_exclusion_list.txt ./biobank_all/sample_QC/
cp /panfs/panasas01/shared-biobank/data/derived/bolt_files/sex_mismatch.txt ./biobank_all/sample_QC/
cp /panfs/panasas01/shared-biobank/data/exclusions.txt ./biobank_all/sample_QC/



cat ./biobank_all/sample_QC/data_exclusion.txt \
./biobank_all/sample_QC/NonEuro_exclusion_list.txt \
./biobank_all/sample_QC/sex_mismatch.txt \
./biobank_all/sample_QC/exclusions.txt > biobank_all/remove_ind.txt



plink --bfile ${merged_snps} --remove ./biobank_all/sample_QC/remove_ind.txt \
--make-bed --out ${snp_qc}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#pull out SNP imputation score

mkdir ./biobank_bmi/snp_info

module add languages/R-3.0.2

Rscript ./scripts/snp_info.R

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#force reference allele so that A1 matches the effect allele reported and recode to get dosage data:

#plink --bfile ${snp_qc} \
#--a1-allele ${force_allele} \
#--recode A --freq \
#--make-bed --out ${recoded_out} \
#--flip ${flip_strand}  



# create genetic risk score, with beta's in .raw file (need to make your own SNP_score.raw file manually):

#plink --bfile ${recoded_out} --score ${snp_score} --out ${grs_out}

#standarise the GRS scores

#module add languages/R-3.0.2

#R

#source("./scripts/GRS_SD.R")
