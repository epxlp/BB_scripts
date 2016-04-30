#!/bin/bash
#
#PBS -l nodes=1:ppn=8
#PBS -l walltime=24:00:00
#
~/bin/BOLT-LMM_v2.2/bolt --bfile=/panfs/panasas01/sscm/epxlp/ukbiobank/data/chr1-22_rsOnly_removeIDs \
	--bgenFile=/panfs/panasas01/shared-biobank/data/dosage_bgen/data_chr01.bgen \
	--sampleFile=/panfs/panasas01/shared-biobank/data/data.sample \
	--geneticMapFile=/panfs/panasas01/sscm/epxlp/bin/BOLT-LMM_v2.2/tables/genetic_map_hg19.txt.gz \
	--bgenMinMAF=0.01 \
	--phenoFile=/panfs/panasas01/sscm/epxlp/ukbiobank/data/ukbiobank_ecz.pheno \
	--phenoCol=ECZ \
	--covarFile=/panfs/panasas01/sscm/epxlp/ukbiobank/data/ukbiobank_ecz.pheno \
	--covarCol=sex.c \
	--covarCol=chip \
	--remove /panfs/panasas01/sscm/epxlp/ukbiobank/data/NonEuro_exclusion_list.txt \
	--remove /panfs/panasas01/sscm/epxlp/ukbiobank/data/sex_mismatch.txt \
	--lmm \
	--LDscoresFile=/panfs/panasas01/sscm/epxlp/bin/BOLT-LMM_v2.2/tables/LDSCORE.1000G_EUR.tab.gz \
	--LDscoresMatchBp \
	--exclude /panfs/panasas01/sscm/epxlp/ukbiobank/data/UKBioBiLallfreqSNPexclude.dat \
	--numThreads 8 \
	--verboseStats \
	--modelSnps /panfs/panasas01/sscm/epxlp/ukbiobank/data/chr1-22_pruneData.prune.in \
	--statsFile=/panfs/panasas01/sscm/epxlp/ukbiobank/output/ukbb_ecz_gwas_chr01_imputed.out \
	--statsFileBgenSnps=/panfs/panasas01/sscm/epxlp/ukbiobank/output/ukbb_ecz_gwas_chr01_imputed.txt \
> /panfs/panasas01/sscm/epxlp/ukbiobank/output/ukbb_ecz_gwas_chr01.log
