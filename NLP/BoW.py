import nltk
import re
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer
from nltk.stem import WordNetLemmatizer

paragraph = "Eduard Fraenkel (1888–1970) was a German classical scholar who served as Corpus Christi Professor of Latin at the University of Oxford from 1935 until 1953. Born to a family of assimilated Jews in the German Empire, he studied classics at the Universities of Berlin and Göttingen. He established his academic reputation in 1922 with the publication of a monograph on Plautus, a Roman comedian. In 1934, antisemitic legislation introduced by the Nazi Party forced him to seek refuge in England. He published a three-volume commentary in 1950 on Agamemnon by the Greek playwright Aeschylus (pictured), and a monograph in 1957 on the Roman poet Horace."


ps = PorterStemmer()
wordnet = WordNetLemmatizer()
sentences = nltk.sent_tokenize(paragraph)
corpus = []

for i in range(len(sentences)):
    review = re.sub('[^a-zA-Z]', ' ', sentences[i])
    review = review.lower()
    review = review.split()
    review = [wordnet.lemmatize(word) for word in review if word not in set(stopwords.words('english'))]
    review = ' '.join(review)
    corpus.append(review)

    from sklearn.feature_extraction.text import CountVectorizer
    cv = CountVectorizer()
    X = cv.fit_transform(corpus).toarray()

