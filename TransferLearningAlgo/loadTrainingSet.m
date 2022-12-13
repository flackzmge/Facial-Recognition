function [imgSet, personID]=loadTrainingSet(imgPath)
% imgSet stores the training images
% personID is the corresponding ID for each image. 


 
imgSet = imageDatastore(imgPath,'IncludeSubfolders',true,'LabelSource','foldernames');
personID = imgSet.Labels;


