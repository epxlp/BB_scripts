#!/bin/bash
#
#PBS -l nodes=1:ppn=1
#PBS -l walltime=02:00:00
#

module load apps/gtool-0.7.5


#merge gen files into one

gtool -M --g ./biobank_psoriasis/plink_files/chr01_sample_QC.gen \
./biobank_psoriasis/plink_files/chr02_sample_QC.gen \
./biobank_psoriasis/plink_files/chr03_sample_QC.gen \
./biobank_psoriasis/plink_files/chr04_sample_QC.gen \
./biobank_psoriasis/plink_files/chr05_sample_QC.gen \
./biobank_psoriasis/plink_files/chr06_sample_QC.gen \
./biobank_psoriasis/plink_files/chr07_sample_QC.gen \
./biobank_psoriasis/plink_files/chr08_sample_QC.gen \
./biobank_psoriasis/plink_files/chr09_sample_QC.gen \
./biobank_psoriasis/plink_files/chr10_sample_QC.gen \
./biobank_psoriasis/plink_files/chr11_sample_QC.gen \
./biobank_psoriasis/plink_files/chr12_sample_QC.gen \
./biobank_psoriasis/plink_files/chr13_sample_QC.gen \
./biobank_psoriasis/plink_files/chr14_sample_QC.gen \
./biobank_psoriasis/plink_files/chr15_sample_QC.gen \
./biobank_psoriasis/plink_files/chr16_sample_QC.gen \
./biobank_psoriasis/plink_files/chr17_sample_QC.gen \
./biobank_psoriasis/plink_files/chr18_sample_QC.gen \
./biobank_psoriasis/plink_files/chr19_sample_QC.gen \
./biobank_psoriasis/plink_files/chr20_sample_QC.gen \
./biobank_psoriasis/plink_files/chr21_sample_QC.gen \
./biobank_psoriasis/plink_files/chr22_sample_QC.gen \
--s ./biobank_psoriasis/plink_files/chr01_sample_QC.sample \
./biobank_psoriasis/plink_files/chr02_sample_qc.sample \
./biobank_psoriasis/plink_files/chr03_sample_qc.sample \
./biobank_psoriasis/plink_files/chr04_sample_qc.sample \
./biobank_psoriasis/plink_files/chr05_sample_qc.sample \
./biobank_psoriasis/plink_files/chr06_sample_qc.sample \
./biobank_psoriasis/plink_files/chr07_sample_qc.sample \
./biobank_psoriasis/plink_files/chr08_sample_qc.sample \
./biobank_psoriasis/plink_files/chr09_sample_qc.sample \
./biobank_psoriasis/plink_files/chr10_sample_qc.sample \
./biobank_psoriasis/plink_files/chr11_sample_qc.sample \
./biobank_psoriasis/plink_files/chr12_sample_qc.sample \
./biobank_psoriasis/plink_files/chr13_sample_qc.sample \
./biobank_psoriasis/plink_files/chr14_sample_qc.sample \
./biobank_psoriasis/plink_files/chr15_sample_qc.sample \
./biobank_psoriasis/plink_files/chr16_sample_qc.sample \
./biobank_psoriasis/plink_files/chr17_sample_qc.sample \
./biobank_psoriasis/plink_files/chr18_sample_qc.sample \
./biobank_psoriasis/plink_files/chr19_sample_qc.sample \
./biobank_psoriasis/plink_files/chr20_sample_qc.sample \
./biobank_psoriasis/plink_files/chr21_sample_qc.sample \
./biobank_psoriasis/plink_files/chr22_sample_qc.sample \
--og ./biobank_psoriasis/psoriasis_snps_merged.gen \
--os ./biobank_psoriasis/psoriasis_snps_merged.sample \
--log ./biobank_psoriasis/plink_files/merge_chr.log