#code from biobank to generate df of phenos that can work with
source("O:/EBI fellowship/Biobank/ukb6524ruth.r")
source("Y:/Biobank/ukb7919.r")

#merge the two bd df that came at different times. 
bd <- merge(bd, bd7919, by = "f.eid")
rm(bd7919)

# read in linker file and match the phenotype and genotype ids
linker = read.csv("Y:/Biobank/ukb6531.csv", header=T, dec=",")

#load in GRS
load("O:/EBI fellowship/Biobank/GRS/SDscore.RData")


###Remove sex-mismatch -with genetic id - remove from linker file before: goes from 502651 to 502469 - removes 182
sex_mismatch_IDs <- read.table("Y:/Biobank/PRS_biobank/biobank_exclusions/sex_mismatch.txt")
sexmisid <- sex_mismatch_IDs$V1
for(i in sexmisid){
  linker <- linker[!linker$app.8786 == i, ] 
}

#Withdrawn consent - with pheno ids
withdrawn_consent <- c("1113914", "2460879", "3571346", "4122878")
for(i in withdrawn_consent){
  bd <- bd[!bd$f.eid ==i, ]
}


#Match the pheno and genetic ids using linker file
bd$fid <- linker$app.8786[match(bd$f.eid, linker$app.10074)] #generates a new variable matching the pheno and geno ids
bd$f.eid<-NULL # delete the original id in phewas
library(reshape)
bd<- rename(bd, c(fid= "id")) #rename the new variable to id so can merge with genetic data

#merge the GRS df in to phewas df
GRSpheno <- merge(GRS, bd, by= "id")

#Rename age and sex
GRSpheno <- rename(GRSpheno, c(f.31.0.0 = "sex"))
GRSpheno <- rename(GRSpheno, c(f.21022.0.0 = "age"))


#read in stat file to get whihc chip the folk were phenotyped on
library(readstata13)
genetic_vars <- read.dta13("Y:/Biobank/biobank_genotype_supp_NMD_150417.dta")
genetic_vars$chip <- ifelse(genetic_vars$n_22000_0_0<0, 1,
                            ifelse(genetic_vars$n_22000_0_0<2000, 2, NA))

GRSpheno$chip <- genetic_vars$chip[match(GRSpheno$id, genetic_vars$n_eid)] # matches ids and generates a new variable

#save as full data set of exclusions performed
save(bd, genetic_vars, GRSpheno, GRS, linker, sex_mismatch_IDs, sexmisid, withdrawn_consent,
     file= "O:/EBI fellowship/Biobank/clean pheno data for analysis.RData")

#Take out MS people as don't want them in for analysis
NCIllness <- grep("20002", colnames(GRSpheno), value= TRUE) #gets column numbers for non cancer illness - ms within that
ncillness <- GRSpheno[,NCIllness] #puts them in a df- so have a df of just non-cancer illnesses (87 variables)
ms <- grep("1261", ncillness) # find ms code 1261 within the non cancer illnesses
mspple <- as.data.frame(ifelse(ncillness[,ms] == "1261", 1, 0)) #within those columns label 1=MS and 0=no MS
mspple$msna <- rowSums(mspple, na.rm =TRUE) #add all the the rows togehter so just have 1 column for MS
mspple$ms[mspple$msna == "2"|mspple$msna =="3"]<- "1" # if were in all 3 instance then reduce it back to one
mspple$ms <- as.factor(mspple$ms) #change it inot a factor
mspple$id <- GRSpheno$id #add in an id column in mapple df
msid <- mspple$id[mspple$ms == 1] # get the ids of pple who have MS

#Run a glm on MS to show how the score correlates with MS
msglm <- glm(mspple$ms ~ GRSpheno$SDscore + GRSpheno$age + GRSpheno$sex + GRSpheno$chip, family="binomial", maxit=100) # need the maxit otherwise won't converge
library(broom) # tidy it up
msglmout <- tidy(msglm)
msglmout <- msglmout[2,] # just want second row
msglmout$estimate <- exp(msglmout$estimate) # expontiate the estimates
msn <- as.data.frame(t(count(mspple$ms))) # get number of inds with ms that have been genotyped
msn <- msn[2,] # just take second row
msglmout <- cbind(msglmout, msn) #put in msglmout table
library(xlsx)
write.xlsx(msglmout, file="O:/EBI fellowship/Biobank/mscorrelation.xlsx")

#remove the pple who have MS from the GRSpheno dataframe
GRSpheno <- GRSpheno[!GRSpheno$id %in% msid,] 


#Save
save(GRSpheno, 
     file= "O:/EBI fellowship/Biobank/GRSpheno.RData")

save(GRSpheno, msglmout, msglm, msid, ncillness, NCIllness, mspple,
     file= "O:/EBI fellowship/Biobank/MSglm.RData")


