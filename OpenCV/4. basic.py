import cv2 as cv

img = cv.imread('imgs/cat.jpg')
pk = cv.imread('imgs/park.jpg')

cv.imshow('Cat', img)

########### Converter em PB

gray = cv.cvtColor(pk, cv.COLOR_BGR2GRAY)
#cv.imshow('gray', gray)

# ############### Blur

blur = cv.GaussianBlur(img, (7,7), cv.BORDER_DEFAULT)
cv.imshow('blr', blur)


######### EDGE CASCADE - Detecção de bordas

canny = cv.Canny(blur, 125, 175)
cv.imshow('Canny edges', canny)
# É possível remover parte dos contornos adicionando blur na imagem


###### DILATING IMAGE

dilated = cv.dilate(canny, (3,3), iterations = 3)
cv.imshow('dilated', dilated)

### eroding img

erode = cv.erode(dilated, (3,3), iterations = 3)
cv.imshow('Eroded',erode)

### resize and crop

resized = cv.resize(pk, (500,500), interpolation = cv.INTER_AREA) # inter_linear, inter_cubic (INTERPOLACOES PARA AUMENTO DE ESCALA)
cv.imshow('Resized', resized)

cropped = img[50:200, 200:400]


cv.waitKey(0)