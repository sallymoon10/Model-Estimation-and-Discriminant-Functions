% CalcGauss calculates the output of the Gaussian distribution at each
% input.
%
% x: A n-by-m matrix where n is the number of dimensions of each input and
% m is the number of inputs.
%
% mu: A n-by-1 vector of the mean of the distribution.
%
% cov: The covariance of the distribution.
%
% p_x: A 1-by-m vector of outputs.

function p_x = CalcGauss(x, mu, cov)

sz = size(x);
n = sz(1);
m = sz(2);

p_x = zeros(1,m);

for i = 1:m
    p_x(i) = 1 / (2*pi)^(n/2) / sqrt(det(cov))...
        * exp(-1/2*(x(:,i)-mu)'*inv(cov)*(x(:,i)-mu));
end