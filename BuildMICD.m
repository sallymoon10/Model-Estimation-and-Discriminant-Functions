% BuildMICD classifies each points in feature space using MICD method
%
% feature: a feature matrix provided for this lab.
% the first two rows represents the two features.
% the third row represents the image number.
% the forth row represents the block number.
%
% x1: is the range of points in first feature dimension in space
%
% x2: is the range of points in second feature dimension in space
%
% space: A n-by-n-by-2 matrix representing coordinates in the 2d section of
% the feature space in which classification will be performed. The first
% layer of the 3d matrix is a n-by-n array containing the x1 coordinates of
% each subsection in the section. The second layer contains the x2 
% coordinates.
%
% classIndex: A n-by-n array where each element corresponds to a subsection
% in the space, and where the value of each element is the class index of 
% the corresponding subsection, which indicates the class of that 
% subsection identified by the classifier.
function [x1,x2,space,classIndex] = BuildMICD(feature)
%% input simplification
f = feature(1:2,:);
img = feature(3,:);
%% n is the number of images(classes)
n = max(img);
%% feature space
numPoints = 450;
upper_limit = -Inf;
lower_limit = Inf;
upper_limit = max(upper_limit,max(f,[],2));
lower_limit = min(lower_limit,min(f,[],2));
x1 = linspace(0.8*lower_limit(1),1.2*upper_limit(1),numPoints);
x2 = linspace(0.8*lower_limit(2),1.2*upper_limit(2),numPoints);
[space1,space2] = meshgrid(x1,x2);
space = cat(3,space1,space2);
%% find the distances of points in space from the classes
dg = zeros(size(space,1),size(space,2),n);
for k = 1:n
    indices = find(img == k);
    mui = mean(f(:,indices)')';
    S = cov(f(:,indices)');
    for i = 1:size(space,1)
        for j = 1:size(space,2)
            x = [space(i,j,1);space(i,j,2)]; % finds coordinates of this particular subsection
            dg(i,j,k) =  sqrt((x - mui)' * inv(S) * (x - mui));
        end
    end
end
% For each subsection in the space, finds the minimum generalized Euclidean
% distance to a class. The index of this minimum in the 3rd dimension of dg
% indicates which class the subsection was classified to.
[~,classIndex] = min(dg,[],3); 
end
