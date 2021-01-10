function [x, y] = simulate_system(x0, y0, theta0, flc)
    N = 1e3;
    v = 0.05;
    x = zeros(N, 1);
    y = zeros(N, 1);
    
    i = 1;
    x(1) = x0;
    y(1) = y0;
    theta = theta0;
    while x(i) <= 15 && i <= N
        [dH, dV] = distances(x(i), y(i));
        dH = min(1, max(0, dH/15));
        dV = min(1, max(0, dV/6.2));
        dtheta = evalfis([dH dV theta], flc);
        theta = min(180, max(-180, theta + dtheta));
        i = i + 1;
        x(i) = x(i-1) + v*cosd(theta);
        y(i) = y(i-1) - v*sind(theta);
%         disp(['[' num2str(x(i)) ', ' num2str(y(i)) ', ' num2str(theta) ']']);
    end
    x = x(1:i);
    y = y(1:i);
end

