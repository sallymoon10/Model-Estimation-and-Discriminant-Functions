% CalcGauss2 calculates the output of the 2d Gaussian distribution at each
% input.
%
% x: A matrix of inputs where each element represents a point at which to
% calculate the Gaussian distribution and each element contains the x
% coordinate at that point.
%
% y: A matrix of inputs where each element represents a point at which to
% calculate the Gaussian distribution and each element contains the y
% coordinate at that point.
%
% mu: The mean of the distribution.
% 
% cov: The covariance of the distribution.
%
% p_x: A matrix of outputs.

function p_x = CalcGauss2(x, y, mu, cov)
    sz = size(x);
    n = sz(1);
    m = sz(2);
    p_x = zeros(n,m);    
    for i = 1:n
        for j = 1:m
            x1 = x(i,j);
            x2 = y(i,j);
            x_val = [x1 x2];
            x_val = x_val(:);
            mu = mu(:);            
            p_x(i,j) = (exp(-1/2 *(x_val-mu)' * inv(cov) *((x_val)-mu)))/ (2*pi*sqrt(det(cov)));
            
        end
    end
end