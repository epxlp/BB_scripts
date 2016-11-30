#Extracting all variables of interest from bd for analysis 

#Load in cleaned pheno (exclusions ans MS remove) and merged data
load("O:/EBI fellowship/Biobank/GRSpheno.RData")


#variable number lists - linear - gone through and manually decided what type of analysis should be undertaken
lin <- scan("O:/EBI fellowship/Biobank/linear variable numbers.txt", sep="\t", what='character')
linlbl <- scan("O:/EBI fellowship/Biobank/linear variables labels.txt", sep="\t", what='character')


#pull out the variables that you are interested in into a dataframe from bd dataframe
#Note to self- grep(value=TRUE) gives the column names
linvar <- as.data.frame(GRSpheno$id) #put id into a new dataframe which the rest of the variables will be put into


#loop through the field IDs in 'lin' to pull out the appropriate columns
for(i in lin){
  vars <- grep(i, colnames(GRSpheno), value = TRUE) #for one field id pull out the columns names (grep(value=TRUE)) that have that number into a list
  df <- data.frame(matrix(NA, nrow = 114530, ncol=1)) #create an intermediary df with for the columns to go into
      for(k in vars){
      df[,k] <- as.data.frame(GRSpheno[,which(colnames(GRSpheno) == k)]) #pull out the columns with that field id, so over all the instances that they were collected, into df
    }
      df$mean <- rowMeans(df, na.rm=TRUE) #take the mean of the columns because have several instances sometimes - can do this for linear variables
      linvar <- data.frame(linvar, df$mean) #put the mean column into final df before looping back
}

#Turn 'do not know'/'prefer not to answer'  into NA
linvar[linvar == "-1"] <-NA
linvar[linvar == "-10"] <-NA

#put the names of columns in - put id manually in 
colnames(linvar) <- linlbl


#delete out certian variable which have nothing in them
del <- c("id", "Hand grip strength (left)", "Hand grip strength (right)") #nothing in them due to, presumably, who has been genotyped
linlm <- setdiff(linlbl, del) 

####test for normality ####

#generate normality plots - all going into one pdf

#can do it with ggplot anf qplot histogram - if doing in a loop, need 'print'
#library(ggplot2)
#pdf(file="O:/EBI fellowship/Biobank/histograms/plots.pdf")
#for(i in linlm) {
 # print(qplot(data=subset(linvar[,i], !is.na(linvar[,i])), geom="histogram", main = i, binwidth = 1))
#}
#dev.off()

#do it simply with histogram in R
pdf(file="O:/EBI fellowship/Biobank/histograms/plots.pdf")
for(i in linlm) {
  v<- subset(linvar[,i], !is.na(linvar[,i]))
 hist(v, main = i)
}
dev.off()

#?run a test for normality as well??

#run a linear regression on  variables in linlm
mylm <- lapply(linlm, function(x){
  lm(linvar[,x] ~ GRSpheno$SDscore + GRSpheno$age + GRSpheno$sex + GRSpheno$chip, na.action=na.exclude)
})


library(broom) # tidy it up
lm <- data.frame(matrix(NA, nrow = length(linlm), ncol = 5)) # creates a intermediatory dataframe in which to put the results of the variables analysed
#loop through the lm output of the variables in that age group and put beta coeff, sE and p value into a  dataframe 
for (k in 1:length(mylm)){
  lmout <- tidy(mylm[[k]]) # pulls out all coeffs into second intermediatory dataframe
  lm[k,] <- lmout[2,] # pulls out just the grs coeff into intermediatory dataframe
}
row.names(lm) <- linlm #names the variables in that age group
colnames(lm) <- colnames(lmout) #for merging the dataframes, need the same column names - so namelmb

n <- as.data.frame(colSums(!is.na(linvar)))# n numbers into dataframe
lm <- merge(lm, n, by="row.names")# merge into final dataset lm - couldd do it directly in line above but because grip strenght is 0 need to remove
row.names(lm) <- lm$Row.names #put row names back
lm$Row.names <- NULL #delete row name it made

mean <- as.data.frame(colMeans(linvar, na.rm=TRUE, dims=1))
lm <- merge(lm, mean, by="row.names")# merge into final dataset lm - couldd do it directly in line above but because grip strenght is 0 need to remove
row.names(lm) <- lm$Row.names 
lm$Row.names <- NULL

lm$term <- lm$statistic <- NULL #get rid of the statistics 'term'-just the SDscore names and 'statistic' - the t value

#get the confidence intervals
#apply confint in the linear model already run 
cis <- lapply(mylm, confint)

