import cv2 as cv

# img = cv.imread('imgs/cat_large.jpg')

# cv.imshow('Mycat', img)

# cv.waitKey(0)

############### Leitura de videos

# capture = cv.VideoCapture('videos/dog.mp4')

# while True:
#     isTrue, frame = capture.read()
#     cv.imshow('Video', frame)

#     if cv.waitKey(20) & 0xFF==ord('d'):
#         break
# capture.release()
# cv.destroyAllWindows()

############################ Rescaling

def rescale(frame, scale = 0.75):
    width  = int(frame.shape[1]*scale)
    height = int(frame.shape[0]*scale)
    dimensions = (width, height)

    return cv.resize(frame, dimensions, interpolation = cv.INTER_AREA) # Funciona praimagem e video

capture = cv.VideoCapture('videos/dog.mp4')

while True:
    isTrue, frame = capture.read()

    frame_resized = rescale(frame)

    cv.imshow('Video', frame)
    cv.imshow('Video Resized', frame_resized)


    if cv.waitKey(20) & 0xFF==ord('d'):
        break
capture.release()g
cv.destroyAllWindows()
g
#Rescaling exclusivo para live videos

def changeRes(width, height):
    capture.set(3, width)
    capture.set(4, height)