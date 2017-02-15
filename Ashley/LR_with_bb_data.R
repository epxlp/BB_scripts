#Eczema GRS
#load("O:/Eczema_MR_project/Eczema_vs_BMI/Eczema/eczema_GRSpheno.RData")


#psoriasis GRS
load("O:/Eczema_MR_project/Eczema_vs_psoriasis/Psoriasis/psc_GRSpheno.RData")

#pull Eczema phenotypes (non-cancer codes)
ECZ <- ifelse(GRSpheno$f.20002.0.0==1452 | GRSpheno$f.20002.0.1==1452 | GRSpheno$f.20002.0.2==1452 | GRSpheno$f.20002.0.3==1452 | GRSpheno$f.20002.0.4==1452 | GRSpheno$f.20002.0.5==1452 | GRSpheno$f.20002.0.6==1452 | GRSpheno$f.20002.0.7==1452 | GRSpheno$f.20002.0.8==1452 | GRSpheno$f.20002.0.9==1452 | GRSpheno$f.20002.0.10==1452 | GRSpheno$f.20002.0.11==1452 | GRSpheno$f.20002.0.12==1452 | GRSpheno$f.20002.0.13==1452 | GRSpheno$f.20002.0.14==1452 | GRSpheno$f.20002.0.15==1452 | GRSpheno$f.20002.0.16==1452 | GRSpheno$f.20002.0.17==1452 | GRSpheno$f.20002.0.18==1452 | GRSpheno$f.20002.0.19==1452 | GRSpheno$f.20002.0.20==1452 | GRSpheno$f.20002.0.21==1452 | GRSpheno$f.20002.0.22==1452 | GRSpheno$f.20002.0.26==1452 | GRSpheno$f.20002.0.27==1452 | GRSpheno$f.20002.0.28==1452,1,0)
#whoever doesn't have eczema is a control
ECZ[is.na(ECZ)] <- 0

#check number of cases/controls
length(ECZ[ECZ==0])
length(ECZ[ECZ==1])

#pull psoriasis phenotypes (non-cancer codes)
PSO <- ifelse(GRSpheno$f.20002.0.0==1453 | GRSpheno$f.20002.0.1==1453 | GRSpheno$f.20002.0.2==1453 | GRSpheno$f.20002.0.3==1453 | GRSpheno$f.20002.0.4==1453 | GRSpheno$f.20002.0.5==1453 | GRSpheno$f.20002.0.6==1453 | GRSpheno$f.20002.0.7==1453 | GRSpheno$f.20002.0.8==1453 | GRSpheno$f.20002.0.9==1453 | GRSpheno$f.20002.0.10==1453 | GRSpheno$f.20002.0.11==1453 | GRSpheno$f.20002.0.12==1453 | GRSpheno$f.20002.0.13==1453 | GRSpheno$f.20002.0.14==1453 | GRSpheno$f.20002.0.15==1453 | GRSpheno$f.20002.0.16==1453 | GRSpheno$f.20002.0.17==1453 | GRSpheno$f.20002.0.18==1453 | GRSpheno$f.20002.0.19==1453 | GRSpheno$f.20002.0.20==1453 | GRSpheno$f.20002.0.21==1453 | GRSpheno$f.20002.0.22==1453 | GRSpheno$f.20002.0.26==1453 | GRSpheno$f.20002.0.27==1453 | GRSpheno$f.20002.0.28==1453,1,0)
#whoever doesn't have psoriasis is a control
PSO[is.na(PSO)] <- 0

#check number of cases/controls
length(PSO[PSO==0])
length(PSO[PSO==1])

#extract ICD9 codes
#ECZ_ICD9 <- ifelse(GRSpheno$f.41203.0.0==69180,1,0)


#combine all eczema phenotypes
#ECZ_all <- c(ECZ, ECZ_ICD9)

id <- GRSpheno$id

#define males/females
sex <- ifelse(GRSpheno$sex=="Male", 1,
              ifelse(GRSpheno$sex=="Female",2, NA))

#create dataframe with GRS score, phenotypes, sex, age and chip variables
fam <- data.frame(id, ECZ, PSO, GRSpheno$SDscore, sex, GRSpheno$age, GRSpheno$chip)

#need to set the response variable (ECZ phenotype, which is your dependent variable that you are trying to predict) as a factor
fam$ECZ <- factor(fam$ECZ)
fam$PSO <- factor(fam$PSO)

#perform logistic regression (see if independent variable (GRS score) can predict ECZ phenotype))
PSO_reg <- glm(fam$PSO ~ fam$GRSpheno.SDscore + fam$GRSpheno.age + fam$sex + fam$GRSpheno.chip, binomial)
summary(PSO_reg)

