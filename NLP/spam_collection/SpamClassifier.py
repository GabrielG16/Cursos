import pandas as pd

import nltk
from nltk.stem import PorterStemmer
from nltk.corpus import stopwords

import re
import os

messages = pd.read_csv('./spam_collection/smsspamcollection/SMSSpamCollection', sep = '\t', names = ['label','message'])
ps = PorterStemmer()
corpus = []

for i in range(len(messages)):
    review = re.sub('[^a-zA-Z]', ' ', messages['message'][i])
    review = review.lower()
    review = nltk.word_tokenize(review)
    review = [ps.stem(word) for word in review if word not in set(stopwords.words('english'))]
    review = ' '.join(review)
    corpus.append(review)
    
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.preprocessing import LabelEncoder
cv = CountVectorizer(max_features = 4000)
X = cv.fit_transform(corpus).toarray()

y = messages.label

le = LabelEncoder()
y = le.fit_transform(y)

from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2)

from sklearn.naive_bayes import MultinomialNB
spm_detect = MultinomialNB().fit(X_train, y_train)
y_pred = spm_detect.predict(X_test)

from sklearn.metrics import confusion_matrix, accuracy_score, plot_confusion_matrix
accuracy_score(y_test, y_pred)

confusion_matrix(y_test, y_pred)