#don't need to rerun the model!
#cis <- lapply(linlm, function(x){
#  confint(lm(linvar[,x] ~ GRSpheno$SDscore + GRSpheno$age + GRSpheno$sex + GRSpheno$chip, na.action=na.exclude))
#})


lmconfit <- data.frame(matrix(NA, nrow = length(linlm), ncol = 3)) # creates a intermediatory dataframe in which to put the results of the variables analysed a that cetain age group
#loop through the lm output of the variables in that age group and put beta coeff, sE and p value into a  dataframe 
for (k in 1:length(cis)){
  lmout <- tidy(cis[[k]]) # pulls out all coeffs into second intermediatory dataframe
  lmconfit[k,] <- lmout[2,] # pulls out just the grs coeff into intermediatory dataframe
}
row.names(lmconfit) <- linlm #names the variables in that age group
colnames(lmconfit) <- colnames(lmout) #for merging the dataframes, need the same column names - so namelmb
lmconfit$.rownames <- NULL

#Append lm and lmconfit
lm <- merge(lm, lmconfit, by = "row.names")
row.names(lm) <- lm$Row.names #put row names back
lm$Row.names <- NULL #delete row name it made

#rename the columns in lm df
lmnames <- c("B coeff", "std.error", "p.value", "n nber", "mean", "CI 2.5%", "CI 97.5%")
colnames(lm) <- lmnames

#write lm df to an excel file
library(xlsx)
write.xlsx(lm, file= "O:/EBI fellowship/Biobank/linear regression.xlsx")

#save as an Rdata fil
save(linvar, lin, linlbl, GRSpheno, lm, cis, mylm,
     file= "O:/EBI fellowship/Biobank/linear variables.RData")

rm(list=ls())


#############################################
#####Logistic regression ######

#Load in cleaned pheno (exclusions ans MS remove) and merged data
load("O:/EBI fellowship/Biobank/GRSpheno.RData")


#variable number lists - linear - gone through and manually decided what type of analysis should be undertaken
logit <- scan("O:/EBI fellowship/Biobank/logistic variable numbers.txt", sep="\t", what='character')
logitlbl <- scan("O:/EBI fellowship/Biobank/logistic variable labels.txt", sep="\t", what='character') # added recoded variable names - see below

logitvar<- as.data.frame(GRSpheno$id) #put id into a new dataframe which the rest of the variables will be put into


#manually recode some of the variables so they make a bit more sense 
#Bipolar - yes - 'bipolar I Disoorder' and 'Bipolar II Disorder'
logitvar$Bipolar[GRSpheno$f.20126.0.0 == "1"|GRSpheno$f.20126.0.0 == "2"] <- "1" #yes
logitvar$Bipolar[GRSpheno$f.20126.0.0 == "0"] <- "0" #no
logitvar$Bipolar <- as.factor(logitvar$Bipolar) # turn it inot a facotr for logistic regression analysis

#Recurrent major depression - severe and moderate - yes
logitvar$RDepression[GRSpheno$f.20126.0.0 == "3"|GRSpheno$f.20126.0.0 == "4"] <- "1" #yes
logitvar$RDepression[GRSpheno$f.20126.0.0 == "0"] <- "0" # no
logitvar$RDepression <- as.factor(logitvar$RDepression) 

#Single major depresion episode
logitvar$SDepression[GRSpheno$f.20126.0.0 == "5"] <- "1" #yes
logitvar$SDepression[GRSpheno$f.20126.0.0 == "0"] <- "0" #no
logitvar$SDepression <- as.factor(logitvar$SDepression)

#recode sleep so yes= 1 and no =0 - is binary but currently coded as yes= 1 and no = 2 whihc confuses R!
#coding through the 3 instances
GRSpheno$f.1210.0.0[GRSpheno$f.1210.0.0 == "2"] <-"0"
GRSpheno$f.1210.1.0[GRSpheno$f.1210.1.0 == "2"] <-"0"
GRSpheno$f.1210.2.0[GRSpheno$f.1210.2.0 == "2"] <-"0"
#put it back to numeric
GRSpheno$f.1210.0.0 <- as.numeric(GRSpheno$f.1210.1.0)
GRSpheno$f.1210.1.0 <- as.numeric(GRSpheno$f.1210.1.0)
GRSpheno$f.1210.2.0 <- as.numeric(GRSpheno$f.1210.2.0)


