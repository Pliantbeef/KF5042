run prepareLex.m
run PrepareWordEmbedding.m %run the required prerequisites

%Convert the words in the training data to word vectors using word2vec. 

XTrain = word2vec(emb,data.Word);
YTrain = data.Label;

%Train a support vector machine (SVM) Sentiment Classifier which classifies word vectors into positive and negative categories.

SVMmdl = fitcsvm(XTrain,YTrain);

%trains on the words in the dictionary and their associated labels