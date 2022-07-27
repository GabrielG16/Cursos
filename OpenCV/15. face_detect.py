import cv2 as cv
from cv2 import cvtColor

img = cv.imread('imgs/group_1.jpg')
cv.imshow('lady',img)

gray = cvtColor(img, cv.COLOR_BGR2GRAY)
cv.imshow('ladylu',gray)

haar_cascade = cv.CascadeClassifier('haar_faces.xml')

faces_rect = haar_cascade.detectMultiScale(gray, scaleFactor = 1.1, minNeighbors = 3)  ## muito sensível - identifica outras coisas como  faces

print(f'Number of faces:', len(faces_rect))
print(faces_rect)

for x,y, w, h in faces_rect:
     cv.rectangle(img, (x,y), (x+w, y+h), (0,255,0), thickness = 2)
cv.imshow('detect',img)
cv.waitKey(0)