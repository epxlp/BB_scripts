source("ukb6524.r")

dim(bd)

BMI <- bd$f.21001.0.0 

sex <- ifelse(bd$f.31.0.0=="Male", 1,
       ifelse(bd$f.31.0.0=="Female",2, NA))
id <- bd$f.eid
fam <- data.frame(id, BMI, sex)

# Remove withdrawn list
withdrawn <- read.csv("../data/w1007_20160406.csv")
ECZ[id %in% withdrawn] = NA

linker = read.csv("../data/ukb6531.csv", header=T)
fam$FID <- linker$app8786[match(fam$id, linker$app10074)]
fam$IID <- fam$FID

fam$PID <- rep(0, 502647)
fam$MID <- rep(0, 502647)
fam$sex.c <- fam$sex


library(readstata13)
genetic_vars <- read.dta13("../data/biobank_genotype_supp_NMD_150417.dta")
genetic_vars$chip <- ifelse(genetic_vars$n_22000_0_0<0, 1,
                        ifelse(genetic_vars$n_22000_0_0<2000, 2, NA))

fam$chip <- genetic_vars$chip[match(fam$FID, genetic_vars$n_eid)]

fam <- fam[c("FID", "IID", "PID", "MID", "sex", "BMI", "sex.c", "chip")]
write.table(fam, file="../data/ukbiobank_bmi.pheno", row.names=F, quote=F)
