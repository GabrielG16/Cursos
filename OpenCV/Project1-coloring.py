import cv2 as cv
import numpy as np

frameWidth = 640
frameHeight = 480

cap = cv.VideoCapture(0)
cap.set(3, frameWidth)
cap.set(4, frameHeight)
cap.set(10,150)


colours = [(5,107,0,19,255,255), (133,56,0,159,156,255)] # min e max de saturação, hue e

def findColor(img, mycolours):
    hsv = cv.cvtColor(img, cv.COLOR_BGR2HSV)
    for color in mycolours:
        lower = np.array(color[:3])
        upper = np.array(color[3:6])
        mask = cv.inRange(hsv, lower, upper)
        #cv.imshow(str(color[0]), mask)

while True:
    sucess, img = cap.read()
    
    findColor(img, colours)
    cv.imshow('Result', img)
    if cv.waitKey(1) & 0xFF == ord('q'):
        break

