#read in table with SNP names

SNPs <- read.table("./biobank_psoriasis/psoriasis_SNPs_tsoi_2017.txt", header=F)
colnames(SNPs) <- "RSID"
head(SNPs)

#merge with imputation accuracy scores for chromosome 1

chr_1 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr1_v2.txt", header=F)
head(chr_1)

colnames(chr_1)[1] <- "RSID"
colnames(chr_1)[5] <- "MAF"
colnames(chr_1)[6] <- "SCORE"

SNP_info_chr_1 <- merge(SNPs, chr_1, by.x=T)
SNP_info_chr_1 <- SNP_info_chr_1[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_1, file ="./biobank_eczema/snp_info/chr_1.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 2

chr_2 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr2_v2.txt", header=F)
head(chr_2)

colnames(chr_2)[1] <- "RSID"
colnames(chr_2)[5] <- "MAF"
colnames(chr_2)[6] <- "SCORE"


SNP_info_chr_2 <- merge(SNPs, chr_2, by.x=T)
SNP_info_chr_2 <- SNP_info_chr_2[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_2, file ="./biobank_eczema/snp_info/chr_2.txt", quote=F, sep=" ", row.names=F)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#merge with imputation accuracy scores for chromosome 3

chr_3 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr3_v2.txt", header=F)
head(chr_3)


colnames(chr_3)[1] <- "RSID"
colnames(chr_3)[5] <- "MAF"
colnames(chr_3)[6] <- "SCORE"

SNP_info_chr_3 <- merge(SNPs, chr_3, by.x=T)
SNP_info_chr_3 <- SNP_info_chr_3[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_3, file ="./biobank_eczema/snp_info/chr_3.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 4

#chr_4 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr4_v2.txt", header=F)
#head(chr_4)


#colnames(chr_4)[1] <- "RSID"
#colnames(chr_4)[5] <- "MAF"
#colnames(chr_4)[6] <- "SCORE"

#SNP_info_chr_4 <- merge(SNPs, chr_4, by.x=T)
#SNP_info_chr_4 <- SNP_info_chr_4[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_4, file ="./biobank_eczema/snp_info/chr_4.txt", quote=F, sep=" ", row.names=F)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#merge with imputation accuracy scores for chromosome 5

chr_5 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr5_v2.txt", header=F)
head(chr_5)

colnames(chr_5)[1] <- "RSID"
colnames(chr_5)[5] <- "MAF"
colnames(chr_5)[6] <- "SCORE"


SNP_info_chr_5 <- merge(SNPs, chr_5, by.x=T)
SNP_info_chr_5 <- SNP_info_chr_5[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_5, file ="./biobank_eczema/snp_info/chr_5.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 6

chr_6 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr6_v2.txt", header=F)
head(chr_6)

colnames(chr_6)[1] <- "RSID"
colnames(chr_6)[5] <- "MAF"
colnames(chr_6)[6] <- "SCORE"


SNP_info_chr_6 <- merge(SNPs, chr_6, by.x=T)
SNP_info_chr_6 <- SNP_info_chr_6[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_6, file ="./biobank_eczema/snp_info/chr_6.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 7

chr_7 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr7_v2.txt", header=F)
head(chr_7)

colnames(chr_7)[1] <- "RSID"
colnames(chr_7)[5] <- "MAF"
colnames(chr_7)[6] <- "SCORE"


SNP_info_chr_7 <- merge(SNPs, chr_7, by.x=T)
SNP_info_chr_7 <- SNP_info_chr_7[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_7, file ="./biobank_eczema/snp_info/chr_7.txt", quote=F, sep=" ", row.names=F)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 8

#chr_8 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr8_v2.txt", header=F)
#head(chr_8)

#colnames(chr_8)[1] <- "RSID"
#colnames(chr_8)[5] <- "MAF"
#colnames(chr_8)[6] <- "SCORE"


#SNP_info_chr_8 <- merge(SNPs, chr_8, by.x=T)
#SNP_info_chr_8 <- SNP_info_chr_8[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_8, file ="./biobank_eczema/snp_info/chr_8.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#merge with imputation accuracy scores for chromosome 9

chr_9 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr9_v2.txt", header=F)
head(chr_9)

colnames(chr_9)[1] <- "RSID"
colnames(chr_9)[5] <- "MAF"
colnames(chr_9)[6] <- "SCORE"


SNP_info_chr_9 <- merge(SNPs, chr_9, by.x=T)
SNP_info_chr_9 <- SNP_info_chr_9[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_9, file ="./biobank_eczema/snp_info/chr_9.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 10

chr_10 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr10_v2.txt", header=F)
head(chr_10)

colnames(chr_10)[1] <- "RSID"
colnames(chr_10)[5] <- "MAF"
colnames(chr_10)[6] <- "SCORE"


SNP_info_chr_10 <- merge(SNPs, chr_10, by.x=T)
SNP_info_chr_10 <- SNP_info_chr_10[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_10, file ="./biobank_eczema/snp_info/chr_10.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 11

chr_11 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr11_v2.txt", header=F)
head(chr_11)

colnames(chr_11)[1] <- "RSID"
colnames(chr_11)[5] <- "MAF"
colnames(chr_11)[6] <- "SCORE"


SNP_info_chr_11 <- merge(SNPs, chr_11, by.x=T)
SNP_info_chr_11 <- SNP_info_chr_11[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_11, file ="./biobank_eczema/snp_info/chr_11.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 12

chr_12 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr12_v2.txt", header=F)
head(chr_12)

colnames(chr_12)[1] <- "RSID"
colnames(chr_12)[5] <- "MAF"
colnames(chr_12)[6] <- "SCORE"


SNP_info_chr_12 <- merge(SNPs, chr_12, by.x=T)
SNP_info_chr_12 <- SNP_info_chr_12[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_12, file ="./biobank_eczema/snp_info/chr_12.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 13

chr_13 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr13_v2.txt", header=F)
head(chr_13)

colnames(chr_13)[1] <- "RSID"
colnames(chr_13)[5] <- "MAF"
colnames(chr_13)[6] <- "SCORE"

SNP_info_chr_13 <- merge(SNPs, chr_13, by.x=T)
SNP_info_chr_13 <- SNP_info_chr_13[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_13, file ="./biobank_eczema/snp_info/chr_13.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 14

chr_14 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr14_v2.txt", header=F)
head(chr_14)

colnames(chr_14)[1] <- "RSID"
colnames(chr_14)[5] <- "MAF"
colnames(chr_14)[6] <- "SCORE"


SNP_info_chr_14 <- merge(SNPs, chr_14, by.x=T)
SNP_info_chr_14 <- SNP_info_chr_14[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_14, file ="./biobank_eczema/snp_info/chr_14.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 15

chr_15 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr15_v2.txt", header=F)
head(chr_15)

colnames(chr_15)[1] <- "RSID"
colnames(chr_15)[5] <- "MAF"
colnames(chr_15)[6] <- "SCORE"


SNP_info_chr_15 <- merge(SNPs, chr_15, by.x=T)
SNP_info_chr_15 <- SNP_info_chr_15[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_15, file ="./biobank_eczema/snp_info/chr_15.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#merge with imputation accuracy scores for chromosome 16

chr_16 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr16_v2.txt", header=F)
head(chr_16)

colnames(chr_16)[1] <- "RSID"
colnames(chr_16)[5] <- "MAF"
colnames(chr_16)[6] <- "SCORE"


SNP_info_chr_16 <- merge(SNPs, chr_16, by.x=T)
SNP_info_chr_16 <- SNP_info_chr_16[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_16, file ="./biobank_eczema/snp_info/chr_16.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 17

chr_17 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr17_v2.txt", header=F)
head(chr_17)

colnames(chr_17)[1] <- "RSID"
colnames(chr_17)[5] <- "MAF"
colnames(chr_17)[6] <- "SCORE"


SNP_info_chr_17 <- merge(SNPs, chr_17, by.x=T)
SNP_info_chr_17 <- SNP_info_chr_17[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_17, file ="./biobank_eczema/snp_info/chr_17.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 18

chr_18 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr18_v2.txt", header=F)

head(chr_18)

colnames(chr_18)[1] <- "RSID"
colnames(chr_18)[5] <- "MAF"
colnames(chr_18)[6] <- "SCORE"


SNP_info_chr_18 <- merge(SNPs, chr_18, by.x=T)
SNP_info_chr_18 <- SNP_info_chr_18[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_18, file ="./biobank_eczema/snp_info/chr_18.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 19

chr_19 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr19_v2.txt", header=F)
head(chr_19)

colnames(chr_19)[1] <- "RSID"
colnames(chr_19)[5] <- "MAF"
colnames(chr_19)[6] <- "SCORE"


SNP_info_chr_19 <- merge(SNPs, chr_19, by.x=T)
SNP_info_chr_19 <- SNP_info_chr_19[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_19, file ="./biobank_eczema/snp_info/chr_19.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 20

chr_20 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr20_v2.txt", header=F)
head(chr_20)

colnames(chr_20)[1] <- "RSID"
colnames(chr_20)[5] <- "MAF"
colnames(chr_20)[6] <- "SCORE"


SNP_info_chr_20 <- merge(SNPs, chr_20, by.x=T)
SNP_info_chr_20 <- SNP_info_chr_20[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_20, file ="./biobank_eczema/snp_info/chr_20.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 21

chr_21 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr21_v2.txt", header=F)
head(chr_21)

colnames(chr_21)[1] <- "RSID"
colnames(chr_21)[5] <- "MAF"
colnames(chr_21)[6] <- "SCORE"


SNP_info_chr_21 <- merge(SNPs, chr_21, by.x=T)
SNP_info_chr_21 <- SNP_info_chr_21[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_21, file ="./biobank_eczema/snp_info/chr_21.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 22

chr_22 <- read.table("/panfs/panasas01/dedicated-mrcieu/research/data/ukbiobank/_latest/UKBIOBANK_Array_Genotypes_500k_HRC_Imputation/data/raw_downloaded/ukb_mfi_chr22_v2.txt", header=F)
head(chr_22)

colnames(chr_22)[1] <- "RSID"
colnames(chr_22)[5] <- "MAF"
colnames(chr_22)[6] <- "SCORE"


SNP_info_chr_22 <- merge(SNPs, chr_22, by.x=T)
SNP_info_chr_22 <- SNP_info_chr_22[ ,c("RSID", "MAF", "SCORE")]

#write.table(SNP_info_chr_22, file ="./biobank_eczema/snp_info/chr_22.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#combine results into a single dataframe

SNP_info_all <- rbind(SNP_info_chr_1, SNP_info_chr_2, SNP_info_chr_3, SNP_info_chr_5, SNP_info_chr_6, SNP_info_chr_7, SNP_info_chr_9,
SNP_info_chr_10, SNP_info_chr_11, SNP_info_chr_12, SNP_info_chr_13, SNP_info_chr_14, SNP_info_chr_15, SNP_info_chr_16, SNP_info_chr_17, 
SNP_info_chr_18, SNP_info_chr_19, SNP_info_chr_20, SNP_info_chr_21, SNP_info_chr_22)


write.table(SNP_info_all, file ="./biobank_psoriasis/snp_info/SNP_info.txt", quote=F, sep=" ", row.names=F) 


#order by SNP imputation score

order.snp_info <- order(SNP_info_all$SCORE)
SNP_info_sorted <- SNP_info_all[order.snp_info, ]
write.table(SNP_info_sorted, file="./biobank_psoriasis/snp_info/SNP_info_sorted.txt", quote=F, sep=" ", row.names=F)

summary <- summary(SNP_info_all)

write.table(summary, file="./biobank_psoriasis/snp_info/SNP_info_summary.txt", quote=F, sep=" ", row.names=F)
