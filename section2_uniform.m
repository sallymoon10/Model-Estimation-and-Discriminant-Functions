%% model estimation 1d case
%parametric estimation - uniform

load('lab2_1.mat');
mu = 5;
sigma = 1;
lambda = 1;

%data set a

% The best ML estimate of a is the minimum sample value 
% and the best ML estimate of b is the maximum sample value
a_boundary = min(a);
b_boundary = max(a);

x = 0:0.01:10;
p_hat_x = CalcUniform(x, a_boundary, b_boundary);
p_x = CalcGauss(x,mu,sigma^2);
figure;
plot(x,p_hat_x,x,p_x);

title('Probability distribution of data set a');
xlabel('x');
ylabel('Probability');
legend('Estimated (Uniform)','True (Gaussian)');

% data set b
a_boundary = min(b);
b_boundary = max(b);

x = -5:0.01:5;
p_hat_x = CalcUniform(x, a_boundary, b_boundary);
p_x = CalcExponentialDistribution(x,lambda);
figure;
plot(x,p_hat_x,x,p_x);

title('Probability distribution of data set b');
xlabel('x');
ylabel('Probability');
legend('Estimated (Uniform)','True (Exponential)');