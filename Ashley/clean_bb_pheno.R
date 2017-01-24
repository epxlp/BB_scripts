#code from biobank to generate df of phenos that can work with
source("O:/Eczema_MR_project/UK_Biobank/ukb6524.r")



# read in linker file and match the phenotype and genotype ids
linker = read.csv("O:/Eczema_MR_project/UK_Biobank/ukb6531.csv", header=T)

#load in GRS
load("O:/Eczema_MR_project/Eczema_vs_BMI/Eczema/eczema_grs_SDscore.RData")


###Remove sex-mismatch -with genetic id - remove from linker file before: goes from 502651 to 502469 - removes 182
sex_mismatch_IDs <- read.table("O:/Eczema_MR_project/UK_Biobank/sex_mismatch.txt")
sexmisid <- sex_mismatch_IDs$V1
for(i in sexmisid){
  linker <- linker[!linker$app.8786 == i, ] 
}

#Withdrawn consent - with pheno ids
withdrawn <- c(1113914, 2460879, 3571346, 4122878)

for(i in withdrawn){
  bd <- bd[!bd$f.eid ==i, ]
}


#Match the pheno and genetic ids using linker file
bd$fid <- linker$app.8786[match(bd$f.eid, linker$app.10074)] #generates a new variable matching the pheno and geno ids

install.packages("reshape")
library(reshape)
bd<- rename(bd, c(fid= "id")) #rename the new variable to id so can merge with genetic data

#merge the GRS df in to phewas df
GRSpheno <- merge(GRS, bd, by = "id")

#Rename age and sex
GRSpheno <- rename(GRSpheno, c(f.31.0.0 = "sex"))
GRSpheno <- rename(GRSpheno, c(f.21022.0.0 = "age"))
GRSpheno <- GRSpheno[ ,-4] # delete the original id in phewas

#read in stat file to get whihc chip the folk were phenotyped on
install.packages("readstata13")
library(readstata13)
genetic_vars <- read.dta13("O:/Eczema_MR_project/UK_Biobank/biobank_genotype_supp_NMD_150417.dta")
genetic_vars$chip <- ifelse(genetic_vars$n_22000_0_0<0, 1,
                            ifelse(genetic_vars$n_22000_0_0<2000, 2, NA))

GRSpheno$chip <- genetic_vars$chip[match(GRSpheno$id, genetic_vars$n_eid)] # matches ids and generates a new variable

#save as full data set of exclusions performed
save(bd, genetic_vars, GRSpheno, GRS, linker, sex_mismatch_IDs, sexmisid, withdrawn,
     file= "O:/Eczema_MR_project/Eczema_vs_BMI/Eczema/clean_pheno_data.RData")



#Save
save(GRSpheno, 
     file= "O:/Eczema_MR_project/Eczema_vs_BMI/Eczema/eczema_GRSpheno.RData")