#loop through the field IDs in logit to pull out the appropriate columns
for(i in logit){
  vars <- grep(i, colnames(GRSpheno), value = TRUE) #for one field id pull out the columns names (grep(value=TRUE)) that have that number into a vector
  df <- data.frame(matrix(NA, nrow = 114530, ncol=1)) #create an intermediary df with for the columns to go into
  for(k in vars){
    df[,k] <- as.data.frame(GRSpheno[,which(colnames(GRSpheno) == k)]) #pull out the columns with that field id, so over all the instances that they were collected, into df
  }
  df[df == -3 |df == -1] <- NA #Recode 'do not know'/'prefer not to answer'  into NA
  #everything is now coded as 1 and 0
  df$var<- rowSums(df, na.rm =TRUE)#sums the rows in that df to give a column of that disorder have several instances sometimes
  df$var[df$var == "2"|df$var =="3"]<- "1" # relabel 2 and 3 as 1 - 2 and 3 come about because if in all 3 instances then will add up.
  logitvar <- cbind(logitvar, df$var) #put that clumn into final df before looping back
}

#name the columns of logitvar with variable names
colnames(logitvar) <- logitlbl

#Be aware of the reference category - it's actually alright by chance but it is something to be aware of. 

#run a logistic regression on these variables
logitglm <- logitlbl[-1] # make a list over which to do logistic regression - take out id

#run logistic regression
mylogit <- lapply(logitglm, function(x){
  glm(logitvar[,x] ~ GRSpheno$SDscore + GRSpheno$age + GRSpheno$sex + GRSpheno$chip, na.action=na.exclude, family="binomial", maxit=100)
})

library(broom) # tidy it up
glm <- data.frame(matrix(NA, nrow = length(logitglm), ncol = 5)) # creates a intermediatory dataframe in which to put the results of the variables analysed a that cetain age group
#loop through the mylogit output of the variables in that age group and put beta coeff, sE and p value into a  dataframe 
for (k in 1:length(mylogit)){
  glmout <- tidy(mylogit[[k]]) # pulls out all coeffs into second intermediatory dataframe
  glm[k,] <- glmout[2,] # pulls out just the grs coeff into intermediatory dataframe
}
row.names(glm) <- logitglm #names the variables in that age group
colnames(glm) <- colnames(glmout) #for merging the dataframes, need the same column names - so namelmb

glm$estimate <- exp(glm$estimate) #expontiatitate the estimates to get the Odds ratio
glm$term <- glm$statistic <- NULL #get rid of the statistics 'term'-just the SDscore names and 'statistic' - the t value

#get the confidence intervals
#apply confint in the linear model already run 
cis <- lapply(mylogit, confint)

#don't need to rerun the model!
#cis <- lapply(logitglm, function(x){
#  confint(glm(logitvar[,x] ~ GRSpheno$SDscore + GRSpheno$age + GRSpheno$sex + GRSpheno$chip, na.action=na.exclude, family="binomial", maxit=100))
#})

glmconfit <- data.frame(matrix(NA, nrow = length(logitglm), ncol = 3)) # creates a intermediatory dataframe in which to put the results of the variables analysed 
#loop through the lm output of the variables in that age group and put beta coeff, sE and p value into a  dataframe 
for (k in 1:length(cis)){
  glmout <- tidy(cis[[k]]) # pulls out all coeffs into second intermediatory dataframe
  glmconfit[k,] <- glmout[2,] # pulls out just the grs coeff into intermediatory dataframe
}


row.names(glmconfit) <- logitglm #names the variables in that age group
colnames(glmconfit) <- colnames(glmout) #for merging the dataframes, need the same column names - so namelmb
glmconfit$.rownames <- NULL

glmconfit <- exp(glmconfit)

#Append glm and lgmconfit - don't do it with merge as it changes the order of variables!
glm <- cbind(glm, glmconfit)


#want to get the n nber in each category
library(plyr)
n2  <- data.frame(matrix(NA, nrow = 1, ncol = 1)) #create a df to put it into
#loop through logitglm and get freq in each category with count from plyr package
for(i in logitglm){
  nmber <- as.data.frame(t(count(logitvar[,i])))
  n <- nmber[2,]
  n2 <- rbind.fill(n2, n) # rbind.fill combines the df with differnt number of columns
  #n$n <- length(na.omit(logitvar[,i]))# n will always be 114 530 as I have set it at that
}
n2[,1] <- NULL # get rid of first column
n2 <- n2[-1,] # get rid of first row

#Append n2 and glm
glm<- cbind(glm, n2)

