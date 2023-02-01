import cv2
import math
import numpy as np
import mediapipe as mp
import matplotlib.pyplot as plt

mp_selfie_segmentation = mp.solutions.selfie_segmentation

#%%
# Read images with OpenCV.
image_path = "Images\OriginalPost.png"
image = cv2.imread(image_path)
imageblur = cv2.imread(image_path)
# cv2.medianBlur(imageblur, 9, imageblur)

BG_COLOR = (192, 192, 192) # gray
MASK_COLOR = (255, 255, 255) # white

#%%
with mp_selfie_segmentation.SelfieSegmentation() as selfie_segmentation:
    # Convert the BGR image to RGB and process it with MediaPipe Selfie Segmentation.
    results = selfie_segmentation.process(
        cv2.cvtColor(image, cv2.COLOR_BGR2RGB))

    # Generate solid color images for showing the output selfie segmentation mask.
#%%
fg_image = np.zeros(image.shape, dtype=np.uint8)
fg_image[:] = MASK_COLOR
bg_image = np.zeros(image.shape, dtype=np.uint8)
bg_image[:] = BG_COLOR
condition = np.stack((results.segmentation_mask,) * 3, axis=-1) > 0.4
mask = results.segmentation_mask
output_image = np.where(condition, image, bg_image)
output_image_bgr = cv2.cvtColor(output_image, cv2.COLOR_RGB2BGR)



plt.imshow(output_image_bgr); ax = plt.gca(); ax.get_xaxis().set_visible(False); ax.get_yaxis().set_visible(False)
print("END")
# %%
