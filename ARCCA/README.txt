This folder holds the files that are used in the Advanced Research Computing at CArdiff (ARCCA) HPC system.

Interactions_ARCCA.R
  This R program loops through different values of nSNPs, performs pairwise interactions on the loaded genomic data (.raw), and outputs the results of that operation.

interactions.sh
  This shell program is what interacts with ARCCA.  It contains the instructions to set up computing space within ARCCA, and to run Interactions_ARCCA.R using the R module.

ARCCA_interaction.csv
  This gives the results of the processing that has been performed at the current time.

Matrix_Inversion_ARCCA.R [WIP]
  This R program loops through different values of nSNPs, performs a matrix inversion on the loaded genomic data (.raw), and outputs the results of that operation.
  