#rename the columns in glm df
glmnames <- c("Odds ratio", "std.error", "p.value", "CI 2.5%", "CI 97.5%", "No", "Yes", "NA" )
colnames(glm) <- glmnames

library(xlsx)
write.xlsx(glm, file= "O:/EBI fellowship/Biobank/logistic regression.xlsx")

save(logit, logitvar, logitlbl, glm, mylogit, cis, logitglm,
     file= "O:/EBI fellowship/Biobank/logistic variables.RData")

rm(list=ls())


###########################
#####cat ordered######
#Only used the first instance as quite complicated to use all 3 due to the way it's coded and also people have changed between the 3

#Load in cleaned pheno (exclusions ans MS remove) and merged data
load("O:/EBI fellowship/Biobank/GRSpheno.RData")

#variable number lists - cat ordered - gone through and manually decided what type of analysis should be undertaken
catord <- scan("O:/EBI fellowship/Biobank/cat ordered variable numbers.txt", sep="\t", what='character')
catordlbl <- scan("O:/EBI fellowship/Biobank/cat ordered variable labels.txt", sep="\t", what='character')

catordvar<- as.data.frame(GRSpheno$id) #put id into a new dataframe which the rest of the variables will be put into
#loop through the filed IDs in lin to pull out the appropriate columns
for(i in catord){
  vars <- grep(i, colnames(GRSpheno), value = TRUE) #for one field id pull out the columns names that have that number
  df <- data.frame(matrix(NA, nrow = 114530, ncol=1)) #create an intermediary df with for the columns to go into
  for(k in vars){
    df[,k] <- as.data.frame(GRSpheno[,which(colnames(GRSpheno) == k)]) #pull out the columns with that field id, so over all the instances that they were collected, into df
  }
  df[df == -3 |df == -1] <- NA #Recode 'do not know'/'prefer not to answer'  into NA
  df <- as.data.frame(df[,2]) # only keep the first instance
  catordvar <- cbind(catordvar, df$`df[, 2]`) #put that column into final df of all variables before looping back
}

#label the dataframe with the variable names
colnames(catordvar) <- catordlbl




#don't need to recode variables as just using the first instance and I'm happy with that



#run an ordinal regression on these variables

catordvar <- data.frame(apply(catordvar, 2, as.factor)) # turn the variables into factors
#make a list of variables to perform ordinal regression on
catordpolr <- colnames(catordvar) 
catordpolr <- catordpolr[-1]

#need to set a reference category### - i think these are alright - might need to change them at some point...

#using polr from MASS package
library(MASS)

mypolr <- lapply(catordpolr, function(x){
  polr(catordvar[,x] ~ GRSpheno$SDscore + GRSpheno$age + GRSpheno$sex + GRSpheno$chip, na.action=na.exclude, Hess=TRUE)
})

polr <- data.frame(matrix(NA, nrow = length(catordpolr), ncol = 3)) # creates a intermediatory dataframe in which to put the results of the variables analysed a that cetain age group
colnames(polr) <- c("Value", "Std. Error", "t value" )

#can't us broom to tidy polr so do it 'manually'
for(i in 1:length(mypolr)){
  polrout <- as.data.frame(coef(summary(mypolr[[i]])))
  polr[i,] <- polrout[1,]
  p <- pnorm(abs(polr[, "t value"]), lower.tail = FALSE) * 2
  polr$p <- p
  polr$OR <- exp(polr$Value)
  #Calculate CI from standard errors - have already exp the estimates so don't need to do it to CIs
  lower <- polr$OR - 1.96* polr$`Std. Error`
  polr$lower <- lower
  upper <- polr$OR + 1.96* polr$`Std. Error`
  polr$upper <- upper
}



  polrout <- as.data.frame(coef(summary(mypolr[[4]])))
   p <- pnorm(abs(polrout[, "t value"]), lower.tail = FALSE) * 2
  polrout$p <- p
  polrout$OR <- exp(polrout$Value)


## takes too long - so calculated them from the standard errors
#ci <- confint(m)
#  polrci <- data.frame(matrix(NA, nrow = length(catordpolr), ncol = 2))
 # for(i in 1:length(mypolr)){
  #  polroutci <- as.data.frame(confint(mypolr[[i]]))
   # polrci[i,] <- polroutci[1,]
  #}

row.names(polr) <- catordpolr

polr$Value <- polr$`t value` <-  NULL #get rid of the statistics 'term'-just the SDscore names and 'statistic' - the t value

polr <- polr[c("OR", "Std. Error", "lower", "upper", "p" )] # reorder the columns

