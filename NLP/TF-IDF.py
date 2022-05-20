import nltk
import re
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer
from nltk.stem import WordNetLemmatizer

paragraph = "The averaging methods discussed so far are appropriate for stationary bandit problems, that is, for bandit problems in which the reward probabilities do not change over time.\
As noted earlier, we often encounter reinforcement learning problems that are objectively nonstationary. In such cases it makes sense to give more weight to recent rewards than\
to long-past rewards. One of the most popular ways of doing this is to use a constant step-size parameter. For example, the incremental update rule"


ps = PorterStemmer()
wordnet = WordNetLemmatizer()
sentences = nltk.sent_tokenize(paragraph)
corpus = []



from sklearn.feature_extraction.text import TfidfVectorizer
cv = TfidfVectorizer()
X = cv.fit_transform(corpus).toarray()