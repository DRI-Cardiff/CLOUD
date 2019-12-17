
setwd("~/Desktop/g1000_phase3/")


for (chr in 1:22){

	command <- sprintf("~/Software/plink/plink --vcf ALL.chr%s.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz --make-bed --out g1000_phase3_geno_chr%s", chr, chr)
	system(command)

}


###########

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr1 --bmerge g1000_phase3_geno_chr2 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr1 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr1")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr2 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr2")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr1 --bmerge g1000_phase3_geno_chr2 --make-bed --out test2")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test2 --bmerge g1000_phase3_geno_chr3 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr3 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr3")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test2 --bmerge g1000_phase3_geno_chr3 --make-bed --out test3")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test3 --bmerge g1000_phase3_geno_chr4 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr4 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr4")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test3 --bmerge g1000_phase3_geno_chr4 --make-bed --out test4")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test4 --bmerge g1000_phase3_geno_chr5 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr5 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr5")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test4 --bmerge g1000_phase3_geno_chr5 --make-bed --out test5")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test5 --bmerge g1000_phase3_geno_chr6 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr6 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr6")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test5 --bmerge g1000_phase3_geno_chr6 --make-bed --out test6")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test6 --bmerge g1000_phase3_geno_chr7 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr7 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr7")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test6 --bmerge g1000_phase3_geno_chr7 --make-bed --out test7")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test7 --bmerge g1000_phase3_geno_chr8 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr8 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr8")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test7 --bmerge g1000_phase3_geno_chr8 --make-bed --memory 32000 --out test8")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test8 --bmerge g1000_phase3_geno_chr9 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr9 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr9")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test8 --bmerge g1000_phase3_geno_chr9 --make-bed --memory 32000 --out test9")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test9 --bmerge g1000_phase3_geno_chr10 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr10 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr10")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test9 --bmerge g1000_phase3_geno_chr10 --make-bed --memory 32000 --out test10")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test10 --bmerge g1000_phase3_geno_chr11 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr11 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr11")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test10 --bmerge g1000_phase3_geno_chr11 --make-bed --memory 32000 --out test11")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test11 --bmerge g1000_phase3_geno_chr12 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr12 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr12")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test11 --bmerge g1000_phase3_geno_chr12 --make-bed --memory 32000 --out test12")
system(command)

######

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test12 --bmerge g1000_phase3_geno_chr13 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr13 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr13")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test12 --bmerge g1000_phase3_geno_chr13 --make-bed --memory 32000 --out test13")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test13 --bmerge g1000_phase3_geno_chr14 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr14 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr14")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test13 --bmerge g1000_phase3_geno_chr14 --make-bed --memory 32000 --out test14")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test14 --bmerge g1000_phase3_geno_chr15 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr15 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr15")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test14 --bmerge g1000_phase3_geno_chr15 --make-bed --memory 32000 --out test15")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test15 --bmerge g1000_phase3_geno_chr16 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr16 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr16")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test15 --bmerge g1000_phase3_geno_chr16 --make-bed --memory 32000 --out test16")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test16 --bmerge g1000_phase3_geno_chr17 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr17 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr17")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test16 --bmerge g1000_phase3_geno_chr17 --make-bed --memory 32000 --out test17")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test17 --bmerge g1000_phase3_geno_chr18 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr18 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr18")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test17 --bmerge g1000_phase3_geno_chr18 --make-bed --memory 32000 --out test18")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test18 --bmerge g1000_phase3_geno_chr19 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr19 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr19")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test18 --bmerge g1000_phase3_geno_chr19 --make-bed --memory 32000 --out test19")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test19 --bmerge g1000_phase3_geno_chr20 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr20 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr20")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test19 --bmerge g1000_phase3_geno_chr20 --make-bed --memory 32000 --out test20")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test20 --bmerge g1000_phase3_geno_chr21 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr21 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr21")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test20 --bmerge g1000_phase3_geno_chr21 --make-bed --memory 32000 --out test21")
system(command)

##

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test21 --bmerge g1000_phase3_geno_chr22 --make-bed --out test")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile g1000_phase3_geno_chr22 --exclude test-merge.missnp --make-bed --out g1000_phase3_geno_chr22")
system(command)

command <- sprintf("/Users/Emily/Software/plink/plink --bfile test21 --bmerge g1000_phase3_geno_chr22 --make-bed --memory 32000 --out g1000_phase3_geno")
system(command)

##
