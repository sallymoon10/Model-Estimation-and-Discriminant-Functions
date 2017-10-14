%% model estimation 2d case

load('lab2_2.mat');

% parametric estimation - gaussian

% ML estimatation for parameters of cluster A

% Calculating sample mean of cluster A
mu_hat_a = mean(al);    

% Calculating sample variance of cluster A
variance_hat_a = zeros(2,2);
for i= 1: length(al)
    variance_hat_a = variance_hat_a + (al(i , :)' * al(i , :));
end
N = length(al);
variance_hat_a = variance_hat_a / N;
variance_hat_a = variance_hat_a - (mu_hat_a' * mu_hat_a);

% ML estimatation for parameters of cluster B

% Calculating sample mean of cluster B
mu_hat_b = mean(bl);

% Calculating sample variance of cluster B
variance_hat_b = zeros(2,2);
for i= 1: length(bl)
    variance_hat_b = variance_hat_b + (bl(i , :)' * bl(i , :));
end
N = length(bl);
variance_hat_b = variance_hat_b / N;
variance_hat_b = variance_hat_b - (mu_hat_b' * mu_hat_b);

% ML estimatation for parameters of cluster C 

% Calculating sample mean of cluster C
mu_hat_c = mean(cl);

% Calculating sample variance of cluster C
variance_hat_c = zeros(2,2);

for i= 1: length(cl)
    variance_hat_c = variance_hat_c + (cl(i , :)' * cl(i , :));
end
N = length(cl);
variance_hat_c = variance_hat_c / N;
variance_hat_c = variance_hat_c - (mu_hat_c' *mu_hat_c);

%% ML classifier for Parametric Estimation 
x1 = 1:450;
x2 = 1:450;
[X,Y] = meshgrid(x1, x2);

Pa = CalcGauss2(X,Y,mu_hat_a,variance_hat_a);
Pb = CalcGauss2(X,Y,mu_hat_b,variance_hat_b);
Pc = CalcGauss2(X,Y,mu_hat_c,variance_hat_c);

% apply ML classifer
sz = size(Pa);

Class = zeros(sz);
for i = 1:sz(1)
    for j = 1:sz(2)
        [~,I] = max([Pa(i,j),Pb(i,j),Pc(i,j)]);
        Class(i,j) = I; %1 = class a, 2 = class b, 3 = class c
    end
end


% generate plot
figure;
plot(at(:,1),at(:,2),bt(:,1),bt(:,2),ct(:,1),ct(:,2),'LineStyle','none','Marker','*');
hold on;
contour(Class);
hold off;
title('Cluster data and ML classifier boundaries calculated Parametric estimation of Gaussian PDF');
xlabel('x1');
ylabel('x2');















