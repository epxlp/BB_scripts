#Eczema GRS
#load("O:/Eczema_MR_project/Eczema_vs_BMI/Eczema/eczema_GRSpheno.RData")


#psoriasis GRS
load("O:/Eczema_MR_project/Eczema_vs_psoriasis/Psoriasis/psoriasis_GRSpheno.RData")

#pull Eczema phenotypes (non-cancer codes)
ECZ <- ifelse(GRSpheno$f.20002.0.0==1452 | GRSpheno$f.20002.0.1==1452 | GRSpheno$f.20002.0.2==1452 | GRSpheno$f.20002.0.3==1452 | GRSpheno$f.20002.0.4==1452 | GRSpheno$f.20002.0.5==1452 | GRSpheno$f.20002.0.6==1452 | GRSpheno$f.20002.0.7==1452 | GRSpheno$f.20002.0.8==1452 | GRSpheno$f.20002.0.9==1452 | GRSpheno$f.20002.0.10==1452 | GRSpheno$f.20002.0.11==1452 | GRSpheno$f.20002.0.12==1452 | GRSpheno$f.20002.0.13==1452 | GRSpheno$f.20002.0.14==1452 | GRSpheno$f.20002.0.15==1452 | GRSpheno$f.20002.0.16==1452 | GRSpheno$f.20002.0.17==1452 | GRSpheno$f.20002.0.18==1452 | GRSpheno$f.20002.0.19==1452 | GRSpheno$f.20002.0.20==1452 | GRSpheno$f.20002.0.21==1452 | GRSpheno$f.20002.0.22==1452 | GRSpheno$f.20002.0.26==1452 | GRSpheno$f.20002.0.27==1452 | GRSpheno$f.20002.0.28==1452,1,0)
#whoever doesn't have eczema is a control
ECZ[is.na(ECZ)] <- 0

#check number of cases/controls
length(ECZ[ECZ==0])
length(ECZ[ECZ==1])

#Identify those with hayfever or allergic rhinitis or eczema
#use for when defining hayfever/ECZ overlap for the first time.... else import ID's from text file below...

#HAY <- ifelse(GRSpheno$f.6152.0.0=="Hayfever, allergic rhinitis or eczema" | GRSpheno$f.6152.0.1=="Hayfever, allergic rhinitis or eczema" | GRSpheno$f.6152.0.2=="Hayfever, allergic rhinitis or eczema" | GRSpheno$f.6152.0.3=="Hayfever, allergic rhinitis or eczema" | GRSpheno$f.6152.0.4=="Hayfever, allergic rhinitis or eczema" |  GRSpheno$f.6152.1.0=="Hayfever, allergic rhinitis or eczema" | GRSpheno$f.6152.1.1=="Hayfever, allergic rhinitis or eczema" | GRSpheno$f.6152.1.2=="Hayfever, allergic rhinitis or eczema" | GRSpheno$f.6152.1.3=="Hayfever, allergic rhinitis or eczema" | GRSpheno$f.6152.1.4=="Hayfever, allergic rhinitis or eczema" | GRSpheno$f.6152.2.0=="Hayfever, allergic rhinitis or eczema" | GRSpheno$f.6152.2.1=="Hayfever, allergic rhinitis or eczema" | GRSpheno$f.6152.2.2=="Hayfever, allergic rhinitis or eczema" | GRSpheno$f.6152.2.3=="Hayfever, allergic rhinitis or eczema" | GRSpheno$f.6152.2.4=="Hayfever, allergic rhinitis or eczema",1,0)
#HAY[is.na(HAY)] <-0

#check number of cases/controls
#length(HAY[HAY==0])
#length(HAY[HAY==1])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 

#exclude individuals with hayfever/eczema from ECZ controls
#fam <- data.frame(id, ECZ, HAY) #make dataframe wth ECZ and hayfever/eczema individuals

#HAY_cases <- fam$HAY==1 #define indiv with hayfever and ecz
#ECZ_ctrl <- fam$ECZ==0 #define ECZ controls
#HAY_cases_id <- fam$id[which(HAY_cases)] #define ID's of hayfever plus eczema cases
#ECZ_ctrl_id <- fam$id[which(ECZ_ctrl)] #define ID's of eczema controls
#ECZ_ctrl_id <- as.data.frame(ECZ_ctrl_id)
#colnames(ECZ_ctrl_id)[1] <- "id"
#HAY_cases_id <- as.data.frame(HAY_cases_id)
#colnames(HAY_cases_id)[1] <- "id"

#ECZ_HAY <- merge(ECZ_ctrl_id, HAY_cases_id, by="id") #merge to get ID's which are hayfever/eczema cases within ECZ controls


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


#*****For PSO*********************************
#create dataframe with GRS score, phenotypes, sex, age and chip variables
fam <- data.frame(id, PSO, GRSpheno$SDscore, sex, GRSpheno$age, GRSpheno$chip)

#need to set the response variable (ECZ phenotype, which is your dependent variable that you are trying to predict) as a factor
fam$PSO <- factor(fam$PSO)

#perform logistic regression (see if independent variable (GRS score) can predict phenotype))
PSO_reg <- glm(fam$PSO ~ fam$GRSpheno.SDscore + fam$GRSpheno.age + fam$sex + fam$GRSpheno.chip, binomial)
summary(PSO_reg)

#extract results for fam$GRSpheno.SDscore

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

#**************for PSO vs ECZ********************************

#perform logistic regression (see if independent variable (GRS score) can predict PSO phenotype))
fam <- data.frame(id, ECZ, GRSpheno$SDscore, sex, GRSpheno$age, GRSpheno$chip)

#exclude individuals with hayfever/eczema from ECZ controls

ECZ_HAY <- read.table("O:/Eczema_MR_project/Eczema_vs_psoriasis/Psoriasis/AD_hayfever_ind.txt", header=T)

for(i in ECZ_HAY$id){
  fam <- fam[!fam$id ==i, ]
}

fam$ECZ <- factor(fam$ECZ)

PSO_GRS_ECZ_reg <- glm(fam$ECZ ~ fam$GRSpheno.SDscore + fam$GRSpheno.age + fam$sex + fam$GRSpheno.chip, binomial)
summary(PSO_GRS_ECZ_reg)

#install.packages("broom")
library(broom)

#extract results for fam$GRSpheno.SDscore

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
write.xlsx(PSO_GRS_ECZ_results, file="O:/Eczema_MR_project/PsO_GRS_ECZ_correlation.xlsx")


#save(fam, PSO_ECZ_reg, PSO_ECZ_results, ECZ, PSO, ECZ_results, ECZ_reg,
 #    file= "O:/Eczema_MR_project/Eczema_vs_BMI/Eczema/noncancer_PSO_regression.RData")


