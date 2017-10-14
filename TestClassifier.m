% TestClassifier calculates the probability of error and confusion matrix
%
% feature: a feature matrix provided for this lab as test data.
% the first two rows represents the two features.
% the third row represents the image number.
% the forth row represents the block number.
%
% space: A n-by-n-by-2 matrix representing coordinates in the 2d section of
% the feature space in which classification will be performed. The first
% layer of the 3d matrix is a n-by-n array containing the x1 coordinates of
% each subsection in the section. The second layer contains the x2
% coordinates.
%
% classifier: A n-by-n array where each element corresponds to a subsection
% in the space, and where the value of each element is the class index of
% the corresponding subsection, which indicates the class of that
% subsection identified by the classifier.
%
% totalError: A number representing the error rate of whole data.
%
% imageError: a 1-by-n vector containing the error rate of each image
%
% confusionMatrix: A n-by-n matrix containing the confusion matrix of the
% classifier tested with the input feature data.
function [totalError,imageError,confusionMatrix] = TestClassifier(feature,space,classifier)
%% input simplification
f = feature(1:2,:);
img = feature(3,:);
%% n is the number of images(classes)
n = max(img);
%% initialization
confusionMatrix = zeros(n,n);
imageError = zeros(1,n);
error = 0;
counter = 0;
%% find the closest point in the classifier to each feature data
for i = 1:n % classes
    actual = i;
    indices = find(img == i);
    xi = f(:,indices);
    nSamples = size(xi,2);
    for isample = 1:nSamples;
        counter = counter + 1;
        temp1 = xi(1,isample) - space(:,:,1);
        temp2 = xi(2,isample) - space(:,:,2);
        difference = sqrt(temp1.^2 + temp2.^2);
        [~,indices] = min(difference,[],1);
        [~,index2] = min(min(difference),[],2);
        index1 = indices(1);
        predicted = classifier(index1,index2);
        % confusion matrix
        confusionMatrix(actual,predicted) = confusionMatrix(actual,predicted) + 1;
        if (actual ~= predicted)
            error = error + 1;
        end
    end
end
% calculate the error rate for whole data set
totalError = error/counter * 100;
% calculate the erorr rate for each image
for i = 1:n
    imageError(i) = (1 - confusionMatrix(i,i)/sum(confusionMatrix(i,:))) * 100;
end
end