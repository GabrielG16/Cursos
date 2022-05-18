import spacy

from spacy.matcher import Matcher

nlp = spacy.load('en_core_web_sm')

doc = nlp('This is Sparta!!')

#Tokens  
for token in doc:
    print(token.i, token.text)

# ENTS

doc2 = nlp('Apple is looking to buy U.K startup for 1$ billion dolllars')

for ent in doc2.ents:
    print(ent.text, ent.label_)

# Matcher - Identifica padrões sequencias de palavras dentro das especificações passadas.

doc = nlp('Barack Obama the former president of United States will be vacating white house today')

pattern = [[{'LEMMA':'vacate'}, {'ORTH':'white'}]]
matcher = Matcher(nlp.vocab)
matcher.add('white_Pattern', pattern)
matches = matcher(doc)

for match_id, start, end in matches:
    matched_span = doc[start:end]
    print(matched_span.text)
   
matches