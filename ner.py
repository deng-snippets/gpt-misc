import os
import pandas as pd
import spacy
from collections import Counter

# !python -m spacy download en_core_web_lg
os.chdir('C:/projekty/py/sent/')
nlp = spacy.load("en_core_web_sm")
stopwords = spacy.lang.en.stop_words.STOP_WORDS

feature_names = ["FEATURE1", "FEATURE2", "FEATURE3",
                 "FEATURE4", "FEATURE5", "FEATURE6"]
counts = {feature: Counter() for feature in feature_names}

data = pd.read_csv('data.csv', sep=';')['comment_1']





entities = ["FEATURE1", "FEATURE2", "FEATURE3", "FEATURE4", "FEATURE5", "FEATURE6"]
counts = {ent: Counter() for ent in entities}

for sent in data:
    doc = nlp(sent)
    token_gen = (token for token in doc if token.pos_ in ["ADJ", 'ADV'] and token.text not in stopwords)
    for token in token_gen:
        ent_gen = (ent for ent in doc.ents if ent.text in entities)
        for ent in ent_gen:
            counts[ent.text][token.text] += 1
