import cv2 as cv
from cv2 import warpAffine
import numpy as np

park = cv.imread('imgs/park.jpg')
cv.imshow('Boston', park)

# Translation

def translate(img, x, y):
    transMat = np.float32([[1,0,x], [0,1,y]])
    dimensions = (img.shape[1], img.shape[0])
    return cv.warpAffine(img, transMat, dimensions)

translated = translate(park, 100,100)
cv.imshow('Translated', translated)


## Rotation 

def rotate(img, angle, rotPoint=None):
    (height, width) = img.shape[:2]

    if rotPoint is None:
        rotPoint = (width//2, height//2)
    
    rotMat = cv.getRotationMatrix2D(rotPoint, angle, 1.0)
    dimensions = width, height

    return cv.warpAffine(img, rotMat, dimensions)

rotated = rotate(park, 45)
cv.imshow('Rotated', rotated)



# RESIZING

resized = cv.resize(park, (500,500), interpolation = cv.INTER_CUBIC)
cv.imshow('Resized', resized)


# Flipping
# 0 - giro vertical (sobre o eixo x)
# 1 - giro horizontal(sobre o eixo y) 

flip = cv.flip(park, 1)
cv.imshow('Flip', flip)


# cropping 
cv.waitKey(0)