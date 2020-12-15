import numpy as np

arr = np.loadtxt('tmpa')

x = arr[1] - arr[0]
y = arr[3] - arr[2]
z = arr[5] - arr[4]

def build_box():
    arr=np.loadtxt('tmpa')
    x = arr[1] - arr[0]
    y = arr[3] - arr[2]
    z = arr[5] - arr[4]
    print('cellBasisVector1',     "%.4f" % x, 0, 0)
    print('cellBasisVector2',     0, "%.4f" % y, 0)
    print('cellBasisVector3',     0, 0, "%.4f" % z)

build_box()

