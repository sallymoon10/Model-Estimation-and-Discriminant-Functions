%% model estimation 1d case
%parametric estimation - exponential

load('lab2_1.mat');
mu = 5;
sigma = 1;
lambda = 1;

%data set a
N = length(a);
lambda_hat = N / sum(a);

x = -5:0.01:20;
p_hat_x = CalcExponentialDistribution(x,lambda_hat);
p_x = CalcGauss(x,mu,sigma^2);
figure;
plot(x,p_hat_x,x,p_x);

title('Probability distribution of data set a');
xlabel('x');
ylabel('Probability');
legend('Estimated (Exponential)','True (Gaussian)');

%data set b
N = length(b);
lambda_hat = N / sum(b);

x = -5:0.01:20;
p_hat_x = CalcExponentialDistribution(x,lambda_hat);
p_x = CalcExponentialDistribution(x,lambda);
figure;
plot(x,p_hat_x,x,p_x);

title('Probability distribution of data set b');
xlabel('x');
ylabel('Probability');
legend('Estimated (Exponential)','True (Exponential)');