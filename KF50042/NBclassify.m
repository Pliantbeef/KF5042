filename = "movies_test.xlsx";
dataReviews = readtable(filename,'TextType','string'); 
textData = dataReviews.text; %get review text 
actualScore = dataReviews.label; %get review sentiment

sents = preprocessReviews(textData); %preprocess testing data

sentimentScore = zeros(size(sents));%create a blank matrix the 
% size of the testing docs


for ii = 1 : sents.length %for every document in sents
    testDoc = encode(BOW,sents(ii).Vocabulary); %encode it in the bag of words
 
    sentimentScore(ii)=predict(NBmdl,testDoc);%assign the sentiment score
    %of the tested document
    
    fprintf('Sent: %d, words: %s, FoundScore: %d, GoldScore: %d\n', ii, joinWords(sents(ii)), sentimentScore(ii), actualScore(ii));

end



tp=0; tn=0; fn=0; fp=0; 
for i=1:length(actualScore)
    if sentimentScore(i)==1 && actualScore(i)==1
        tp=tp+1; 
    elseif sentimentScore(i)==0 && actualScore(i)==0
        tn=tn+1; 
    elseif sentimentScore(i)==0 && actualScore(i)==1
        fn=fn+1;
    elseif sentimentScore(i)==1 && actualScore(i)==0
        fp=fp+1;
    end
end %finds false positives, false negative, true positives and true negatives

NBaccuracy = (tp+tn)/(tp+fp+tn+fn)*100
NBprecision = tp/(tp+fp)*100
NBrecall = tp/(tp+fn)*100
NBfmeasure=2*((NBprecision*NBrecall)/(NBprecision+NBrecall))
%generates the accuracy,precision, recall and fmeasure

confusionchart(actualScore,sentimentScore, 'ColumnSummary','column-normalized'); 
%generates the confusion chart