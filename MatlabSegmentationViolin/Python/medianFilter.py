import cv2
import math
import numpy as np
import mediapipe as mp
import matplotlib.pyplot as plt
#%%

mp_selfie_segmentation = mp.solutions.selfie_segmentation

def runSegment(imagepath):

    image = imagepath # cv2.imread(imagepath)
    blurredImage = cv2.medianBlur(image, 5)

    return blurredImage

#%%
#plt.imshow(output_image_bgr)
#ax = plt.gca()
#ax.get_xaxis().set_visible(False)
#ax.get_yaxis().set_visible(False)
matlabOutput = runSegment(matlabInput)
print("END")