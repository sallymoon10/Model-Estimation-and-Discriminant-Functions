% CalcExponentialDistribution calculates the output of the exponential
% distribution at each input.
%
% x: A vector of length n containing the inputs.
%
% lambda: The parameter of the exponential distribution.
%
% p_x: A vector of length n containing the outputs.

function p_x = CalcExponentialDistribution(x, lambda)

n = length(x);
p_x = zeros(1,n);

for i = 1:n
    if x(i) < 0
        p_x(i) = 0;
    else
        p_x(i) = lambda*exp(-1*lambda*x(i));
    end
end