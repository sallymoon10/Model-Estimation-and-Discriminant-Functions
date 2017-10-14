% CalcUniform calculates the output of the uniform
% distribution at each input.
%
% a: lowest boundary sample
%
% b: highest boundary sample
%
% p_x: A vector of containing the outputs.

function p_x = CalcUniform(x, a, b)
    n = length(x);
    p_x = zeros(1,n);
    
    for i = 1 : n
        % probability is zero when x is outside boundary (a,b)
        if x(i) < a || x(i) > b
            p_x(i) = 0;
        else
            p_x(i) = 1 / (b - a);
        end
    end
end