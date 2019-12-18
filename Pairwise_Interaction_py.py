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

os.chdir('E:\WorkPCBackup\DRI\D Drive\CLOUD_temp\g1000_phase3_plink')

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
    out = subprocess.call(cmd,shell=True)
#    out = out.decode('utf-8') #decode response
    return out

#%% Import the Data
    
with open('g1000_phase3_geno.bim','rb') as fid:
    bim = np.fromfile(fid,dtype='int8',count=1012).tostring().decode()
# allow string to be converted
BIM = StringIO(bim)
#generate column names
colnames = ('INDIV','SNPNAME','A','B','SNP0','SNP1')
#split into columns
bimDF = pd.read_csv(BIM,header=None)[0].str.split('\t',expand=True)
#add column names
bimDF.columns = colnames

b = 'the predictor variables, N by X'
y = 'the outcome variable, N by 1'

#%% Perform the Task
numSNPs = (2,5,10,50,100,500,1000)
i=2
numSamples = 10000 #as above

print('\nPairwise Interaction, number of SNPs: {:,}'.format(numSNPs[i]))
factB = np.math.factorial(numSNPs[i])
numInter = factB/(np.math.factorial(2)*np.math.factorial(numSNPs[i]-2))
print('Total number of interactions: {:,}'.format(int(numInter)))

poly = PolynomialFeatures(interaction_only=True,include_bias=False)

#start
stt = timeIn()

#write SNP names to list
fname = "{}.txt".format(numSNPs[i])
selection = random.sample(range(len(bimDF)),numSNPs[i])
bimDF['SNPNAME'][selection].to_csv(fname,index=False,header=False)


#%% This bit doesn't work yet
cmd = "E:/WorkPCBackup/DRI/D Drive/plink/plink --bfile ./g1000_phase3_geno --extract {}SNPs.txt --recodeA --out g1000_phase3_geno_{}SNPs".format(numSNPs[i], numSNPs[i])
sysTalk(cmd)
#%%

polyB = poly.fit_transform(b) #generates interaction terms
glm = sm.OLS(y,polyB)
res = glm.fit()

#record values of interest
intCoefs = res.params[0,numSNPs[i]:]
intPValues = res.pvalues[0,numSNPs[i]:]

fin = timeOut(stt)
#end

#%% Report Memory Usage

process = psutil.Process(os.getpid())
print('\nTotal memory used: {0:.2f}%'.format(process.memory_percent()))