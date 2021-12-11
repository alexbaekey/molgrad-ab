# Created by Alex Baekey
# Overall projet utilizes molgrad by Jose Jimenez-Luna et al. https://pubs.acs.org/doi/10.1021/acs.jcim.0c01344
# Data: predicted binding of candidate drugs to ACE2 receptor from Yoonjung Choi et al. https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7698791/

import pandas as pd
from rdkit import Chem,DataStructs
import numpy as np
from rdkit import Chem
import os
from scipy.interpolate import interp1d
import matplotlib.pyplot as plt
plt.ion()

#convert pdb to SMILES
your_mol = Chem.MolFromPDBFile(os.path.join("data", "spike_protein.pdb"))
spike_smiles = Chem.MolToSmiles(your_mol)
#print(spike_smiles)

my_file = open("data/ACE2_smiles.txt", "r")
smiles_list = my_file.readlines()

sim_results = []

for i in smiles_list:
    mol1 = Chem.MolFromSmiles(i)
    mol2 = Chem.MolFromSmiles(spike_smiles)
    fp1 = Chem.RDKFingerprint(mol1)
    fp2 = Chem.RDKFingerprint(mol2)
    sim_results.append(DataStructs.TanimotoSimilarity(fp1,fp2))


#print(sim_results)
df = pd.DataFrame({'smiles' : smiles_list, 'similarity' : sim_results})
with open('results/spike_similarity_results.csv', 'w', encoding='utf-8') as f:
    df.to_csv(f, index=False)

#Average

ave = df['similarity'].mean(axis=0)
print("Average similarity of ACE2 inhibitors to spike protein\n")
print(ave)

#RANK
df_sort = df.sort_values(['similarity'])
with open('results/spike_similarity_results_sorted.txt', 'w', encoding='utf-8') as f:
    df_sort.to_csv(f, index=False)





df_orig = pd.read_csv("data/ACE2.csv")

#collect binding affinity of top 5 similar results
#K_d lower is better

df_orig['SMILES used in the DTI prediction'][0]
df_orig['DTI Kd (nM)'][0]

#1
df_orig['Small\nmolecules'][168]
df_orig['SMILES used in the DTI prediction'][168]
df_orig['DTI Kd (nM)'][168]
#14.940564267555661

#2
df_orig['Small\nmolecules'][280]
df_orig['SMILES used in the DTI prediction'][280]
df_orig['DTI Kd (nM)'][280]
#33.635586125947874

#3
df_orig['Small\nmolecules'][220]
df_orig['SMILES used in the DTI prediction'][220]
df_orig['DTI Kd (nM)'][220]
#22.91092375283448

#4
df_orig['Small\nmolecules'][13]
df_orig['SMILES used in the DTI prediction'][13]
df_orig['DTI Kd (nM)'][13]
#1.5641449613475382

#5
df_orig['Small\nmolecules'][133]
df_orig['SMILES used in the DTI prediction'][133]
df_orig['DTI Kd (nM)'][133]
#11.750923528013711


#min and max binding values for range
#df_orig['DTI Kd (nM)'].min()
#0.01891664004687755
#df_orig['DTI Kd (nM)'].max()
#99.28279617033431



#Correlation graph

df_orig1 = df_orig[1:]
df_combine = pd.concat([df_orig1.reset_index(drop=True), df.reset_index(drop=True)], axis=1)
df_combine_sort = df_combine.sort_values(['similarity'])

plt.plot(df_combine_sort['similarity'],df_combine_sort['DTI Kd (nM)'])
plt.title("similarity, binding correlation")
plt.xlabel("similarity score")
plt.ylabel("K_d (nM)")
plt.savefig('results/figures/sim_vs_binding.jpg')

x=df_combine_sort['similarity'].to_numpy()
y=df_combine_sort['DTI Kd (nM)'].to_numpy()

#remove duplicate values
#https://stackoverflow.com/questions/36946960/get-non-duplicate-rows-from-numpy-array
_,idx,count = np.unique(x,return_index=True,return_counts=True)
x_unique = x[idx[count==1]]

y_unique = y[idx[count==1]]

#f = interp1d(x_unique, y_unique, kind='quadratic')

x_standard = np.linspace(0, 0.8, 100) 
mymodel = np.poly1d(np.polyfit(x_unique, y_unique, 3))

plt.clf()
plt.scatter(x_unique, y_unique)
plt.plot(x_standard,mymodel(x_standard))
plt.title("similarity, binding correlation - smoothed")
plt.xlabel("similarity score")
plt.ylabel("K_d (nM)")
plt.savefig('results/figures/sim_vs_binding_smoothed.jpg')





