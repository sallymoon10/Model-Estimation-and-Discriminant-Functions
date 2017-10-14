%% model estimation 1d case
%parametric estimation - gaussian

load('lab2_1.mat');
mu = 5;
sigma = 1;
lambda = 1;

%data set a
N = length(a);
mu_hat = sum(a) / N;
variance_hat = sum((a - mu_hat).^2) / N;

x = 0:0.1:10;
p_hat_x = CalcGauss(x,mu_hat,variance_hat);
p_x = CalcGauss(x,mu,sigma^2);
figure;
plot(x,p_hat_x,x,p_x);

title('Probability distribution of data set a');
xlabel('x');
ylabel('Probability');
legend('Estimated (Gaussian)','True (Gaussian)');

%data set b
N = length(b);
mu_hat = sum(b) / N;
variance_hat = sum((b - mu_hat).^2) / N;

x = -5:0.1:5;
p_hat_x = CalcGauss(x,mu_hat,variance_hat);
p_x = CalcExponentialDistribution(x,lambda);
figure;
plot(x,p_hat_x,x,p_x);

title('Probability distribution of data set b');
xlabel('x');
ylabel('Probability');
legend('Estimated (Gaussian)','True (Exponential)');