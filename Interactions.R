
library(data.table)
library(pryr)

setwd("~/Desktop/g1000_phase3/")

# set directory where plink.exe is located
userdir <- 'Emily/Software/plink'

nsnps <- c(2,5,10,50,100,500,1000,5000,10000,50000, 100000, 500000)

# read in .bim file
bim <- fread("./g1000_phase3_geno.bim", header=F, data.table=F)

#loops through all specified nSNPs
for (i in 1: length(nsnps)){
	
  # start clock
	start_time<- Sys.time()
	ram <- c()
	
	# randomly sample N rows from total genome
	a<- sample(1:nrow(bim), nsnps[i], replace=F)
	# write to table, store as text
	write.table(bim[a,2], paste("./", nsnps[i], "SNPs.txt", sep=""), col.names=F, row.names=F, quote=F)
	
	# filter out all variants not in the provided file
	command <- sprintf("/Users/%s/plink --bfile ./g1000_phase3_geno --extract %sSNPs.txt --recodeA --out g1000_phase3_geno_%sSNPs", userdir,nsnps[i], nsnps[i])
	system(command)
	ram <- c(ram, mem_used())
	
	# format into dataframe
	data <- fread(paste("./g1000_phase3_geno_", nsnps[i], "SNPs.raw", sep=""), header=T, data.table=F)
	ram <- c(ram, mem_used())
	
	# set an arbitrary probability of the phenotype occurring at 30% 
	data$PHENOTYPE <- rbinom(1:nrow(data), size=1, prob=0.3)
	  # in real data this would be provided as a separate column in the input
	
	# return binomial coefficients, format into dataframe
	nresults <- choose(nsnps[i], 2)
	results <- data.frame(matrix(nrow=nresults, ncol=17))
	colnames(results)<- c("SNP1", "SNP2", "SNP1_BETA_CRUDE", "SNP1_SE_CRUDE", "SNP1_P_CRUDE", "SNP2_BETA_CRUDE", "SNP2_SE_CRUDE", "SNP2_P_CRUDE", "SNP1_BETA_ADJ", "SNP1_SE_ADJ", "SNP1_P_ADJ", "SNP2_BETA_ADJ", "SNP2_SE_ADJ", "SNP2_P_ADJ", "INT_BETA", "INT_SE", "INT_P")
	ram <- c(ram, mem_used())
	
	count <- 0
	
	for (x in 1:(nsnps[i]-1)){
		for (y in (x+1):nsnps[i]){
			
			count <- count+1
			
			# gather all results into table
			results[count, 1] <- as.character(colnames(data)[(x+6)])
			results[count, 2] <- as.character(colnames(data)[(y+6)])
			
			fit1 <- glm(PHENOTYPE ~ data[, (x+6)], family="binomial", data=data)
			ram <- c(ram, mem_used())	
			results[count, 3] <- as.numeric(summary(fit1)$coefficients[2,1])
			results[count, 4] <- as.numeric(summary(fit1)$coefficients[2,2])
			results[count, 5] <- as.numeric(summary(fit1)$coefficients[2,4])
			
			fit2 <- glm(PHENOTYPE ~ data[, (y+6)], family="binomial", data=data)
			ram <- c(ram, mem_used())	
			results[count, 6] <- as.numeric(summary(fit2)$coefficients[2,1])
			results[count, 7] <- as.numeric(summary(fit2)$coefficients[2,2])
			results[count, 8] <- as.numeric(summary(fit2)$coefficients[2,4])
			
			fit3 <- glm(PHENOTYPE ~ data[, (x+6)] + data[, (y+6)] + data[, (x+6)]*data[, (y+6)], family="binomial", data=data)			
			ram <- c(ram, mem_used())
			results[count, 9] <- as.numeric(summary(fit3)$coefficients[2,1])
			results[count, 10] <- as.numeric(summary(fit3)$coefficients[2,2])
			results[count, 11] <- as.numeric(summary(fit3)$coefficients[2,4]	)
			results[count, 12] <- as.numeric(summary(fit3)$coefficients[3,1])
			results[count, 13] <- as.numeric(summary(fit3)$coefficients[3,2])
			results[count, 14] <- as.numeric(summary(fit3)$coefficients[3,4]	)
			if (nrow(summary(fit3)$coefficients)==4){
				results[count, 15] <- as.numeric(summary(fit3)$coefficients[4,1])
				results[count, 16] <- as.numeric(summary(fit3)$coefficients[4,2])
				results[count, 17] <- as.numeric(summary(fit3)$coefficients[4,4])
			}
			if (nrow(summary(fit3)$coefficients)<4){
				results[count, 15] <- NA
				results[count, 16] <- NA
				results[count, 17] <- NA				
			}
		}
	}
	
	# order table by ascending p-value
	results <- results[order(as.numeric(results$INT_P)), ]
	ram <- c(ram, mem_used())	
	write.table(results, paste("./Results_interactions_g1000_phase3_geno_", nsnps[i], "SNPs.txt", sep=""), col.names=T, row.names=F, quote=F, sep="\t")
	ram <- c(ram, mem_used())
  
	# output time and memory usage
	print(paste(nsnps[i], "SNPs", sep=""))	
	print("Computational time:")
	print(Sys.time()-start_time)
	print("Memory Used (GB):")
	print(max(ram/1024^3))
	
}
