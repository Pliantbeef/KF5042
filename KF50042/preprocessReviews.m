function [documents] = preprocessReviews(textData)

documents = tokenizedDocument(textData); % Tokenize the text.
documents = normalizeWords(documents,'Style','lemma');%lemmatise the text
documents = lower(documents); %make all characters lower case

documents = removeStopWords(documents); % Remove stop words.
documents = erasePunctuation(documents);%remove punctuation

documents = removeShortWords(documents,2); %removes words equal to or less than 2 in length 
end
