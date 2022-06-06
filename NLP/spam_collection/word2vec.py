import nltk
from nltk.corpus import stopwords
from gensim.models import Word2Vec
import re

paragraph = """ After 1850, the states of Germany had rapidly become industrialized, with particular strengths in coal, iron (and later steel), chemicals, and railways. In 1871, Germany had a population of 41 million people; by 1913, this had increased to 68 million. A heavily rural collection of states in 1815, the now united Germany became predominantly urban.[17] The success of German industrialization manifested itself in two ways since the early 20th century: the German factories were larger and more modern than their British and French counterparts.[18] The dominance of German Empire in natural sciences, especially in physics and chemistry, was such that one-third of all Nobel Prizes went to German inventors and researchers. During its 47 years of existence, the German Empire became the industrial, technological, and scientific giant of Europe, and by 1913, Germany was the largest economy in Continental Europe and the third-largest in the world.[19] Germany also became a great power, it built up the longest railway network of Europe, the world's strongest army,[20] and a fast-growing industrial base.[21] Starting very small in 1871, in a decade, the navy became second only to Britain's Royal Navy. After the removal of Otto von Bismarck by Wilhelm II in 1890, the empire embarked on Weltpolitik – a bellicose new course that ultimately contributed to the outbreak of World War I. From 1871 to 1890, Otto von Bismarck's tenure as the first and to this day longest-serving Chancellor was marked by relative liberalism, but it became more conservative afterward. Broad reforms and the Kulturkampf marked his period in the office. Late in Bismarck's chancellorship and in spite of his earlier personal opposition, Germany became involved in colonialism. Claiming much of the leftover territory that was yet unclaimed in the Scramble for Africa, it managed to build the third-largest colonial empire at the time, after the British and the French ones.[22] As a colonial state, it sometimes clashed with the interests of other European powers, especially the British Empire. During its colonial expansion, the German Empire committed the Herero and Namaqua genocide.[23] In addition, Bismarck's successors were incapable of maintaining their predecessor's complex, shifting, and overlapping alliances which had kept Germany from being diplomatically isolated. This period was marked by various factors influencing the Emperor's decisions, which were often perceived as contradictory or unpredictable by the public. In 1879, the German Empire consolidated the Dual Alliance with Austria-Hungary, followed by the Triple Alliance with Italy in 1882. It also retained strong diplomatic ties to the Ottoman Empire. When the great crisis of 1914 arrived, Italy left the alliance and the Ottoman Empire formally allied with Germany. """

paragraph = re.sub(r'\[[0-9]*\]', ' ', paragraph)
paragraph = re.sub(r'\s+',' ', paragraph)
paragraph = paragraph.lower()
paragraph = re.sub(r'\d',' ', paragraph)
paragraph = re.sub(r'\s+', ' ', paragraph)

sentences = nltk.sent_tokenize(paragraph)
 
sentences = [ nltk.word_tokenize(sent) for sent in sentences]

for i in range(len(sentences)):
    sentences[i] = [word for word in sentences[i] if word not in stopwords.words('english')]

model = Word2Vec(sentences, min_count = 1)
words = model.wv.key_to_index
vector = model.wv['germany']
similar = model.wv.most_similar('war')
words