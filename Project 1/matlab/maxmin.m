function [PQ] = maxmin(P, Q)
%MAXMIN Composition of P and Q using the max-min operator 
    PQ = max(bsxfun(@min, P, Q));
end

