#Read in GRS generated in plink that has NonEuros, recommended and relateds already excluded
GRS <- read.table("./biobank_psoriasis/psoriasis_grs.profile", header=TRUE)

#remove unwanted columns: IID, pheno, CNT, CNT2; leaving FID and score
GRS <- GRS[,-c(2:5)]

#create mean and SD of score as vectors
mean <- mean(GRS$SCORE)
sd <- sd(GRS$SCORE)

#create standardized score using z transformation (subtracting the mean and dividing by the SD)- putting in as a column in GRS df
GRS$SDscore <- ((GRS$SCORE - mean)/sd)

#rename FID to id - to match phewas file
library(reshape)
GRS <- rename(GRS, c(FID="id"))

#write to file
write.table(GRS, file="./biobank_psoriasis/psoriasis_grs_sd.profile", quote=F, sep=" ", row.names=F)

#get summary of data
summary <- summary(GRS)
write.table(summary, file="./biobank_psoriasis/summary_GRS.txt", quote=F, sep = " ", row.names=F)


#histogram of SDscore - for look-see-ies

pdf("./biobank_psoriasis/SD_GRS_psoriasis.pdf", width=10, height=10)

plot <- hist(GRS$SDscore, col = "grey", xlab="Weighted risk score", main = "Distribution of weighted genetic risk score (Psoriasis SNPs)") 

dev.off()



#save - to be able to load it later on
save(GRS, file = "biobank_psoriasis/psoriasis_grs_SDscore.RData")
