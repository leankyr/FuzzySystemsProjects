function [dH, dV] = distances(x, y)
    if x <= 9, dV = y; 
    elseif x <= 10, dV = y - 4;
    elseif x <= 11, dV = y - 5;
    else dV = y - 6;
    end
    
    if y <= 5, dH = 10 - x;
    elseif y <= 6, dH = 11 - x;
    elseif y <= 7, dH = 12 - x;
    else dH = 15;
    end
end

