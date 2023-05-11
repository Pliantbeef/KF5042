emb = fastTextWordEmbedding; %retrieve the fast word embedding object
words = [wordsPositive;wordsNegative]; %create
labels = categorical(nan(numel(words),1)); %create a blank categorical matrix the leng of words
labels(1:numel(wordsPositive)) = "Positive"; %set every positive word to have the positive label
labels(numel(wordsPositive)+1:end) = "Negative";%set every negative word to have the negative label

data = table(words,labels,'VariableNames',{'Word','Label'}); %create a new matrix with two columns word and label, each word has a correct sentiment label
idx=~isVocabularyWord(emb,data.Word);
data(idx,:) = [];%remove any words that are not in fastwordembedding
