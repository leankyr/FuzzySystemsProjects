clc; clear; close all;

%% Initial parameters
%% FIS plots
flc = makeflc_0;
figure;
    hold on; box on;
    plotmf(flc, 'input', 1);
    axis([0 1 0 1.2]);
    xlabel('$d_H, d_V$', 'Interpreter', 'Latex');
%     save2tikz;
figure;
    hold on; box on;
    plotmf(flc, 'input', 3);
    axis([-180 180 0 1.2]);
    xlabel('$\theta$', 'Interpreter', 'Latex');
%     save2tikz;
figure;
    hold on; box on;
    plotmf(flc, 'output', 1);
    axis([-130 130 0 1.2]);
    xlabel('$\Delta \theta$', 'Interpreter', 'Latex');
%     save2tikz;

%% theta_0 = 0
flc = makeflc_0;
[x, y] = simulate_system(9.1, 4.3, 0, flc);
length(x)
x(end)
y(end)
figure;
    hold on; box on;
    axis([0 15 0 8]);
    plot(x, y, 'k');
    plot([10 10 11 11 12 12 15], [0 5 5 6 6 7 7], 'k');
    set(gca, 'Ydir', 'reverse')
    set(gca, 'XAxisLocation', 'Top');
    xlabel('$x$', 'Interpreter', 'Latex');
    ylabel('$y$', 'Interpreter', 'Latex');
%     save2tikz;
    
%% theta_0 = 45
[x, y] = simulate_system(9.1, 4.3, 45, flc);
length(x)
x(end)
y(end)
figure;
    hold on; box on;
    axis([0 15 0 8]);
    plot(x, y, 'k');
    plot([10 10 11 11 12 12 15], [0 5 5 6 6 7 7], 'k');
    set(gca, 'Ydir', 'reverse')
    set(gca, 'XAxisLocation', 'Top');
    xlabel('$x$', 'Interpreter', 'Latex');
    ylabel('$y$', 'Interpreter', 'Latex');
%     save2tikz;
    
%% theta_0 = 90
[x, y] = simulate_system(9.1, 4.3, 90, flc);
length(x)
x(end)
y(end)
figure;
    hold on; box on;
    axis([0 15 0 8]);
    plot(x, y, 'k');
    plot([10 10 11 11 12 12 15], [0 5 5 6 6 7 7], 'k');
    set(gca, 'Ydir', 'reverse')
    set(gca, 'XAxisLocation', 'Top');
    xlabel('$x$', 'Interpreter', 'Latex');
    ylabel('$y$', 'Interpreter', 'Latex');
%     save2tikz;
    

%% Final parameters
%% FIS plots
flc = makeflc_1;
figure;
    hold on; box on;
    plotmf(flc, 'input', 1);
    axis([0 1 0 1.2]);
    xlabel('$d_H, d_V$', 'Interpreter', 'Latex');
%     save2tikz;
figure;
    hold on; box on;
    plotmf(flc, 'input', 3);
    axis([-180 180 0 1.2]);
    xlabel('$\theta$', 'Interpreter', 'Latex');
%     save2tikz;
figure;
    hold on; box on;
    plotmf(flc, 'output', 1);
    axis([-130 130 0 1.2]);
    xlabel('$\Delta \theta$', 'Interpreter', 'Latex');
%     save2tikz;

%% theta_0 = 0
flc = makeflc_1;
[x, y] = simulate_system(9.1, 4.3, 0, flc);
length(x)
x(end)
y(end)
figure;
    hold on; box on;
    axis([0 15 0 8]);
    plot(x, y, 'k');
    plot([10 10 11 11 12 12 15], [0 5 5 6 6 7 7], 'k');
    set(gca, 'Ydir', 'reverse')
    set(gca, 'XAxisLocation', 'Top');
    xlabel('$x$', 'Interpreter', 'Latex');
    ylabel('$y$', 'Interpreter', 'Latex');
%     save2tikz;    
    
%% theta_0 = 45
[x, y] = simulate_system(9.1, 4.3, 45, flc);
length(x)
x(end)
y(end)
figure;
    hold on; box on;
    axis([0 15 0 8]);
    plot(x, y, 'k');
    plot([10 10 11 11 12 12 15], [0 5 5 6 6 7 7], 'k');
    set(gca, 'Ydir', 'reverse')
    set(gca, 'XAxisLocation', 'Top');
    xlabel('$x$', 'Interpreter', 'Latex');
    ylabel('$y$', 'Interpreter', 'Latex');
%     save2tikz;    
    
%% theta_0 = 90
[x, y] = simulate_system(9.1, 4.3, 90, flc);
length(x)
x(end)
y(end)
figure;
    hold on; box on;
    axis([0 15 0 8]);
    plot(x, y, 'k');
    plot([10 10 11 11 12 12 15], [0 5 5 6 6 7 7], 'k');
    set(gca, 'Ydir', 'reverse')
    set(gca, 'XAxisLocation', 'Top');
    xlabel('$x$', 'Interpreter', 'Latex');
    ylabel('$y$', 'Interpreter', 'Latex');
%     save2tikz;
