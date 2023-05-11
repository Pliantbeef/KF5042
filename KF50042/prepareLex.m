
fidPositive = fopen(fullfile('opinion-lexicon-English','positive-words.txt'));
C = textscan(fidPositive,'%s','CommentStyle',';'); %skip comment lines 
wordsPositive = string(C{1});
fclose all;


fidNegative = fopen(fullfile('opinion-lexicon-English','negative-words.txt'));
C = textscan(fidNegative,'%s','CommentStyle',';'); %skip comment lines 
wordsNegative = string(C{1});
fclose all;

%retrieves the positive and negative words from the .txt filesand assigns
%them to wordsPositive and wordsNegative respectively


