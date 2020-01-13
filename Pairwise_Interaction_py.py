# -*- coding: utf-8 -*-
"""
Created on Wed Dec 11 14:48:42 2019

@author: Josh Stevenson-Hoare
"""

#%% Set Up

import os, psutil, subprocess
import numpy as np
import pandas as pd
import time
from sklearn.preprocessing import PolynomialFeatures
import statsmodels.api as sm
from io import StringIO
import random

userdir = 'E:\WorkPCBackup\DRI\D Drive\CLOUD_temp\g1000_phase3_plink'
os.chdir(userdir)

#%% Functions

# start timer
def timeIn():
    tic = time.time()
    return tic

# end timer and print the elapsed time
def timeOut(tic):
    toc = time.time()
    elap = toc-tic
    print('Elapsed time: {} secs'.format(elap))
    return elap

# send commands to the system
def sysTalk(cmd):
    out = subprocess.run(cmd, capture_output=True)
    return out.stdout.splitlines() #print to the console

#%% Import the Data
    
with open('g1000_phase3_geno.bim','rb') as fid:
    bim = np.fromfile(fid,dtype='int8',count=1012).tostring().decode() 
    # count prevents full file from being loaded
# allow string to be converted
BIM = StringIO(bim)
#generate column names
colnames = ('INDIV','SNPNAME','A','B','SNP0','SNP1')
#split into columns
bimDF = pd.read_csv(BIM,header=None)[0].str.split('\t',expand=True)
#add column names
bimDF.columns = colnames

#%% Perform the Task
numSNPs = (2,5,10,50,100,500,1000)
numSamples = 10000
i=2 #THIS WILL LOOP EVENTUALLY


print('\nPairwise Interaction, number of SNPs: {:,}'.format(numSNPs[i]))
factB = np.math.factorial(numSNPs[i])
#calc pairwise interactions
numInter = factB/(np.math.factorial(2)*np.math.factorial(numSNPs[i]-2))
print('Total number of interactions: {:,}'.format(int(numInter)))

poly = PolynomialFeatures(interaction_only=True,include_bias=False)

#start
stt = timeIn()

#write SNP names to list, then text
fname = "{}SNPs.txt".format(numSNPs[i])
selection = random.sample(range(len(bimDF)),numSNPs[i])
bimDF['SNPNAME'][selection].to_csv(fname,index=False,header=False)
bimDF.to_csv('g1000.bim',index=False,header=False) #writes to smaller file

#%% This bit doesn't work yet

sysTalk('E:') #switch to correct drive

#filter out variants not in the provided file, recode into new file
cmd = "{}\plink --bfile .\g1000_phase3_geno --extract {}SNPs.txt --recodeA --out g1000_phase3_geno_{}SNPs".format(userdir, numSNPs[i], numSNPs[i]) #outputs .raw file
sysTalk(cmd)

#with open('g1000_phase3_geno_{}.raw'.format(numSNPs[i]), 'r') as f:
with open('hapmap1{}.raw'.format('3SNPs'), 'r') as f:
    dt = f.readlines() #check delimiter in raw file!
data = pd.DataFrame(dt)
data = data[0].str.split(' ',expand=True) #split into columns
data.columns = data.iloc[0] #first row to column names
data = data.drop(data.index[0]) #drop header row

# create phenotype, this will be supplied with real data!
data['PHENO'] = np.random.choice(2,len(data),p=[0.7,0.3]) # random binary with prob = 0.3

b = 'the predictor variables, N by X'
# [0 1 2], num of alleles present in that case
b = data.iloc[:,['start':len(data.columns)]] #change 'start' for SNP start col

#%%

polyB = poly.fit_transform(b) #generates interaction terms
glm = sm.OLS(data['PHENO'],polyB)
res = glm.fit()

#record values of interest
intCoefs = res.params[0,numSNPs[i]:]
intPValues = res.pvalues[0,numSNPs[i]:]

fin = timeOut(stt)
#end

#%% Report Memory Usage

process = psutil.Process(os.getpid())
print('\nTotal memory used: {0:.2f}%'.format(process.memory_percent()))