# %%
import cv2
import numpy as np
import mediapipe as mp
import matplotlib.pyplot as plt
mp_selfie_segmentation = mp.solutions.selfie_segmentation

#%%
def runSegment(imagepath):
    image = cv2.imread(imagepath)

    #cv2.medianBlur(image, 9, image)

    with mp_selfie_segmentation.SelfieSegmentation() as selfie_segmentation:
        # Convert the BGR image to RGB and process it with MediaPipe Selfie Segmentation.
        results = selfie_segmentation.process(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))

    return results.segmentation_mask

#%%
matlabOutput = runSegment(matlabInput)