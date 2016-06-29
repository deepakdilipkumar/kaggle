import pandas as pd 
import pylab as p

dftrain = pd.read_csv("..//data//train.csv",header=0)
dftest = pd.read_csv("..//data//test.csv",header=0)

print(dftrain.describe())
print(dftrain.info())

# Old Passengers

old = dftrain[dftrain.Age>60][["Age","Pclass","Sex","Survived"]]
print(old)

dftrain.Age.hist()
p.show()