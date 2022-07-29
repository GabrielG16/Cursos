import os
import cv2 as cv
from cv2 import cvtColor
import numpy as np

people = ['Ben Afflek','Elton John','Jerry Seinfield','Madonna','Mindy Kaling']

DIR = os.path.abspath('./Faces/train')

haar_cascade = cv.CascadeClassifier('haar_faces.xml')

features = []
labels = []

def create_train(): #Cria o dataset, filtrando os rostos com as labels
    
    for person in people: # Pega cada pasta das dferentes classes
        path = os.path.join(DIR, person)
        label = people.index(person)
        
        for image in os.listdir(path): # Pega cada foto dentro de cada classe para leitura e identificação do rosto
            img_path = os.path.join(path, image)

            img_array = cv.imread(img_path)
            gray = cvtColor(img_array, cv.COLOR_BGR2GRAY)

            faces_rect = haar_cascade.detectMultiScale(gray, scaleFactor = 1.1, minNeighbors = 4)

            for x, y, w, h in faces_rect:
                faces_roi = gray[y:y+h, x:x+w]
                features.append(faces_roi)
                labels.append(label)

create_train()
print('Training Done............')

features = np.array(features, dtype = 'object')
labels = np.array(labels)

face_recognizer = cv.face_LBPHFaceRecognizer.create()

# Train the recognizer on the featurs list and labels list

face_recognizer.train(features, labels)

np.save('features.npy', features)
np.save('labels.npy', labels)

face_recognizer.save('face_trained.yml')
