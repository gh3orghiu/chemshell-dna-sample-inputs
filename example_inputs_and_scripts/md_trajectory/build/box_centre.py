import numpy as np

def box_centre():
    arr=np.loadtxt('tmpa')
    x = (arr[1] + arr[0])/2
    y = (arr[3] - arr[2])/2
    z = (arr[5] - arr[4])/2
    print('cellOrigin', "%.4f" % x, "%.4f" % y, "%.4f" % z)

box_centre()

