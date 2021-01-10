function [out] = cosdefuzz(y, mf)
%COSDEFUZZ Center of sums defuzzifier
%   In order to use distributive implication, y must be a M*1 column vector
%   and mf must be a M*N matrix with N individual inference vector columns    
    dy = (y(end) - y(1))/(length(y) - 1);
    V = sum(mf)*dy;
    y_s = (y'*mf*dy)./V;
    V(isnan(y_s)) = [];
    y_s(isnan(y_s)) = [];
    out = V*y_s'/sum(V);
end
