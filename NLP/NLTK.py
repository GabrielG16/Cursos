import nltk
import nltk.corpus
from nltk.tokenize import word_tokenize
from nltk.probability import FreqDist

from nltk.stem import PorterStemmer

from nltk.stem import WordNetLemmatizer
from nltk.corpus import stopwords

from nltk import ne_chunk

texto = "The averaging methods discussed so far are appropriate for stationary bandit problems, that is, for bandit problems in which the reward probabilities do not change over time.\
As noted earlier, we often encounter reinforcement learning problems that are objectively nonstationary. In such cases it makes sense to give more weight to recent rewards than\
to long-past rewards. One of the most popular ways of doing this is to use a constant step-size parameter. For example, the incremental update rule"
#tokenizing
texto_tokens = word_tokenize(texto)
#frequency 
fdist =  FreqDist(texto_tokens)
##SAME HERE
for f in texto_tokens:
    fdist[f]  = fdist[f]+1
fdist

fdist.most_common(10)


# N-grams
list(nltk.bigrams(texto_tokens))
list(nltk.trigrams(texto_tokens))
list(nltk.ngrams(texto_tokens,4))

#Stemming

stm = PorterStemmer()

texto_tokens[1], texto_tokens[3], texto_tokens[9]

stm.stem(texto_tokens[1]), stm.stem(texto_tokens[3]), stm.stem(texto_tokens[9])

#Lemmatização

lem = WordNetLemmatizer()

lem.lemmatize('cats'), lem.lemmatize('cacti'), lem.lemmatize('geese')

sents = nltk.sent_tokenize(texto)
for i in range(len(sents)):
    words = nltk.word_tokenize(sents[i])
    words = [lem.lemmatize(word) for word in words if word not in set(stopwords.words('english'))]
    sents[i] = ' '.join(words)

# POS-TAGGING - Classificação gramatical 

peace = """What do you mean, "I don't believe in God"? I talk to him every day."""
peace_token = word_tokenize(peace)

nltk.pos_tag(peace_token)

## NAMED ENTITY RECOGNITION - Reconhecimento de entidades nos substantivos

john = "John lives in New York"

jtoken = word_tokenize(john)

postags = nltk.pos_tag(jtoken)

jner = ne_chunk(postags)
jner

nltk.download()


sents = nltk.sent_tokenize(texto)
sents