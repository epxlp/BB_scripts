load("O:/EBI fellowship/Biobank/GRSpheno.RData")

#separate out non cancer codes from bd dataframe so easier to work with
NCIllness <- grep("20002", colnames(GRSpheno)) #gets column numbers
ncillness <- GRSpheno[,NCIllness] #puts them in a df- so have a df of just non-cancer illnesses with all 3 instances

#Import the codes for the 20002 data - taken from spreadsheet provided with data-coding in biobank and saved as a txt file
nonccodes=scan("O:\\EBI fellowship\\Biobank\\tab delimited non cancer codes.txt",sep="\t")
id <- GRSpheno$id # put id in a list
phewas<- data.frame(id) #put id into a new dataframe


#loop through the 20002 codes - this just searches for the code whic spans all 3 instances - and puts the variable in a df labeled as 1, 0
#taken out MS code (1261) from this list
for(i in nonccodes){
  if(i== "1339") next # no 1339 sickle cell disease among the 114 530 that have currently been genotyped - might need to rethink this when 500 000 come out
  if(i=="1581") next # no 1581 hepatitis d among the 114 530 that have currently been genotype
  if(i=="1582") next #hepatitis e
  if(i=="1674") next #varicella zoster virus
  if(i=="1682") next #benign insulinoma
  var <- which(apply(ncillness, 2, function(x) any(grep(i, x)))) # will pull out from the columns which have the code 'i' in them
  vardf <- as.data.frame(ifelse(ncillness[,var] == i, 1, 0)) # puts the columns into a df and labels it as 1=yes, 0=no
  vardf$var<- rowSums(vardf, na.rm =TRUE) #sums the rows in that df to give a column of that disorder
  vardf$var[vardf$var == "2"|vardf$var =="3"]<- "1" # relabel 2 and 3 as 1 - 2 and 3 come about because if in all 3 instances then will add up.
  phewas <- data.frame(phewas, vardf$var) # puts the variable into a df with the rest of them.
}

#read in the names from 20002 data - taken from spreadsheet provided with data-coding in biobank and saved as a txt file
library(xlsx)
noncnames <- read.xlsx("O:\\EBI fellowship\\Biobank\\20002 names.xlsx", sheetIndex = 1)
noncnames <- as.data.frame(noncnames[!noncnames$names %in% c("sickle cell disease", "hepatitis d", "hepatitis e", "varicella zoster virus", "benign insulinoma"),])
colnames(phewas) <- noncnames$`noncnames[!noncnames$names %in% c("sickle cell disease", "hepatitis d", "hepatitis e", "varicella zoster virus", "benign insulinoma"), ]`# label the columns with the names - have looped through the codes in the same order

#save as df of non cancer illness - phewas: just id and single variables in phewas
save(ncillness, phewas, NCIllness, nonccodes, noncnames,
     file= "O:\\EBI fellowship\\Biobank\\Noncancerillness no ms.RData")


#add age and sex to phewas table as will need for covariates
phewas$sex <- GRSpheno$sex
phewas$age <- GRSpheno$age
phewas$SDscore <- GRSpheno$SDscore
phewas$chip <- GRSpheno$chip

#save phewas in a separate file to be able to do the analysis on it.
save(phewas, file= "O:/EBI fellowship/Biobank/binary20002.Rdata")

#load in phewas 
rm(list=ls())
load("O:/EBI fellowship/Biobank/binary20002.Rdata")


#Analyse phewas df which is just binary.
vars20002 <- colnames(phewas) # 
delete <- c("id", "SCORE", "SDscore", "sex", "age", "chip")
vars20002 <- setdiff(vars20002, delete) # remove columns that I don't need in the analysis.

#save for blue crystal as R running out of memory here
save(phewas, vars20002, file="O:/EBI fellowship/Biobank/20002 data for BC.RData")


#all the variables are factors so don't need to transform them 
mylogit <- lapply(vars20002, function(x){
  glm(phewas[,x] ~ phewas$SDscore + phewas$age + phewas$sex + phewas$chip, family="binomial", maxit=100)
}) # need the maxit otherwise won't converge


#put results it into a dataframe
library(broom)
glm <- data.frame(matrix(NA, nrow = length(vars20002), ncol = 5)) # creates a intermediatory dataframe in which to put the results of the variables analysed a that cetain age group
#loop through the lm output of the variables in that age group and put beta coeff, sE and p value into a  dataframe 
for (k in 1:length(mylogit)){
  glmout <- tidy(mylogit[[k]]) # pulls out all coeffs into second intermediatory dataframe
  glm[k,] <- glmout[2,] # pulls out just the grs coeff into intermediatory dataframe
}
row.names(glm) <- vars20002 #names the variables in that age group
colnames(glm) <- colnames(glmout) #for merging the dataframes, need the same column names - so namelmb

glm$estimate <- exp(glm$estimate)
glm$term <- glm$statistic <- NULL #get rid of the statistics 'term'-just the SDscore names and 'statistic' - the t value

library(plyr)
n  <- data.frame(matrix(NA, nrow = 10, ncol = 2))
n2  <- data.frame(matrix(NA, nrow = 1, ncol = 2))
for(i in vars20002){
  nmber <- as.data.frame(t(count((phewas[,i]))))
  n <- nmber[2,]
  colnames(n2) <- colnames(n)
  n2 <- rbind(n2, n)
  #n$n <- length(na.omit(logitvar[,i]))# n will always be 114 530 as I have set it at that
}
n2 <-n2[-1,]
row.names(n2) <- vars20002 #names the variables in that age group
colnames(n2) <- c("No", "Yes")
glm <- merge(glm, n2, by = "row.names")
row.names(glm) <- glm$Row.names #put row names back
glm$Row.names <- NULL #delete row name it made

cis <- lapply(vars20002, function(x){
  confint(glm(phewas[,x] ~ phewas$SDscore + phewas$age + phewas$sex + phewas$chip, family="binomial", maxit=100))
})
glmconfit <- data.frame(matrix(NA, nrow = length(vars20002), ncol = 3)) # creates a intermediatory dataframe in which to put the results of the variables analysed a that cetain age group
#loop through the lm output of the variables in that age group and put beta coeff, sE and p value into a  dataframe 
for (k in 1:length(cis)){
  glmout <- tidy(cis[[k]]) # pulls out all coeffs into second intermediatory dataframe
  glmconfit[k,] <- glmout[2,] # pulls out just the grs coeff into intermediatory dataframe
}


#Append lm and lmconfit
row.names(glmconfit) <- vars20002 #names the variables in that age group
colnames(glmconfit) <- colnames(glmout) #for merging the dataframes, need the same column names - so namelmb
glmconfit$.rownames <- NULL

#Append lm and lmconfit
glm <- merge(glm, glmconfit, by = "row.names")
row.names(glm) <- glm$Row.names #put row names back
glm$Row.names <- NULL #delete row name it made

library(xlsx)
write.xlsx(glm, file= "O:/EBI fellowship/Biobank/noncancer no ms regression.xlsx")

save(phewas, vars20002, glm, cis, mylogit, glmconfit,
     file= "O:/EBI fellowship/Biobank/noncancer no ms regression.RData")

