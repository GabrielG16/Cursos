import cv2 as cv

capture = cv.VideoCapture(0)
haar_cascade = cv.CascadeClassifier('haar_faces.xml')

while True:
    isTrue, frame = capture.read()
    gray = cv.cvtColor(frame, cv.COLOR_BGR2GRAY)
    faces_rect = haar_cascade.detectMultiScale(gray, scaleFactor = 1.1, minNeighbors = 3)
    
    for x,y, w, h in faces_rect:
        cv.rectangle(frame, (x,y), (x+w, y+h), (0,255,0), thickness = 2)
        cv.putText(frame, 'Gabriel', (x+10,y-5), cv.FONT_HERSHEY_COMPLEX, 0.5, (0,255,0), 2)

    cv.imshow('detect',frame)

    if cv.waitKey(20) & 0xFF==ord('d'):
        break
capture.release()
cv.destroyAllWindows()