#get numbers for each of the categories
library(plyr)
n2  <- data.frame(matrix(NA, nrow = 1, ncol = 1))
for(i in catordpolr){
  nmber <- as.data.frame(t(count((catordvar[,i]))))
  n <- nmber[2,]
  n2 <- rbind.fill(n2, n)
  #n$n <- length(na.omit(logitvar[,i]))# n will always be 114 530 as I have set it at that
}

n2[,1] <- NULL # get rid of first column
n2 <- n2[-1,] # get rid of first row

#Append n2 and glm
polr<- cbind(polr, n2)

polr$name <- catordpolr



library(xlsx)
write.xlsx(polr, file= "O:/EBI fellowship/Biobank/cat ordered regression.xlsx")

save(catord, catordvar, catordlbl, catordpolr, mypolr, polr, 
     file= "O:/EBI fellowship/Biobank/cat ordered variables.RData")

rm(list=ls())



###########################
#####cat unordered######

#Load in cleaned pheno (exclusions ans MS remove) and merged data
load("O:/EBI fellowship/Biobank/GRSpheno.RData")

#variable number lists - cat ordered - gone through and manually decided what type of analysis should be undertaken
unord <- scan("O:/EBI fellowship/Biobank/cat unordered variable numbers.txt", sep="\t", what='character')
unordlbl <- scan("O:/EBI fellowship/Biobank/cat unordered variable labels.txt", sep="\t", what='character')

unordvar<- as.data.frame(GRSpheno$id) #put id into a new dataframe which the rest of the variables will be put into

#loop through the field IDs in lin to pull out the appropriate columns
for(i in unord){
  vars <- grep(i, colnames(GRSpheno), value = TRUE) #for one field id pull out the columns names (grep(value=TRUE)) that have that number
  df <- data.frame(matrix(NA, nrow = 114530, ncol=1)) #create an intermediary df with for the columns to go into
  for(k in vars){
    df[,k] <- as.data.frame(GRSpheno[,which(colnames(GRSpheno) == k)]) #pull out the columns with that field id, so over all the instances that they were collected, into df
  }
  df[df == -3 |df == -1] <- NA
  df <- as.data.frame(df[,2])
  unordvar <- cbind(unordvar, df$`df[, 2]`) #put that clumn into final df before looping back
}

colnames(unordvar) <- unordlbl


unordvar <- data.frame(apply(unordvar, 2, factor))
unordmultinom <- colnames(unordvar)
unordmultinom <- unordmultinom[-1]




## choose reference (category with largest frequency)
for(i in unordmultinom){
  tt <- table(unordvar[,i])
  max <- names(which.max(tt))
  unordvar[,i]<- relevel(unordvar[,i], ref= max)
}


tt <- table(unordvar$Eye.disorders)
max <- names(which.max(tt))
unordvar$Eye.disorders <- relevel(unordvar$Eye.disorders, ref= max)


library(nnet)


mymultinom <- lapply(unordmultinom, function(x){
 multinom(unordvar[,x] ~ GRSpheno$SDscore + GRSpheno$age + GRSpheno$sex + GRSpheno$chip, na.action=na.exclude, Hess = TRUE)
})

multi <- data.frame(matrix(NA, nrow = length(unordmultinom), ncol = 3)) # creates a intermediatory dataframe in which to put the results of the variables analysed a that cetain age group
colnames(multi) <- c("Value", "Std. Error", "t value" )



sumx <- summary(mymultinom[[1]])

library(ordinal)
mymultinom <- lapply(unordmultinom, function(x){
  clm(unordvar[,x] ~ GRSpheno$SDscore + GRSpheno$age + GRSpheno$sex + GRSpheno$chip, na.action=na.exclude, Hess = TRUE)
})

for (i in unordmultinom){
  mymultinom <- multinom(unordvar[,i] ~ GRSpheno$SDscore + GRSpheno$age + GRSpheno$sex + GRSpheno$chip, na.action=na.exclude, Hess = TRUE)
  multiout <- summary(mymultinom)
  }

for(i in 1:length(mymultinom)){
  multiout <- as.data.frame(coef(mymultinom[[i]]))
  multi[i,] <- multiout[1,]
  p <- pnorm(abs(multi[, "t value"]), lower.tail = FALSE) * 2
  multi$p <- p
  multi$OR <- exp(multi$Value)
  #Calculate CI from standard errors
  lower <- multi$OR - 1.96* multi$`Std. Error`
  multi$lower <- lower
  upper <- multi$OR + 1.96* multi$`Std. Error`
  multi$upper <- upper
}


