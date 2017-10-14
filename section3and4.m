%% bahareh script
close all
clear all
clc
%% load feature file
load feat.mat
%% initialization
num = [2,8,32];
data = cell(1,3);
data{1} = f2; data{2} = f8; data{3} = f32;
datat = cell(1,3);
datat{1} = f2t; datat{2} = f8t; datat{3} = f32t;
classifiers = cell(1,3);
imageErrors = cell(1,3);
totalErrors = cell(1,3);
confusionMatrices = cell(1,3);
%% save the plots of feature space
for i = 1:3
    f = data{i};
    aplot(f)
    xlabel('x1'), ylabel('x2')
    title(['f',num2str(num(i)),' Features of Texture Images'])
    filename = ['f',num2str(num(i)),'_feature_space'];
    saveas(gcf,filename,'png');
    close all
end
%% build MICD classifiers
for i = 1:3
    f = data{i};
    ft = datat{i};
    [x1,x2,space,classifiers{i}] = BuildMICD(f);
    [totalErrors{i},imageErrors{i},confusionMatrices{i}] = TestClassifier(ft,space,classifiers{i});
end
%% classify an image with 8 features extarcted
[x1,x2,space,classifier] = BuildMICD(f8);
cimage = ClassifyMICD(multf8,space,classifier);

close all
imagesc(cimage)
colormap gray
figure
imagesc(multim)
colormap gray
