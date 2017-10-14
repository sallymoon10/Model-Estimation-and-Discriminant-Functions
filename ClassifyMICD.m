% ClassifyMICD classify the pixels based on the feature matrix
%
% feature: a n-by-n-by-2 feature matrix provided for this lab as features
% of an image
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
function [cimage] = ClassifyMICD(feature,space,classifier)
%% input simplification
f = feature;
%% initialization
cimage = zeros(size(f,1),size(f,2));
%% find the closest point in the classifier to each feature data
for i = 1:size(f,1)
    for j = 1:size(f,2)
        x = squeeze(f(i,j,:));
        temp1 = x(1) - space(:,:,1);
        temp2 = x(2) - space(:,:,2);
        difference = sqrt(temp1.^2 + temp2.^2);
        [~,indices] = min(difference,[],1);
        [~,index2] = min(min(difference),[],2);
        index1 = indices(1);
        cimage(i,j) = classifier(index1,index2);
    end  
end