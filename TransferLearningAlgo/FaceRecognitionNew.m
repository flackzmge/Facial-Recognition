function  outputIDNew=FaceRecognitionNew(trainImgSet, trainPersonID, testPath)
%%   Face reconition method using Resnet-50 and Sparse Representation
%    trainImgSet: contains all the given training face images
%    trainPersonID: indicate the corresponding ID of all the training images
%    testImgSet: constains all the test face images
%    outputID - predicted ID for all tested images 

%% Extract features from the training images: Using Transfer Learning/Feature extraction   


%% Load Pretrained network


net = alexnet;

                   
%% Load Test Images and Test Labels


testImgSet = imageDatastore(testPath,'IncludeSubfolders',true,'LabelSource','foldernames');

testImgNames=dir([testPath,'*.jpg']);
testImgLabels = "";
for i=1:size(testImgNames,1)
    testImgLabels=[testImgLabels; extractBefore(testImgNames(i,:).name,".")];
end

testImgLabels = testImgLabels(2:end);



%% Face recognition/Classification for all the test images

 img = net.Layers(1).InputSize;
 augtrainimgset = augmentedImageDatastore(img(1:2),trainImgSet); 
 augtestimgset = augmentedImageDatastore(img(1:2),testImgSet);
 
imdsTrain = augtrainimgset;
imdsValidation = augtestimgset;
 
net=alexnet;


% Extracting all layers except last 3.
layersTransfer = net.Layers(1:end-3);

numClasses = numel(categories(trainPersonID));

layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];
%% Network Training


options = trainingOptions('sgdm',...
     'MiniBatchSize',10,...
     'MaxEpochs',12,...
     'InitialLearnRate',1e-4);
 
% % Fine-tune the network using trainNetwork on the new layer array
netTransfer = trainNetwork(imdsTrain,layers,options);

%%

% Classify the test images using classify
predictedLabels = classify(netTransfer,imdsValidation);

 %labelIndx=predictedLabels;    
 %outputIDNew = [];

 outputIDNew=predictedLabels;



end