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
#p.show()

dftrain['Gender'] = dftrain.Sex.map({'female':0, 'male':1}).astype(int)
dftrain['Location'] = dftrain.Embarked.dropna().map({'C':0,'S':1, 'Q':2}).astype(int)
print(dftrain.head(3))