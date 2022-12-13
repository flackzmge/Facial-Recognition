function  outputIDNew=FaceRecognitionNew(trainImgSet, trainPersonID, testPath)
%%   Face reconition method using Resnet-50 and Sparse Representation
%    trainImgSet: contains all the given training face images
%    trainPersonID: indicate the corresponding ID of all the training images
%    testImgSet: constains all the test face images
%    outputID - predicted ID for all tested images                    
%% Load Test and Test labels




testImgSet = imageSet(testPath,"recursive")
testImgNames=dir([testPath,'*.jpg']);
testImgLabels = "";
for i=1:size(testImgNames,1)
    
    testImgLabels=[testImgLabels; extractBefore(testImgNames(i,:).name,".")];
    
   
end

testImgLabels = testImgLabels(2:end);

%training = trainImgSet;
test = imageSet(testPath,"recursive");
test = transpose(test);
TestpersonID = cellstr(testImgLabels);

TestpersonID = transpose(TestpersonID);

%% Extract HOG Features for training set

trainingFeatures = zeros(size(trainImgSet,2)*trainImgSet(1).Count,197136);
featureCount = 1;
for i=1:size(trainImgSet,2)
    for j = 1:trainImgSet(i).Count
        trainingFeatures(featureCount,:) = extractHOGFeatures(read(trainImgSet(i),j));
        
        featureCount = featureCount + 1;
        
    end
    
end

%% Create a classifier using fitcknn using training features and the training labels
hogClassifier = fitcknn(trainingFeatures,trainPersonID); % fitcecoc  fitcknn fitcsvm



%% Testing the HOG-KNN Model against the test set


%disp(numel(test))
FinalLabels = [];
for img=1:1344  % amount of images in the Testing
         
        SaveImage = readimage(test,img); %read(test(person),j);
        
        Features = extractHOGFeatures(SaveImage);
        predictedLabels = predict(hogClassifier,Features);
        FinalLabels = [FinalLabels,string(predictedLabels)];
        
end
   


outputIDNew=FinalLabels;

%save hogClassifier
