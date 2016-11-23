source("ukb6524.r")

dim(bd)

ECZ <- ifelse(bd$f.20002.0.0==1452 | bd$f.20002.0.1==1452 | bd$f.20002.0.2==1452 | bd$f.20002.0.3==1452 | bd$f.20002.0.4==1452 | bd$f.20002.0.5==1452 | bd$f.20002.0.6==1452 | bd$f.20002.0.7==1452 | bd$f.20002.0.8==1452 | bd$f.20002.0.9==1452 | bd$f.20002.0.10==1452 | bd$f.20002.0.11==1452 | bd$f.20002.0.12==1452 | bd$f.20002.0.13==1452 | bd$f.20002.0.14==1452 | bd$f.20002.0.15==1452 | bd$f.20002.0.16==1452 | bd$f.20002.0.17==1452 | bd$f.20002.0.18==1452 | bd$f.20002.0.19==1452 | bd$f.20002.0.20==1452 | bd$f.20002.0.21==1452 | bd$f.20002.0.22==1452 | bd$f.20002.0.26==1452 | bd$f.20002.0.27==1452 | bd$f.20002.0.28==1452,1,0)

ECZ[is.na(ECZ)] <- 0
sex <- ifelse(bd$f.31.0.0=="Male", 1,
       ifelse(bd$f.31.0.0=="Female",2, NA))
id <- bd$f.eid
fam <- data.frame(id, ECZ, sex)

# remove withdrawn list

linker = read.csv("../data/ukb6531.csv", header=T)
fam$FID <- linker$app8786[match(fam$id, linker$app10074)]
fam$IID <- fam$FID

fam$PID <- rep(0, 502647)
fam$MID <- rep(0, 502647)
fam$sex.c <- fam$sex

# Get list of IDs with mismatch between reported (sex.r) and genetic (sex.g) sex
fam$sex.r <- fam$sex 
gen_sex <- read.table("/panfs/panasas01/shared-biobank/data/derived/genetic_sex/data.txt")
fam$sex.g <- gen_sex$V3[match(fam$FID, gen_sex$V1)]
sex_mismatch_IDs <- fam$FID[which (fam$sex.r==1 & fam$sex.g==0 | fam$sex.r==2 & fam$sex.g==1)]
length(sex_mismatch_id)
# 182 IDs
sex_mismatch <- as.data.frame(sex_mismatch_IDs)
sex_mismatch$V2 <- sex_mismatch$sex_mismatch_IDs
write.table(sex_mismatch, file="../data/sex_mismatch.txt", row.names=F, col.names=F)


library(readstata13)
genetic_vars <- read.dta13("../data/biobank_genotype_supp_NMD_150417.dta")
genetic_vars$chip <- ifelse(genetic_vars$n_22000_0_0<0, 1,
                        ifelse(genetic_vars$n_22000_0_0<2000, 2, NA))

fam$chip <- genetic_vars$chip[match(fam$FID, genetic_vars$n_eid)]

fam <- fam[c("FID", "IID", "PID", "MID", "sex", "ECZ", "sex.c", "chip")]
write.table(fam, file="../data/ukbiobank_ecz.pheno", row.names=F, quote=F)
