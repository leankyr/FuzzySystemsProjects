clc; clear; close all;
cmap = colormap(lines);
xtick = 0:45:360;
ytick = -5:2.5:5;
for x = 1:9
    xticklbl{x} = ['$' num2str((x-1)*45) '\degree$'];
end
for y = 1:5
    yticklbl{y} = ['$' num2str((y-3)*2.5) '$'];
end
x = (0:5:360)';
y = linspace(-5, 5, length(x))';

%% Part 1
%% Input sets
A(:, 1) = evalmf(x, [-90, 0, 90], 'trimf');
A(:, 2) = evalmf(x, [0, 90, 180], 'trimf');
A(:, 3) = evalmf(x, [90, 180, 270], 'trimf');
A(:, 4) = evalmf(x, [180, 270, 360], 'trimf');
A(:, 5) = evalmf(x, [270, 360, 450], 'trimf');

% Input sets plot
figure(1)
    hold on; box on;
    axis([0 360 0 1.25])
    plot(x, A(:, 1), 'k');
    plot(x, A(:, 2), 'k');
    plot(x, A(:, 3), 'k');
    plot(x, A(:, 4), 'k');
    plot(x, A(:, 5), 'k');
    text('String', 'A_1', 'Position', [3.6 1.1 0], 'HorizontalAlignment', 'left');
    text('String', 'A_2', 'Position', [90 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_3', 'Position', [180 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_4', 'Position', [270 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_5', 'Position', [356.4 1.1 0], 'HorizontalAlignment', 'right');
    xlabel('$x$', 'Interpreter', 'Latex');
    ylabel('$\mu$', 'Interpreter', 'Latex');
    %set(gca, 'Xtick', xtick);
    %set(gca, 'XtickLabel', xticklbl);
%     save2tikz
     
%% Output sets
NL = evalmf(y, [-10, -5, 0], 'trimf');
ZE = evalmf(y, [-5, 0, 5], 'trimf');
PL = evalmf(y, [0, 5, 10], 'trimf');

% Output sets plot
figure(2);
    hold on;
    axis([-5 5 0 1.25]);
    box on;
    plot(y, NL, 'k');
    plot(y, ZE, 'k');
    plot(y, PL, 'k');
    text('String', 'NL', 'Position', [-4.84 1.1 0], 'HorizontalAlignment', 'left');
    text('String', 'ZE', 'Position', [0 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'PL', 'Position', [4.84 1.1 0], 'HorizontalAlignment', 'right');
    xlabel('$y$', 'Interpreter', 'Latex')
    ylabel('$\mu$', 'Interpreter', 'Latex')
  %  set(gca, 'Xtick', ytick);
  % set(gca, 'XtickLabel', yticklbl);
%     save2tikz
    
%% Rulebase
R(:, :, 1) = mamdani(A(:, 1), PL);	% IF (x is A_1) THEN (y is PL)
R(:, :, 2) = mamdani(A(:, 5), PL);  % IF (x is A_5) THEN (y is PL)
R(:, :, 3) = mamdani(A(:, 2), ZE);  % IF (x is A_2) THEN (y is ZE)
R(:, :, 4) = mamdani(A(:, 4), ZE);  % IF (x is A_4) THEN (y is ZE)
R(:, :, 5) = mamdani(A(:, 3), NL);  % IF (x is A_3) THEN (y is NL)

%% Singleton input (x = 70)
input = x == 70;
firings = eye(size(x, 1));
B = zeros(size(R, 3), size(x, 1));
for j = 1:size(R, 3)
    B(j, :) = maxmin(firings(:, input), R(:, :, j));
end
cosdefuzz(y, B')

% Input plot
figure(3)
    hold on; box on;
    axis([0 360 0 1.25])
    plot(x, A(:, 1), 'k');
    plot(x, A(:, 2), 'k');
    plot(x, A(:, 3), 'k');
    plot(x, A(:, 4), 'k');
    plot(x, A(:, 5), 'k');
    plot([70 70], [0 1], 'k');
    plot(70, 0.2222, 'o', 'MarkerFaceColor', 'k', ...,
        'MarkerEdgeColor', 'k', 'MarkerSize', 2.5);
    plot(70, 0.7778, 'o', 'MarkerFaceColor', 'k', ...,
        'MarkerEdgeColor', 'k', 'MarkerSize', 2.5);
    plot([0, 70], [0.2222, 0.2222], '--k');
    plot([0, 70], [0.7778, 0.7778], '--k');
    text('String', 'DOF_{R_3}', 'Position', [40 0.8778 0], 'HorizontalAlignment', 'center');
    text('String', 'DOF_{R_1}', 'Position', [90 0.3222 0], 'HorizontalAlignment', 'center');
    text('String', 'A_1', 'Position', [3.6 1.1 0], 'HorizontalAlignment', 'left');
    text('String', 'A_2', 'Position', [90 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_3', 'Position', [180 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_4', 'Position', [270 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_5', 'Position', [356.4 1.1 0], 'HorizontalAlignment', 'right');
    xlabel('$x$', 'Interpreter', 'Latex');
    ylabel('$\mu$', 'Interpreter', 'Latex');
    set(gca, 'Xtick', xtick);
    set(gca, 'XtickLabel', xticklbl);
%     save2tikz

%{
% Output plot
figure(4)
    hold on; box on;
    axis([-5 5 0 1.25]);
    plot(y, B(1, :)', 'k');
    plot(y, B(3, :)', 'k');
    plot(y, NL, 'k');
    plot(y, ZE, 'k');
    plot(y, PL, 'k');
    plot([-5, 1.1111], [0.2222, 0.2222], '--k');
    plot([-5, -1.1111], [0.7778, 0.7778], '--k');
    text('String', 'DOF_{R_3}', 'Position', [-2 0.8778 0], 'HorizontalAlignment', 'center');
    text('String', 'DOF_{R_1}', 'Position', [0 0.3222 0], 'HorizontalAlignment', 'center');
    text('String', 'NL', 'Position', [-4.84 1.1 0], 'HorizontalAlignment', 'left');
    text('String', 'ZE', 'Position', [0 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'PL', 'Position', [4.84 1.1 0], 'HorizontalAlignment', 'right');
    xlabel('$y$', 'Interpreter', 'Latex')
    ylabel('$\mu$', 'Interpreter', 'Latex')
    set(gca, 'Xtick', -5:2.5:5);
%     save2tikz

%% Fuzzy estimate given by x-y relation
output = zeros(size(x,1), 1);
for i = 1:size(x, 1);
    B = zeros(size(R, 3), size(x, 1));
    for j = 1:size(R, 3)
        B(j, :) = maxmin(firings(:, i), R(:, :, j));
    end
    output(i) = cosdefuzz(y, B');
end

% Fuzzy estimate plot
figure(5)
    axis tight; box on; hold on;
    plot(x, output, 'k');
    plot(x, 5*cos(2*pi*x/360), '--k');
    l = legend('Fuzzy estimate', 'Real function');
    set(l, 'Interpreter', 'Latex');
    set(gca, 'Xtick', xtick);
    set(gca, 'XtickLabel', xticklbl);
    xlabel('$x$', 'Interpreter', 'Latex')
    ylabel('$y$', 'Interpreter', 'Latex')
%     save2tikz   

mse(5*cos(2*pi*x/360) - output)
    
% Error plot
figure(6)
    axis tight; box on; hold on;
    plot(x, 5*cos(2*pi*x/360) - output, 'k');
    set(gca, 'Xtick', xtick);
    set(gca, 'XtickLabel', xticklbl);
    xlabel('$x$', 'Interpreter', 'Latex')
    ylabel('$e$', 'Interpreter', 'Latex')
%     save2tikz
    
    
%% Part 2
xtick = [0 60 90 120 180 240 270 300 360];
for i = 1:9
    xticklbl{i} = ['$' num2str(xtick(i)) '\degree$'];
end

%% Input sets
A(:, 1) = evalmf(x, [-60, 0, 60], 'trimf');
A(:, 2) = evalmf(x, [0, 60, 90], 'trimf');
A(:, 3) = evalmf(x, [60, 90, 120], 'trimf');
A(:, 4) = evalmf(x, [90, 120, 180], 'trimf');
A(:, 5) = evalmf(x, [120, 180, 240], 'trimf');
A(:, 6) = evalmf(x, [180, 240, 270], 'trimf');
A(:, 7) = evalmf(x, [240, 270, 300], 'trimf');
A(:, 8) = evalmf(x, [270, 300, 360], 'trimf');
A(:, 9) = evalmf(x, [300, 360, 420], 'trimf');

% Input sets plot
figure(7)
    hold on; box on;
    axis([0 360 0 1.25])
    plot(x, A(:, 1), 'k');
    plot(x, A(:, 2), 'k');
    plot(x, A(:, 3), 'k');
    plot(x, A(:, 4), 'k');
    plot(x, A(:, 5), 'k');
    plot(x, A(:, 6), 'k');
    plot(x, A(:, 7), 'k');
    plot(x, A(:, 8), 'k');
    plot(x, A(:, 9), 'k');    
    text('String', 'A_1', 'Position', [3.6 1.1 0], 'HorizontalAlignment', 'left');
    text('String', 'A_2', 'Position', [60 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_3', 'Position', [90 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_4', 'Position', [120 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_5', 'Position', [180 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_6', 'Position', [240 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_7', 'Position', [270 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_8', 'Position', [300 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_9', 'Position', [356.4 1.1 0], 'HorizontalAlignment', 'right');
    xlabel('$x$', 'Interpreter', 'Latex');
    ylabel('$\mu$', 'Interpreter', 'Latex');
    set(gca, 'Xtick', xtick);
    set(gca, 'XtickLabel', xticklbl);
%     save2tikz

%% Output sets
NL = evalmf(y, [-7.5, -5, -2.5], 'trimf');
NM = evalmf(y, [-5, -2.5, 0], 'trimf');
ZE = evalmf(y, [-2.5, 0, 2.5], 'trimf');
PM = evalmf(y, [0, 2.5, 5], 'trimf');
PL = evalmf(y, [2.5, 5, 7.5], 'trimf');

figure(8);
    hold on;
    axis([-5 5 0 1.25]);
    box on;
    plot(y, NL, 'k');
    plot(y, NM, 'k');
    plot(y, ZE, 'k');
    plot(y, PM, 'k');
    plot(y, PL, 'k');
    text('String', 'NL', 'Position', [-4.84 1.1 0], 'HorizontalAlignment', 'left');
    text('String', 'NM', 'Position', [-2.5 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'ZE', 'Position', [0 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'PM', 'Position', [2.5 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'PL', 'Position', [4.84 1.1 0], 'HorizontalAlignment', 'right');
    xlabel('$y$', 'Interpreter', 'Latex')
    ylabel('$\mu$', 'Interpreter', 'Latex')
    set(gca, 'Xtick', ytick);
    set(gca, 'XtickLabel', yticklbl);
%     save2tikz
    
%% Rulebase
R(:, :, 1) = mamdani(A(:, 1), PL);  % IF (x is A_1) THEN (y is PL)
R(:, :, 2) = mamdani(A(:, 9), PL);  % IF (x is A_9) THEN (y is PL)
R(:, :, 3) = mamdani(A(:, 2), PM);  % IF (x is A_2) THEN (y is PM)
R(:, :, 4) = mamdani(A(:, 8), PM);  % IF (x is A_8) THEN (y is PM)
R(:, :, 5) = mamdani(A(:, 3), ZE);  % IF (x is A_3) THEN (y is ZE)
R(:, :, 6) = mamdani(A(:, 7), ZE);  % IF (x is A_7) THEN (y is ZE)
R(:, :, 7) = mamdani(A(:, 4), NM);  % IF (x is A_4) THEN (y is NM)
R(:, :, 8) = mamdani(A(:, 6), NM);  % IF (x is A_6) THEN (y is NM)
R(:, :, 9) = mamdani(A(:, 5), NL);  % IF (x is A_5) THEN (y is NL)

%% Singleton input (x = 70)
input = x == 70;
firings = eye(size(x, 1));
B = zeros(size(R, 3), size(x, 1));
for j = 1:size(R, 3)
    B(j, :) = maxmin(firings(:, input), R(:, :, j));
end
cosdefuzz(y, B')

% Input plot
figure(9)
    hold on; box on;
    axis([0 360 0 1.25])
    plot(x, A(:, 1), 'k');
    plot(x, A(:, 2), 'k');
    plot(x, A(:, 3), 'k');
    plot(x, A(:, 4), 'k');
    plot(x, A(:, 5), 'k');
    plot(x, A(:, 6), 'k');
    plot(x, A(:, 7), 'k');
    plot(x, A(:, 8), 'k');
    plot(x, A(:, 9), 'k');
    plot([70 70], [0 1], 'k');
    plot(70, 0.3333, 'o', 'MarkerFaceColor', 'k', ...,
        'MarkerEdgeColor', 'k', 'MarkerSize', 2.5);
    plot(70, 0.6667, 'o', 'MarkerFaceColor', 'k', ...,
        'MarkerEdgeColor', 'k', 'MarkerSize', 2.5);
    plot([0, 70], [0.3333, 0.3333], '--k');
    plot([0, 70], [0.6667, 0.6667], '--k');
    text('String', 'DOF_{R_3}', 'Position', [40 0.7667 0], 'HorizontalAlignment', 'center');
    text('String', 'DOF_{R_5}', 'Position', [90 0.4333 0], 'HorizontalAlignment', 'center');
    text('String', 'A_1', 'Position', [3.6 1.1 0], 'HorizontalAlignment', 'left');
    text('String', 'A_2', 'Position', [60 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_3', 'Position', [90 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_4', 'Position', [120 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_5', 'Position', [180 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_6', 'Position', [240 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_7', 'Position', [270 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_8', 'Position', [300 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'A_9', 'Position', [356.4 1.1 0], 'HorizontalAlignment', 'right');
    xlabel('$x$', 'Interpreter', 'Latex');
    ylabel('$\mu$', 'Interpreter', 'Latex');
    set(gca, 'Xtick', xtick);
    set(gca, 'XtickLabel', xticklbl);
%     save2tikz
        
% Output plot
figure(10)
    hold on; box on;
    axis([-5 5 0 1.25]);
    plot(y, B(5, :)', 'k');
    plot(y, B(3, :)', 'k');
    plot(y, NL, 'k');
    plot(y, NM, 'k');
    plot(y, ZE, 'k');
    plot(y, PM, 'k');
    plot(y, PL, 'k');
    plot([-5, -1.6667], [0.3333, 0.3333], '--k');
    plot([-5, 1.6667], [0.6667, 0.6667], '--k');
    text('String', 'DOF_{R_3}', 'Position', [0.75 0.7667 0], 'HorizontalAlignment', 'center');
    text('String', 'DOF_{R_5}', 'Position', [-2.5 0.4333 0], 'HorizontalAlignment', 'center');
    text('String', 'NL', 'Position', [-4.84 1.1 0], 'HorizontalAlignment', 'left');
    text('String', 'NM', 'Position', [-2.5 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'ZE', 'Position', [0 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'PM', 'Position', [2.5 1.1 0], 'HorizontalAlignment', 'center');
    text('String', 'PL', 'Position', [4.84 1.1 0], 'HorizontalAlignment', 'right');
    xlabel('$y$', 'Interpreter', 'Latex')
    ylabel('$\mu$', 'Interpreter', 'Latex')
    set(gca, 'Xtick', -5:2.5:5);
%     save2tikz

%% Fuzzy estimate given by x-y relation
firings = eye(size(x, 1));
output = zeros(size(x,1), 1);
for i = 1:size(x, 1);
    B = zeros(size(R, 3), size(x, 1));
    for j = 1:size(R, 3)
        B(j, :) = maxmin(firings(:, i), R(:, :, j));
    end
    output(i) = cosdefuzz(y, B');
end

mse(5*cos(2*pi*x/360) - output)


figure(11)
    axis tight; box on; hold on;
    plot(x, output, 'k');
    plot(x, 5*cos(2*pi*x/360), '--k');
    l = legend('Fuzzy estimate', 'Real function');
    set(l, 'Interpreter', 'Latex');
    set(gca, 'Xtick', xtick);
    set(gca, 'XtickLabel', xticklbl);
    xlabel('$x$', 'Interpreter', 'Latex')
    ylabel('$y$', 'Interpreter', 'Latex')
%     save2tikz   

figure(12)
    axis tight; box on; hold on;
    plot(x, 5*cos(2*pi*x/360) - output, 'k');
    set(gca, 'Xtick', xtick);
    set(gca, 'XtickLabel', xticklbl);
    xlabel('$x$', 'Interpreter', 'Latex')
    ylabel('$e$', 'Interpreter', 'Latex')
%     save2tikz

%}