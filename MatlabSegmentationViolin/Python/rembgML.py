#%%
import cv2
import numpy as np
import matplotlib.pyplot as plt
from rembg import remove

#%%
def runSegment(imagepath):

    input = cv2.imread(imagepath)
    # input = cv2.imread("C: \Users\genia\PycharmProjects\GreenScreenVideo\MatlabSegmentationViolin\Python\Images\OriginalVideoRawStill1.png")
    
    # cv2.medianBlur(input, 9, input)
    return remove(input)
    

#%%
matlabOutput = runSegment(matlabInput)