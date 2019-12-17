

library(data.table)
library(pryr)

setwd("~/Desktop/g1000_phase3/")

start_time<- Sys.time()

nsnps <- c(2,5,10,50,100,500,1000,5000,10000,50000, 100000, 500000)

bim <- fread("./g1000_phase3_geno.bim", header=F, data.table=F)

for (i in 1: length(nsnps)){
	
	start_time<- Sys.time()
	ram <- c()	
	
	a<- sample(1:nrow(bim), nsnps[i], replace=F)
	
	write.table(bim[a,2], paste("./", nsnps[i], "SNPs.txt", sep=""), col.names=F, row.names=F, quote=F)
	
	command <- sprintf("/Users/Emily/Software/plink/plink --bfile ./g1000_phase3_geno --extract %sSNPs.txt --recodeA --out g1000_phase3_geno_%sSNPs", nsnps[i], nsnps[i])
	system(command)
	ram <- c(ram, mem_used())
	
	data <- fread(paste("./g1000_phase3_geno_", nsnps[i], "SNPs.raw", sep=""), header=T, data.table=F)
	ram <- c(ram, mem_used())

	for (j in 7:ncol(data)){
		data[which(is.na(data[,j])), j]<- 0
	}
	
	co <- cor(as.matrix(data[, 7:ncol(data)]))
	ram <- c(ram, mem_used())
	
	ee <- eigen(co)	
	ram <- c(ram, mem_used())
	la0<-1/sqrt(nrow(data))
 
	PM<-ee$vectors %*% diag(sqrt((1+la0)/(ee$values+la0))) %*% t(ee$vectors)
	ram <- c(ram, mem_used())
	data_adj<- PM %*% t(data.matrix(data[,7:ncol(data)]))	
	ram <- c(ram, mem_used())
	
	data_adj <- cbind(data[, 1:6], t(data_adj))
	colnames(data_adj)<- colnames(data)
	
	write.table(data_adj, paste("./Results_LDadjusted_g1000_phase3_geno_", nsnps[i], "SNPs.raw", sep=""), col.names=T, row.names=F, quote=F, sep="\t")
	ram <- c(ram, mem_used())
	
	print(paste(nsnps[i], "SNPs", sep=""))	
	print("Computational time:")
	print(Sys.time()-start_time)
	print("Memory Used:")
	print(max(ram/1000000000))
	
}

