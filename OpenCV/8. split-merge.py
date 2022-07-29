import cv2 as cv
import numpy as np

img = cv.imread('imgs/park.jpg')
cv.imshow('Boston', img)

blank = np.zeros(img.shape[:2], dtype = 'uint8')


b, g, r = cv.split(img)

cv.imshow('Blue', b)
cv.imshow('Green', g)
cv.imshow('Red', r)

print(img.shape)
print(b.shape)
print(g.shape)
print(r.shape)

# MERGING

merged = cv.merge([b,g,r])
cv.imshow('merged',merged)


blue = cv.merge([b,blank,blank])
green = cv.merge([blank,g,blank])
red = cv.merge([blank,blank,r])
cv.imshow('RED',red)
cv.imshow('BLUE',blue)
cv.imshow('GREEN',green)


cv.waitKey(0)