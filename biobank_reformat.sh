# Convert Biobank data for use in BOLT-LMM
# Author: Lavinia Paternoster

# MAKE BOLT-LMM BFILE:

#	# Get gconv program for UKbiobank
#	wget -nd biobank.ctsu.ox.ac.uk/crystal/util/gconv
#
#	# Convert UKBB genotyped data to map ped
#	# 1-22 only for now 
#	./gconv ../../genotype_data/calls/chrom1.cal chr1_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom2.cal chr2_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom3.cal chr3_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom4.cal chr4_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom5.cal chr5_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom6.cal chr6_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom7.cal chr7_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom8.cal chr8_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom9.cal chr9_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom10.cal chr10_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom11.cal chr11_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom12.cal chr12_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom13.cal chr13_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom14.cal chr14_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom15.cal chr15_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom16.cal chr16_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom17.cal chr17_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom18.cal chr18_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom19.cal chr19_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom20.cal chr20_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom21.cal chr21_rsOnly ped -r -m../../genotype_data/genotype_map.csv
#	./gconv ../../genotype_data/calls/chrom22.cal chr22_rsOnly ped -r -m../../genotype_data/genotype_map.csv

#	# Merge the map files with the genotype_map.csv to convert IDs from AffxID to rsID
#	# May not be necessary - try keeping in Affx format

#	# Convert ped/map to bed/bim/fam
#	module load apps/plink-1.90
#	for i in `seq 1 22`;
#	do
#		plink --file chr${i}_rsOnly --make-bed --out chr${i}_rsOnly
#	done
	
#	rm *map
#	rm *ped

#	# Get exclusion IDs
#	# From biobank_genotype_supp_NMD_150417.dta run:
#	# outsheet n_eid n_eid using H:\laviniap\GWAS\eczema\ukbiobank\have_batch_ids.txt if n_22000_0_0<2000, nonames replace
#	# outsheet n_eid n_eid using H:\laviniap\GWAS\eczema\ukbiobank\recommended_exclusion_ids.txt if n_22010_0_0==1, nonames replace

#	# Merge chr1-22 files and remove 480 IDs
#	plink --bfile chr1_rsOnly --merge-list list_chr2-22.txt --keep have_batch_ids.txt --remove recommended_exclusion_ids.txt --make-bed --out chr1-22_rsOnly_removeIDs

# GET SNP EXCLUSION FILE:
#	wget http://biobank.ctsu.ox.ac.uk/crystal/docs/UKBioBiLallfreqSNPexclude.dat

# MAKE EuroSubset.fam
#	# From biobank_genotype_supp_NMD_150417.dta run:
#       # outsheet n_eid n_eid using H:\laviniap\GWAS\eczema\ukbiobank\EuroSubset.fam if n_22006_0_0==1, nonames replace

# MAKE NonEuro_exclusion_list.txt:
#	# From biobank_genotype_supp_NMD_150417.dta run:
#        # outsheet n_eid n_eid using H:\laviniap\GWAS\eczema\ukbiobank\NonEuro_exclusion_list.txt if n_22000_0_0<2000 & n_22006_0_0!=1, nonames replace

# MAKE MODELSNPS FILE:
#	plink 	--bfile chr1-22_rsOnly_removeIDs --exclude UKBioBiLallfreqSNPexclude.dat --keep EuroSubset.fam \
#		--maf 0.01 --geno 0.1 --hwe 0.0001 --indep-pairwise 50 5 0.9 \
#		--out chr1-22_pruneData
 
# MAKE filtered dosage set
for i in {01..22}
do
/panfs/panasas01/sscm/epxlp/bin/qctool_v1.4-linux-x86_64/qctool \
	-g /panfs/panasas01/shared-biobank/data/dosage_bgen/data_chr${i}.bgen \
	-s /panfs/panasas01/shared-biobank/data/data.sample \
 	-maf 0.01 1 \
     	-info 0.3 1 \
	-og /panfs/panasas01/sscm/epxlp/ukbiobank/data/chr${i}_filtered.bgen
done   