#perform logistic regression (see if independent variable (GRS score) can predict PSO phenotype))
PSO_GRS_ECZ_reg <- glm(fam$ECZ ~ fam$GRSpheno.SDscore + fam$GRSpheno.age + fam$sex + fam$GRSpheno.chip, binomial)
summary(PSO_GRS_ECZ_reg)

#install.packages("broom")
library(broom)

#extract results for fam$GRSpheno.SDscore

#*****For PSO results******
PSO_results <- tidy(PSO_reg)
PSO_results <- PSO_results[2,]
#ECZ_results$OR <- exp(ECZ_results$estimate)

#calcualte confidence intervals and OR:
PSO_OR <- exp(cbind(OR=coef(PSO_reg), confint.default(PSO_reg)))
PSO_OR <- PSO_OR[2,]

#define number of cases and controls
#install.packages("plyr")
library(plyr)

PSO_samples <- as.data.frame(t(count(fam$PSO)))
colnames(PSO_samples)[1] <- "controls"
colnames(PSO_samples)[2] <- "cases"
PSO_samples <- PSO_samples[2,]
PSO_results$OR <- PSO_OR[1]
PSO_results$L95 <- PSO_OR[2]
PSO_results$U95 <- PSO_OR[3]
PSO_results <- cbind(PSO_results, PSO_samples)


#save in excel spreadsheet
#install.packages("xlsx")
library(xlsx)
write.xlsx(PSO_results, file="O:/Eczema_MR_project/PsC_correlation_no_HLA.xlsx")

#for PSO vs ECZ
#********************************
PSO_GRS_ECZ_results <- tidy(PSO_GRS_ECZ_reg)
PSO_GRS_ECZ_results <- PSO_GRS_ECZ_results[2,]
#ECZ_results$OR <- exp(ECZ_results$estimate)

#calcualte confidence intervals and OR:
OR <- exp(cbind(OR=coef(PSO_GRS_ECZ_reg), confint.default(PSO_GRS_ECZ_reg)))
OR <- OR[2,]

#define number of cases and controls
#install.packages("plyr")
library(plyr)

ECZ_samples <- as.data.frame(t(count(fam$ECZ)))
colnames(ECZ_samples)[1] <- "controls"
colnames(ECZ_samples)[2] <- "cases"
ECZ_samples <- ECZ_samples[2,]
PSO_GRS_ECZ_results$OR <- OR[1]
PSO_GRS_ECZ_results$L95 <- OR[2]
PSO_GRS_ECZ_results$U95 <- OR[3]
PSO_GRS_ECZ_results <- cbind(PSO_GRS_ECZ_results, ECZ_samples)


#save in excel spreadsheet
#install.packages("xlsx")
library(xlsx)
write.xlsx(PSO_GRS_ECZ_results, file="O:/Eczema_MR_project/PsC_GRS_ECZ_correlation_no_HLA.xlsx")


#save(fam, PSO_ECZ_reg, PSO_ECZ_results, ECZ, PSO, ECZ_results, ECZ_reg,
 #    file= "O:/Eczema_MR_project/Eczema_vs_BMI/Eczema/noncancer_PSO_regression.RData")





#separate out non cancer codes from bd dataframe so easier to work with
#NCIllness <- grep("20002", colnames(GRSpheno)) #gets column numbers
#ncillness <- GRSpheno[,NCIllness] #puts them in a df- so have a df of just non-cancer illnesses with all 3 instances

#Import the codes for the 20002 data - taken from spreadsheet provided with data-coding in biobank and saved as a txt file
#nonccodes = read.csv("O:/Eczema_MR_project/UK_Biobank/non_cancer_codes.txt", sep="\t", header=T)
#id <- GRSpheno$id # put id in a list
#phewas<- data.frame(id) #put id into a new dataframe

#loop through the 20002 codes - this just searches for the code which spans all 3 instances - and puts the variable in a df labeled as 1, 0
#taken out Eczema code (1452) from this list
#for(i in nonccodes$coding)
 # if(i== "1452")
#  var <- which(apply(ncillness, 2, function(x) any(grep(i, x)))) # will pull out from the columns which have the code 'i' in them
#  vardf <- as.data.frame(ifelse(ncillness[ ,var] == i, 1, 0)) # puts the columns into a df and labels it as 1=yes, 0=no
#  vardf$var<- rowSums(vardf, na.rm =TRUE) #sums the rows in that df to give a column of that disorder
#  vardf$var[vardf$var == "2"|vardf$var =="3"]<- "1" # relabel 2 and 3 as 1 - 2 and 3 come about because if in all 3 instances then will add up.
#  phewas <- data.frame(phewas, vardf$var) # puts the variable into a df with the rest of them.
