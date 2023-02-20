import cv2
import numpy as np
import os

def adjust_display_range(img, min_value, max_value):
    img = np.clip(img, min_value, max_value)
    img = (img - min_value) / (max_value - min_value) * 255
    img = img.astype(np.uint8)
    return img

def adjust_images_in_directory(directory, min_value, max_value):
    for filename in os.listdir(directory):
        if filename.endswith(".tif"):
            img = cv2.imread(os.path.join(directory, filename), cv2.IMREAD_GRAYSCALE)
            img = adjust_display_range(img, min_value, max_value)
            cv2.imwrite(os.path.join(directory, "adjusted_" + filename), img)

directory = "/mnt/d/Documents/PhD_Project/year_4/Blyth-data/DATA/output"
min_value = 0
max_value = 1

adjust_images_in_directory(directory, min_value, max_value)