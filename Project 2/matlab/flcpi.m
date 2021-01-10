function [out] = flcpi(in)
%FLCPI Wrapper for evalfis using COS defuzzification
%   Let cancer commence
    global flc;
    [~, ~, ORR, ~] = evalfis(in, flc, 1001);
    out = cosdefuzz(linspace(-1, 1, 1001)', ORR);
end

