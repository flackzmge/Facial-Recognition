function [imgSet, personID]=loadTrainingSet(imgPath)
% imgSet stores the training images
% personID is the corresponding ID for each image. 



 
imgSet = imageSet(imgPath,'recursive');


for i=1:size(imgSet,2)
    
    personID{i} = imgSet(i).Description;
end


