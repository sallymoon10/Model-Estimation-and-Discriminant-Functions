%% model estimation 2d case
%non-parametric equation

load('lab2_2.mat');
variance = 400;
sigma = sqrt(variance);

%visualize data
figure;
plot(at(:,1),at(:,2),bt(:,1),bt(:,2),ct(:,1),ct(:,2),'LineStyle','none','Marker','*');

%define the range of x1 and x2 to plot, based on visualization of data
x1 = 1:450;
x2 = 1:450;

% For the window function, use a Gaussian that's large enough to cover the
% whole plot
window_length = -450:450;
gauss_window_1d = CalcGauss(window_length,0,variance);
gauss_window_2d = gauss_window_1d'*gauss_window_1d;

% Perform 2d integration to choose a normalizing factor so window function
% integrates to 1
sum_j = zeros(1,length(window_length));
for i = 1:length(window_length)
    for j = 2:length(window_length)
        sum_j(i) = sum_j(i) + gauss_window_2d(i,j);
    end
end
sum_i = 0;
for i = 2:length(window_length)
    sum_i = sum_i + sum_j(i);
end

%normalize
normalizing_factor = 1 / sqrt(sum_i);
gauss_window_1d = CalcGauss(window_length,0,variance) * normalizing_factor;
gauss_window_2d = gauss_window_1d'*gauss_window_1d;

%estimate PDFs for each cluster
[Pa,~,~] = parzen2(al,[1,x1(1),x2(1),x1(end),x2(end)],gauss_window_2d);
[Pb,~,~] = parzen2(bl,[1,x1(1),x2(1),x1(end),x2(end)],gauss_window_2d);
[Pc,~,~] = parzen2(cl,[1,x1(1),x2(1),x1(end),x2(end)],gauss_window_2d);

%apply ML classifer
sz = size(Pa);
Class = zeros(sz);
for i = 1:sz(1)
    for j = 1:sz(2)
        [~,I] = max([Pa(i,j),Pb(i,j),Pc(i,j)]);
        Class(i,j) = I; %1 = class a, 2 = class b, 3 = class c
    end
end

%generate plot
hold on;
contour(Class);
hold off;
title('Cluster data and ML classifier boundaries calculated using Parzen window estimation of PDF');
xlabel('x1');
ylabel('x2');