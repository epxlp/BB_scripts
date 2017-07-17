#read in table with SNP names

PSO_SNPs <- read.table("./biobank_bmi/bmi_SNPs.txt", header=F)
colnames(PSO_SNPs) <- "RSID"
head(PSO_SNPs)

#merge with imputation accuracy scores for chromosome 1

chr_1 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr1.dat.txt", header=T)
head(chr_1)

SNP_info_chr_1 <- merge(PSO_SNPs, chr_1, by.x=T)
#write.table(SNP_info_chr_1, file ="./biobank_bmi/snp_info/chr_1.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 2

chr_2 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr2.dat.txt", header=T)
head(chr_2)

SNP_info_chr_2 <- merge(PSO_SNPs, chr_2, by.x=T)
#write.table(SNP_info_chr_2, file ="./biobank_bmi/snp_info/chr_2.txt", quote=F, sep=" ", row.names=F)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#merge with imputation accuracy scores for chromosome 3

chr_3 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr3.dat.txt", header=T)
head(chr_3)

SNP_info_chr_3 <- merge(PSO_SNPs, chr_3, by.x=T)
#write.table(SNP_info_chr_3, file ="./biobank_bmi/snp_info/chr_3.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 4

chr_4 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr4.dat.txt", header=T)
head(chr_4)

SNP_info_chr_4 <- merge(PSO_SNPs, chr_4, by.x=T)
#write.table(SNP_info_chr_4, file ="./biobank_bmi/snp_info/chr_4.txt", quote=F, sep=" ", row.names=F)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#merge with imputation accuracy scores for chromosome 5

chr_5 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr5.dat.txt", header=T)
head(chr_5)

SNP_info_chr_5 <- merge(PSO_SNPs, chr_5, by.x=T)
#write.table(SNP_info_chr_5, file ="./biobank_bmi/snp_info/chr_5.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 6

chr_6 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr6.dat.txt", header=T)
head(chr_6)

SNP_info_chr_6 <- merge(PSO_SNPs, chr_6, by.x=T)
#write.table(SNP_info_chr_6, file ="./biobank_bmi/snp_info/chr_6.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 7

chr_7 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr7.dat.txt", header=T)
head(chr_7)

SNP_info_chr_7 <- merge(PSO_SNPs, chr_7, by.x=T)
#write.table(SNP_info_chr_7, file ="./biobank_bmi/snp_info/chr_7.txt", quote=F, sep=" ", row.names=F)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 8

chr_8 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr8.dat.txt", header=T)
head(chr_8)

SNP_info_chr_8 <- merge(PSO_SNPs, chr_8, by.x=T)
#write.table(SNP_info_chr_8, file ="./biobank_bmi/snp_info/chr_8.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#merge with imputation accuracy scores for chromosome 9

chr_9 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr9.dat.txt", header=T)
head(chr_9)

SNP_info_chr_9 <- merge(PSO_SNPs, chr_9, by.x=T)
#write.table(SNP_info_chr_9, file ="./biobank_bmi/snp_info/chr_9.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 10

chr_10 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr10.dat.txt", header=T)
head(chr_10)

SNP_info_chr_10 <- merge(PSO_SNPs, chr_10, by.x=T)
#write.table(SNP_info_chr_10, file ="./biobank_bmi/snp_info/chr_10.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 11

chr_11 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr11.dat.txt", header=T)
head(chr_11)

SNP_info_chr_11 <- merge(PSO_SNPs, chr_11, by.x=T)
#write.table(SNP_info_chr_11, file ="./biobank_bmi/snp_info/chr_11.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 12

chr_12 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr12.dat.txt", header=T)
head(chr_12)

SNP_info_chr_12 <- merge(PSO_SNPs, chr_12, by.x=T)
#write.table(SNP_info_chr_12, file ="./biobank_bmi/snp_info/chr_12.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 13

chr_13 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr13.dat.txt", header=T)
head(chr_13)

SNP_info_chr_13 <- merge(PSO_SNPs, chr_13, by.x=T)
#write.table(SNP_info_chr_13, file ="./biobank_bmi/snp_info/chr_13.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 14

