#Read in GRS generated in plink that has NonEuros, recommended and relateds already excluded
GRS <- read.table("Y:/Biobank/GRS_sex_mismatch_not_removed/bb_GRS_from_final_corrected.profile", header=TRUE)

#remove unwanted columns: IID, pheno, CNT, CNT2; leaving FID and score
GRS <- GRS[,-c(2:5)]

#create mean and SD of score as vectors
mean <- mean(GRS$SCORE)
sd <- sd(GRS$SCORE)

#create standardized score using z transformation - putting in as a column in GRS df
GRS$SDscore <- ((GRS$SCORE - mean)/sd)

#histogram of SDscore - for look-see-ies
hist(GRS$SDscore) 

#rename FID to id - to match phewas file
library(reshape)
GRS <- rename(GRS, c(FID="id"))

#save - to be able to load it later on
save(GRS, file = "O:/EBI fellowship/Biobank/GRS/SDscore.RData")

