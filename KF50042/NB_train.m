
filename = "movies_train.xlsx";
dataReviews = readtable(filename,'TextType','string'); 
textData = dataReviews.text; %get review text 
actualScore = dataReviews.label; %get review sentiment

trainDocs = preprocessReviews(textData); %preprocess the training data

BOW = bagOfWords(trainDocs); %create a bag of words model of the training docs

NBmdl = fitcnb(BOW.Counts,actualScore,'DistributionNames','mn');
%train a multinomial naive bayes model.
