<h1>CLOUD</h1>
Repo for the pilot study examining the viability of Cloud computing platforms for the processing and analysis of genomic data.

<h2>R Files</h2>
<h3><i>Reformat_g1000.R</i></h3>
This program processes the 1000 genomes project data into readable files for further analysis.

<h3><i>Interactions.R</i></h3>
This program samples <i>N</i> SNPs from the total genome data.  It then calculates the pairwise interactions between these SNPs, using all individuals.  It outputs, for each pair, a set of parameters including the beta coefficient and the <i>p</i>-value.

<h3><i>Matrix_Inversion.R</i></h3>
This program samples <i>N</i> SNPs from the total genome data.  It then correlates all variables to create a correlation matrix of <i>N-by-N</i> size.  This matrix is then inverted.  LD-adjusted genomes are output, using this inverted matrix.

<h2>Python Files</h2>
<h3><i>Pairwise_Interactions_py.py</i></h3>
This program attempts to replicate the overall process from <code>Interactions.R</code>.  This program is still in the process of being generated.
