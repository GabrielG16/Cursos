import cv2 as cv
import numpy as np


img = cv.imread('imgs/cats.jpg')
cv.imshow('cat', img)

width, height = 650, 428

pts1 = np.float32([[434,133],[154,482],[437,182],[488,188]])
pts2 = np.float32([[0,0], [width,0],[0,height], [width,height]])
matrix = cv.getPerspectiveTransform(pts1,pts2)
imgOutput = cv.warpPerspective(img, matrix, (width, height))

cv.imshow('output', imgOutput)

cv.waitKey(0)
