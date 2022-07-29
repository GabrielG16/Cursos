import cv2 as cv
import numpy as np

blank = np.zeros((500,500,3), dtype = 'uint8')
cv.imshow('Blank', blank)

# 1. Paint img a certain color
blank[:] = 255,0,0
cv.imshow('Blank2', blank)
# 2. Paint certain parts
blank[200:300, 300:400] = 0,0,255
cv.imshow('Blank', blank)
# 3. Draw Rectangle
cv.rectangle(blank, (0,0), (250,250), (0,0,255), thickness = 2)
cv.rectangle(blank, (0,0), (250,500), (0,0,255), thickness = cv.FILLED)

cv.imshow('Rectangle', blank)
# 4. Draw a circle
cv.circle(blank, (blank.shape[1]//2, blank.shape[0]//2), 40, (0,0,255), thickness =-1)
cv.imshow('Circle', blank)
# 5. Draw a line
cv.line(blank, (0,0), (blank.shape[1]//2, blank.shape[0]//2), (255,255,255), thickness = 3)
cv.imshow('Line',blank)
# 6. Write Text
blank2 = np.zeros((500,500,3), dtype = 'uint8')
cv.putText(blank2, 'Hello', (0,225), cv.FONT_HERSHEY_COMPLEX, 1.0, (0,255,0), 2)
cv.imshow('text', blank2)

# img = cv.imread('imgs/cat.jpg')
# cv.imshow('Cat', img)

cv.waitKey(0)

