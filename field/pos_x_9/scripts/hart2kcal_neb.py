import numpy as np
import csv

data = np.loadtxt('nebinfo', usecols=(0,1))

hartree=data[:,1]

convert=627.509
kcal=hartree*convert 
ang=data[:,0]

for a, k in zip(ang, kcal):
    print (a, k)

zipped=zip(ang, kcal)
zlist=list(zipped)

newnebinfo=np.savetxt('kcalnebinfo', zlist)
