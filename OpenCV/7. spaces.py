import cv2 as cv

img = cv.imread('imgs/park.jpg')
cv.imshow('Boston', img)

#BGR

gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)
cv.imshow('gray',gray)

#BGR HSV (Hue Saturation Value)

hsv = cv.cvtColor(img, cv.COLOR_BGR2HSV)
cv.imshow('hsv',hsv)


# BGR to LAB

lab = cv.cvtColor(img, cv.COLOR_BGR2LAB)
cv.imshow('lab',lab)

#BGR TO RGB

rgb = cv.cvtColor(img, cv.COLOR_BGR2RGB)
cv.imshow('RGB', rgb)

# Para converter entre diferentes espaços de cores, é necessário fazer uma conversão intermediária de volta ao formato BGR
cv.waitKey(0)