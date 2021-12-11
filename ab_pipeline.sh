python molgrad/train_ext.py -data '/home/alexander/Datasets/ACE2_interactions/ACE2.csv' -smiles_col "SMILES used in the DTI prediction" -target_col "DTI Kd (nM)" -output $HOME/GitHub/molgrad-ab/ACE2_model/ACE2_GNN_Model_molgrad.pt

#coloring

#top 5 most similar compounds to spike protein
#5 -132 "CC(C)C[C@H]1C(=O)N2CCC[C@H]2[C@]2(O)O[C@](NC(=O)[C@@H]3C[C@@H]4c5cccc6[nH]cc(c56)C[C@H]4N(C)C3)(C(C)C)C(=O)N12",0.7610666666666667
#4 -12- "CC[C@@H](C)[C@H]1C(=O)N2CCC[C@H]2[C@]2(O)O[C@](NC(=O)[C@@H]3C[C@@H]4c5cccc6[nH]cc(c56)C[C@H]4N(C)C3)(C(C)C)C(=O)N12",0.7627931769722814
#3 -219 "CC(C)C[C@H]1C(=O)N2CCC[C@H]2[C@]2(O)O[C@](NC(=O)[C@@H]3C=C4c5cccc6[nH]c(Br)c(c56)C[C@H]4N(C)C3)(C(C)C)C(=O)N12",0.7698701298701298
#2 -279- "CN1C[C@H](C(=O)N[C@]2(C)O[C@@]3(O)[C@@H]4CCCN4C(=O)[C@H](Cc4ccccc4)N3C2=O)C=C2c3cccc4[nH]cc(c34)C[C@H]21",0.7706470278800631
#1 -167- "CC(C)[C@@]1(NC(=O)[C@@H]2C[C@@H]3c4cccc5[nH]cc(c45)C[C@H]3N(C)C2)O[C@@]2(O)[C@@H]3CCCN3C(=O)[C@H](Cc3ccccc3)N2C1=O",0.7763018065887354


mkdir $HOME/GitHub/molgrad/results/num1/
mkdir $HOME/GitHub/molgrad/results/num2/
mkdir $HOME/GitHub/molgrad/results/num3/
mkdir $HOME/GitHub/molgrad/results/num4/
mkdir $HOME/GitHub/molgrad/results/num5/

#Color top 5 input compounds
python3 molgrad/main.py -model_path $HOME/GitHub/molgrad-ab/ACE2_model/ACE2_GNN_Model_molgrad.pt -smi "CC(C)[C@@]1(NC(=O)[C@@H]2C[C@@H]3c4cccc5[nH]cc(c45)C[C@H]3N(C)C2)O[C@@]2(O)[C@@H]3CCCN3C(=O)[C@H](Cc3ccccc3)N2C1=O" -output_f $HOME/GitHub/molgrad/results/num1/

python3 molgrad/main.py -model_path $HOME/GitHub/molgrad-ab/ACE2_model/ACE2_GNN_Model_molgrad.pt -smi "CN1C[C@H](C(=O)N[C@]2(C)O[C@@]3(O)[C@@H]4CCCN4C(=O)[C@H](Cc4ccccc4)N3C2=O)C=C2c3cccc4[nH]cc(c34)C[C@H]21" -output_f $HOME/GitHub/molgrad/results/num2/

python3 molgrad/main.py -model_path $HOME/GitHub/molgrad-ab/ACE2_model/ACE2_GNN_Model_molgrad.pt -smi "CC(C)C[C@H]1C(=O)N2CCC[C@H]2[C@]2(O)O[C@](NC(=O)[C@@H]3C=C4c5cccc6[nH]c(Br)c(c56)C[C@H]4N(C)C3)(C(C)C)C(=O)N12" -output_f $HOME/GitHub/molgrad/results/num3/

python3 molgrad/main.py -model_path $HOME/GitHub/molgrad-ab/ACE2_model/ACE2_GNN_Model_molgrad.pt -smi "CC[C@@H](C)[C@H]1C(=O)N2CCC[C@H]2[C@]2(O)O[C@](NC(=O)[C@@H]3C[C@@H]4c5cccc6[nH]cc(c56)C[C@H]4N(C)C3)(C(C)C)C(=O)N12" -output_f $HOME/GitHub/molgrad/results/num4/

python3 molgrad/main.py -model_path $HOME/GitHub/molgrad-ab/ACE2_model/ACE2_GNN_Model_molgrad.pt -smi "CC(C)C[C@H]1C(=O)N2CCC[C@H]2[C@]2(O)O[C@](NC(=O)[C@@H]3C[C@@H]4c5cccc6[nH]cc(c56)C[C@H]4N(C)C3)(C(C)C)C(=O)N12" -output_f $HOME/GitHub/molgrad/results/num5/
