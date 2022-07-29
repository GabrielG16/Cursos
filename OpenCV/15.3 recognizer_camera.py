import cv2 as cv
import numpy as np

people = ['Ben Afflek','Elton John','Jerry Seinfield','Madonna','Mindy Kaling']

haar_cascade = cv.CascadeClassifier('haar_faces.xml')
#faces_rect = haar_cascade.detectMultiScale(gray, 1.1, 4)

# features = np.load('features.npy')
# labels = np.load('labels.npy')

face_recognizer = cv.face.LBPHFaceRecognizer_create()
face_recognizer.read('face_trained.yml')

#img = cv.imread('Faces/val/madonna/3.jpg')
capture = cv.VideoCapture(0)
haar_cascade = cv.CascadeClassifier('haar_faces.xml')

while True:
    isTrue, frame = capture.read()
    gray = cv.cvtColor(frame, cv.COLOR_BGR2GRAY)
    faces_rect = haar_cascade.detectMultiScale(gray, scaleFactor = 1.1, minNeighbors = 3)


    # Detect Face


    for x, y, w, h in faces_rect:
        faces_roi = gray[y:y+h, x:x+h]

        label, confidence = face_recognizer.predict(faces_roi)
        print(f'Label = {people[label]} with a confidence of {confidence}')

        cv.putText(frame, str(people[label]), (20,20), cv.FONT_HERSHEY_COMPLEX, 1.0, (0,255,0), thickness=2)

        cv.rectangle(frame, (x,y), (x+w, y+h), (0,255,0), thickness=2)

    cv.imshow('detect',frame)

    if cv.waitKey(20) & 0xFF==ord('d'):
        break
capture.release()
cv.destroyAllWindows()