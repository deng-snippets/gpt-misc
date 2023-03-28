import os
import pandas as pd
from transformers import pipeline

os.chdir('.../sent/')


def get_sentiment(x):
    sentiment = sentiment_analysis(x)[0]
    score = sentiment['score']*(-1 if sentiment['label'] == 'NEGATIVE' else 1)
    return score


sentiment_analysis = pipeline("sentiment-analysis",
                              model="siebert/sentiment-roberta-large-english")

data = pd.read_csv('data.csv', sep=';')

comment_cols = ['comment_1', 'comment_2', 'comment_3']
target_cols = [col + '_sent' for col in comment_cols]

data[target_cols] = data[comment_cols].applymap(get_sentiment)

for col in comment_cols:
    data[col + '_score'] = sentiment_analysis(data[col])
