from rembg import remove
import cv2
import matplotlib.pyplot as plt
#%%

def runSegment(imagepath):

    input = cv2.imread(imagepath)
    cv2.medianBlur(input, 1, input)

    return cv2.cvtColor(input, cv2.COLOR_RGB2BGR)
    

#%%
#plt.imshow(output_image_bgr)
#ax = plt.gca()
#ax.get_xaxis().set_visible(False)
#ax.get_yaxis().set_visible(False)
matlabOutput = runSegment(matlabInput)