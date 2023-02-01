from rembg import remove
import cv2
import matplotlib.pyplot as plt

#%%
input_path = 'Images\OriginalPost.png'
output_path = 'output.png'

input = cv2.imread(input_path)
# cv2.medianBlur(input, 9, input)
output = remove(input)
plt.imshow(cv2.cvtColor(output, cv2.COLOR_RGB2BGR))
ax = plt.gca()
ax.get_xaxis().set_visible(False)
ax.get_yaxis().set_visible(False)
# cv2.imwrite("./Images/rembg_output.png", output)
