import pandas as pd 

dftrain = pd.read_csv("..//data//train.csv",header=0)
dftest = pd.read_csv("..//data//test.csv",header=0)

print(dftrain.describe())
print(dftrain.info())