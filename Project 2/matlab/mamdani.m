function [R] = mamdani(a, b)
%MAMDANI Generates rule matrix R with the Mamdani implication operator
    [A, B] = meshgrid(a, b);
    R = min(A, B)';
end

