#!/bin/bash
#
#PBS -l nodes=1:ppn=8
#PBS -l walltime=24:00:00
#


bgen_pattern="/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/dosage_bgen"

bgen_index_pattern="/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/dosage_bgen"

snp_list="./biobank_psoriasis/psoriasis_SNPs_tsoi_2017_iv.txt"

merged_snps="./biobank_psoriasis/psoriasis_snps_merged"

force_allele="./biobank_psoriasis/psoriasis_ref_allele.txt"

snp_score="./biobank_psoriasis/psoriasis_snp_score_tsoi.raw"

recoded_out="./biobank_psoriasis/psoriasis_snps_merged_recoded"

grs_out="./biobank_psoriasis/psoriasis_grs"




# Extract using bgen

#module load apps/bgen-1.0.1


#bgenix -help | head


#for i in {01..22}
#for i in 04 11
#do
    
#bgenix -g ${bgen_pattern}/data.chr${i}.bgen \
#-i ${bgen_index_pattern}/data.chr${i}.bgen.bgi \
#-incl-rsids ${snp_list} -v11 > ./biobank_psoriasis/plink_files/chr${i}.bgen

#done



#extract individuals with qctool

module load apps/qctool-2.0
#module load languages/gcc-4.8.5
module load apps/plink2
module load languages/R-3.0.2
module load apps/gtool-0.7.5


#for i in {01..22}
#for i in 04 11
#do

#qctool -filetype bgen \
#-g ./biobank_psoriasis/plink_files/chr${i}.bgen \
#-s /panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/sample-stats/data.chr${i}.sample \
#-og ./biobank_psoriasis/plink_files/chr${i}_sample_qc.bgen \
#-os ./biobank_psoriasis/plink_files/chr${i}_sample_qc.sample \
#-excl-samples ./biobank_all/remove_ind_new_release.txt

#done


#convert to gen file 

#for i in {01..22}
#for i in 04 11

#do

#qctool -g ./biobank_psoriasis/plink_files/chr${i}_sample_qc.bgen \
#-og ./biobank_psoriasis/plink_files/chr${i}_sample_QC.gen \
#-omit-chromosome

#done


#for psoriasis SNPs there as two SNPs for rs3900909, exclude the C/T variant

plink --gen ./biobank_psoriasis/plink_files/chr01_sample_QC.gen \
--sample ./biobank_psoriasis/plink_files/chr01_sample_qc.sample \
--out ./biobank_psoriasis/plink_files/chr01_sample_QC \
--allow-extra-chr \
--not-chr 1:197757846_C_T \
--recode oxford




#merge into single file

./scripts/create_GRS/merge_gen_files.sh



#use plink to pull out MAF, A1 and A2

plink --data ${merged_snps} --freq --out ${merged_snps}_maf --allow-extra-chr


#force correct EA to be A1 (".raw")

plink --data ${merged_snps} --a1-allele ${force_allele} \
--recode oxford \
--allow-extra-chr \
--out ${recoded_out}
--flip ${flip_strand} 

#use manually created SNP_score.raw file with reported beta's to create weighted GRS

plink --data ${recoded_out} --score ${snp_score} --out ${grs_out} \
--allow-extra-chr

#create dosage/best_guess files
plink --data ${recoded_out} \
--recode A \
--make-bed --out ${recoded_out}_best_guess \
--allow-extra-chr

#standardise the risk scores
Rscript ./scripts/create_GRS/GRS_SD.R


#pull out MAF and imputation info score
#Rscript ./scripts/create_GRS/snp_info.R



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#module load apps/bgen-1.0.1
#module load languages/gcc-7.1.0
#module load apps/qctool-2.0

# Bgen patterns

#bgen_pattern=/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_imp_chrCHROM_v2.bgen

#bgen_index_pattern=/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_bgi_chrCHROM_v2.bgi


# Args
#snp_keep_list=./biobank_eczema/eczema_snps.txt
#sample_out_list=./biobank_all/remove_ind_new_release.txt
#sample_file=/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/8786_link/imp
#out_prefix=./biobank_eczema/plink_files/out_test

# Extract variants using bgen
#temp_geno_prefix=./biobank_eczema/plink_files/temp_genos

#for chrom in {1..22}; do

 #   chrom_padd=$(printf "%0*d\n" 2 $chrom)
 #   inbgen=${bgen_pattern/CHROM/$chrom_padd}
 #   inbgenidx=${bgen_index_pattern/CHROM/$chrom_padd}
    
#bgenix -g $inbgen -i $inbgenidx -incl-rsids $snp_keep_list -v11 > $temp_geno_prefix.$chrom_padd.bgen

#done

# Extract individuals using qctool
#qctool -filetype bgen -g $temp_geno_prefix.#.bgen -s ${sample_file}/ukb878_imp_chr${chrom}_v2_s487406.sample \
#-excl-samples $sample_out_list -og $out_prefix.bgen -os $out_prefix.sample

# Remove temp genos
#rm $temp_geno_prefix*