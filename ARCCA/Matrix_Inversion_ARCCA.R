

library(data.table)
library(pryr)

print('Analysis Started')
ram <- c()
# nsnps <- c(2,5,10,20,50,100,200,500,1000,2000,5000,10000,20000,50000)
nsnps <- c(2,5,10,20,50,100,200,500,1000,2000,5000,10000)

# loop through all the nSNPs
for (i in 1: length(nsnps)){
	
  # start the clock
	start_time<- Sys.time()
	
	# format into dataframe
	data <- fread(paste("./g1000_phase3_geno_", nsnps[i], "SNPs.raw", sep=""), header=T, data.table=F)
	ram <- c(ram, mem_used())

	for (j in 7:ncol(data)){
		data[which(is.na(data[,j])), j]<- 0 # set missing data to zero
	}
	
	# perform correlation
	co <- cor(as.matrix(data[, 7:ncol(data)]))
	
	# this is a bit of a hack, turns all NA to zero
	co[is.na(co)] <- 0
	
	ram <- c(ram, mem_used())
	
	# generate eigenvalues and eigenvectors
	ee <- eigen(co)
	ram <- c(ram, mem_used())
	la0<-1/sqrt(nrow(data))
  
	# matrix multiplication(s)
	PM<-ee$vectors %*% diag(sqrt((1+la0)/(ee$values+la0))) %*% t(ee$vectors)
	ram <- c(ram, mem_used())
	data_adj<- PM %*% t(data.matrix(data[,7:ncol(data)]))	
	ram <- c(ram, mem_used())
	
	# bind tables together
	data_adj <- cbind(data[, 1:6], t(data_adj))
	colnames(data_adj)<- colnames(data)
	
	# output data to results file
	write.table(data_adj, paste("./Results_LDadjusted_g1000_phase3_geno_", nsnps[i], "SNPs.raw", sep=""), col.names=T, row.names=F, quote=F, sep="\t")
	ram <- c(ram, mem_used())
	
	# return time and memory usage
	print(paste(nsnps[i], "SNPs", sep=""))	
	print("Computational time:")
	print(Sys.time()-start_time)
	print("Memory Used:")
	print(max(ram))
	
}

