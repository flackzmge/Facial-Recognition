clear all;
close all;
trainPath='/Users/nathangilbert/Documents/MATLAB/FRComp3007/HOGAlgo/FaceDatabase/Train'; % These training/testing folders need to be in the same root folder of this code. 
testPath='/Users/nathangilbert/Documents/MATLAB/FRComp3007/HOGAlgo/FaceDatabase/Test/';   % Or you can use the full folder path here
%% Retrive training and testing images

[trainImgSet, trainPersonID]=loadTrainingSet(trainPath); % load training images

size(trainImgSet)  % 


%% Method developed by me


tic;
   outputIDNew=FaceRecognitionNew(trainImgSet, trainPersonID, testPath);
 methodNewTime=toc
 
 load testLabel
 outputIDNew = transpose(outputIDNew);
 correctP=0;
 for i=1:size(testLabel,1)
     checkPredict = outputIDNew(i,:); %string(outputIDNew(i,:));
     checkTest = string(testLabel(i,:));
     if strcmp(checkPredict, checkTest)
         correctP=correctP+1;
     end
 end
 recAccuracyNew=correctP/size(testLabel,1)*100  %Recognition accuracy
 
 
