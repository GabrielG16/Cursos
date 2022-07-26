import cv2 as cv
import numpy as np




img = cv.imread('imgs/cats.jpg')

cv.imshow('Cats', img)

blank = np.zeros(img.shape, dtype = 'uint8')
cv.imshow('blank', blank)

gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)

cv.imshow('Grayscale', gray)


canny = cv.Canny(img, 125, 175)
cv.imshow('cont',canny)

contours, hierarchies = cv.findContours(canny, cv.RETR_LIST, cv.CHAIN_APPROX_NONE)
# Binarização
ret, thresh = cv.threshold(gray, 125, 255, cv.THRESH_BINARY)
cv.imshow('Thresh', thresh)

cv.drawContours(blank, contours, -1, (0,0,255), 1)
cv.imshow('Contours Drawn',blank)

# O ideal para traçar os contornos é usar a função canny antes para pegar os edges  daí gerar os contornos

cv.waitKey(0)