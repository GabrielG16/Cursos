import cv2 as cv

img = cv.imread('imgs/cats.jpg')
cv.imshow('cats', img)

# Averaging-blur - média dos pontos ao redor do pixel central do kernel

average = cv.blur(img, (7,7))
cv.imshow('Average Blur',average)

# Gaussian Blur

gauss = cv.GaussianBlur(img, (7,7), 0)
cv.imshow('Gauss', gauss)

# Median Blur
 
median = cv.medianBlur(img, 3)
cv.imshow('median', median)

#Bilateral blur

bilateral = cv.bilateralFilter(img, 5, 15, 15)
cv.imshow('bilateral',bilateral)

cv.waitKey(0)