chr_14 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr14.dat.txt", header=T)
head(chr_14)

SNP_info_chr_14 <- merge(PSO_SNPs, chr_14, by.x=T)
#write.table(SNP_info_chr_14, file ="./biobank_bmi/snp_info/chr_14.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 15

chr_15 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr15.dat.txt", header=T)
head(chr_15)

SNP_info_chr_15 <- merge(PSO_SNPs, chr_15, by.x=T)
#write.table(SNP_info_chr_15, file ="./biobank_bmi/snp_info/chr_15.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#merge with imputation accuracy scores for chromosome 16

chr_16 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr16.dat.txt", header=T)
head(chr_16)

SNP_info_chr_16 <- merge(PSO_SNPs, chr_16, by.x=T)
#write.table(SNP_info_chr_16, file ="./biobank_bmi/snp_info/chr_16.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 17

chr_17 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr17.dat.txt", header=T)
head(chr_17)

SNP_info_chr_17 <- merge(PSO_SNPs, chr_17, by.x=T)
#write.table(SNP_info_chr_17, file ="./biobank_bmi/snp_info/chr_17.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 18

chr_18 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr18.dat.txt", header=T)

head(chr_18)

SNP_info_chr_18 <- merge(PSO_SNPs, chr_18, by.x=T)
#write.table(SNP_info_chr_18, file ="./biobank_bmi/snp_info/chr_18.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 19

chr_19 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr19.dat.txt", header=T)
head(chr_19)

SNP_info_chr_19 <- merge(PSO_SNPs, chr_19, by.x=T)
#write.table(SNP_info_chr_19, file ="./biobank_bmi/snp_info/chr_19.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 20

chr_20 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr20.dat.txt", header=T)
head(chr_20)

SNP_info_chr_20 <- merge(PSO_SNPs, chr_20, by.x=T)
#write.table(SNP_info_chr_20, file ="./biobank_bmi/snp_info/chr_20.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 21

chr_21 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr21.dat.txt", header=T)
head(chr_21)

SNP_info_chr_21 <- merge(PSO_SNPs, chr_21, by.x=T)
#write.table(SNP_info_chr_21, file ="./biobank_bmi/snp_info/chr_21.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#merge with imputation accuracy scores for chromosome 22

#chr_22 <- read.table("/panfs/panasas01/shared-biobank/data/info/imp_maf_chr22.dat.txt", header=T)
#head(chr_22)

#SNP_info_chr_22 <- merge(PSO_SNPs, chr_22, by.x=T)
#write.table(SNP_info_chr_22, file ="./biobank_bmi/snp_info/chr_22.txt", quote=F, sep=" ", row.names=F)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#combine results into a single dataframe

SNP_info_all <- rbind(SNP_info_chr_1, SNP_info_chr_2, SNP_info_chr_3, SNP_info_chr_4, SNP_info_chr_5, SNP_info_chr_6, SNP_info_chr_7, SNP_info_chr_8, SNP_info_chr_9,
 SNP_info_chr_10, SNP_info_chr_11, SNP_info_chr_12, SNP_info_chr_13, SNP_info_chr_14, SNP_info_chr_15, SNP_info_chr_16, SNP_info_chr_17,
 SNP_info_chr_18, SNP_info_chr_19, SNP_info_chr_20, SNP_info_chr_21)


write.table(SNP_info_all, file ="./biobank_bmi/snp_info/SNP_info.txt", quote=F, sep=" ", row.names=F) 


#order by SNP imputation score

order.snp_info <- order(SNP_info_all$information)
SNP_info_sorted <- SNP_info_all[order.snp_info, ]
write.table(SNP_info_sorted, file="./biobank_bmi/snp_info/SNP_info_sorted.txt", quote=F, sep=" ", row.names=F)

summary <- summary(SNP_info_all)

write.table(summary, file="./biobank_bmi/snp_info/SNP_info_summary.txt", quote=F, sep=" ", row.names=F)


