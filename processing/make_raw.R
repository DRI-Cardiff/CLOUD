
library(data.table)
library(pryr)

setwd("E:/WorkPCBackup/DRI/D Drive/CLOUD_temp/g1000_phase3_plink")

# set directory where plink.exe is located
userdir <- "E:/WorkPCBackup/DRI/D Drive/CLOUD_temp/g1000_phase3_plink"

nsnps <- c(2,5,10,50,100,500,1000,5000,10000,50000, 100000, 500000)

# read in .bim file
bim <- fread("./g1000_phase3_geno.bim", header=F, data.table=F) 
#loops through all specified nSNPs
for (i in 1: length(nsnps)){
  
  # randomly sample N rows from total genome
  a <- sample(1:nrow(bim), nsnps[i], replace=F)
  # write to table, store as text
  write.table(bim[a,2], paste("./", nsnps[i], "SNPs.txt", sep=""), col.names=F, row.names=F, quote=F)
  
  # filter out all variants not in the provided file, recode into new file
  command <- sprintf("/%s/plink --bfile ./g1000_phase3_geno --extract %sSNPs.txt --recodeA --out g1000_phase3_geno_%sSNPs", userdir, nsnps[i], nsnps[i])
  system(command)
}