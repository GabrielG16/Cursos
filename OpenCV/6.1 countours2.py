import cv2 as cv
from cv2 import cvtColor
import numpy as np


def getcontours(img):
    contours, hierarchy = cv.findContours(img, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_NONE)
    for cnt in contours:
        area = cv.contourArea(cnt)
        
        if area > 50:
            cv.drawContours(imgContour, cnt, -1, (255,0,0), 1)
            peri = cv.arcLength(cnt, True)
            approx = cv.approxPolyDP(cnt, 0.02*peri, True)
            objCor = len(approx)
            x, y, w, h = cv.boundingRect(approx)
            
            if objCor ==3: objectType = 'Tri'
            
            cv.rectangle(imgContour, (x,y), (x+w, y+h), (0,255,0),2)


img = cv.imread('imgs/cat.jpg')
imgContour = img.copy()


gray = cvtColor(img, cv.COLOR_BGR2GRAY)
imgBlur = cv.GaussianBlur(gray, (7,7), 1)
canny = cv.Canny(imgBlur, 50,50)
getcontours(canny)

cv.imshow('Img',img)
cv.imshow('gray',gray)
cv.imshow('Blur',imgBlur)
cv.imshow('Blur',canny)
cv.imshow('Contours',imgContour)


cv.waitKey(0)