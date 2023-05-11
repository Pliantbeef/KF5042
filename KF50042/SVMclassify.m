filename = "movies_test.xlsx";
dataReviews = readtable(filename,'TextType','string'); 
textData = dataReviews.text; %get review text 
actualScore = dataReviews.label; %get review sentiment

sents = preprocessReviews(textData); %preprocess the test data

idx = ~isVocabularyWord(emb,sents.Vocabulary);
sents = removeWords(sents, idx);
%remove words from the test data that are not present in fastwordembedding


sentimentScore = zeros(size(sents)); %create a blank sentiment score matrix the same size as the training documents

for ii = 1 : sents.length %for every doc in sents
    docwords = sents(ii).Vocabulary; %retrieve the documents text
    for jj = 1 : length(docwords) %for each word in the documents text
        vec = word2vec(emb,docwords);%convert documentt to a series of word embeddings
        if any(any(isnan(vec))) %if any field of the word embedding is NAN
            sentimentScore(ii) = 0;%sentiment score = 0 indicating failed to classify
        else
            [~,scores] = predict(SVMmdl,vec); %predict the sentiment of each word in the document
            sentimentScore(ii) = mean(scores(:,1)); %assign the sentiment score of the document to the mean of the sentiment scores of its tokens
        end
    end
    fprintf('Sent: %d, words: %s, FoundScore: %d, GoldScore: %d\n', ii, joinWords(sents(ii)), sentimentScore(ii), actualScore(ii));
end

sentimentScore(sentimentScore > 0) = 1;   %take >1 to be 1 only
sentimentScore(sentimentScore < 0)= -1;   %there is no neutral only negative


notfound = sum(sentimentScore == 0);
covered = numel(sentimentScore)- notfound;

tp=0; tn=0; fn=0; fp=0; 
for i=1:length(actualScore)
    if sentimentScore(i)==1 && actualScore(i)==1
        tp=tp+1; 
    elseif sentimentScore(i)==-1 && actualScore(i)==0
        tn=tn+1; 
    elseif sentimentScore(i)==-1 && actualScore(i)==1
        fn=fn+1;
    elseif sentimentScore(i)==1 && actualScore(i)==0
        fp=fp+1;
    end
end%finds false positives, false negative, true positives and true negatives

SVMaccuracy = (tp+tn)/(tp+fp+tn+fn)*100
SVMprecision = tp/(tp+fp)*100
SVMrecall = tp/(tp+fn)*100
SVMfmeasure=2*((SVMprecision*SVMrecall)/(SVMprecision+SVMrecall))
%generates the accuracy,precision, recall and fmeasure

actualScore(actualScore < 1) = -1;
%changes any actualScore that has a value of less than 1(0) to negative 1
%for mapping to the confusion chart
confusionchart(actualScore,sentimentScore, 'ColumnSummary','column-normalized'); 
%generates the confusion chart