clc; clear; close all;

Gp = tf(18.69, [1 12.064]);
Gc = tf(1.75*[1 5], [1 0]);  %% Kp = 1.75 Ki = 22.75  Ki/Kp = 13!!!
Gol = Gc*Gp;   %open loop system
Gcl = feedback(Gol, 1, -1); % closed loop system

time_vec = 0:0.01:10;
data_vec = 150*ones(1, 1001);
r = timeseries(data_vec, time_vec); %reference signal


figure(1);
    rlocus(Gol);
    %save2tikz;

figure(2);
    hold on; box on; axis([0 10 0 160]);
    y = lsim(Gcl, data_vec, time_vec);
    info = stepinfo(y, time_vec);
    ts = info.RiseTime;
    disp(['Rise time (LPI): ' num2str(info.RiseTime) 's']);
    disp(['Overshoot (LPI): ' num2str(info.Overshoot) '%']);
    plot(r, ':k');
    plot([ts ts], [0 40.2], '--k');
    plot([0 ts], [40.2 40.2], '--k');
    plot(time_vec, y, 'k');
    title('');
    ylabel('Amplitude');
%     save2tikz;

global flc;
flc = makeflc;

figure(3);
    hold on; box on;
    plotmf(flc, 'input', 1)
    axis([-1 1 0 1.2]);
    xlabel('Fuzzy Variable');
%     save2tikz;

%% FLC PI Mk 0
sim('FLCPI_0')
figure(4);
    hold on; box on; axis([0 10 0 160]);
    plot(y, 'k');
   info = stepinfo(y.Data, y.Time);
    disp(['Rise time (FLC-PI Mk0): ' num2str(info.RiseTime) 's']);
    disp(['Overshoot (FLC-PI Mk0): ' num2str(info.Overshoot) '%']);
    y = lsim(Gcl, data_vec, time_vec);
    plot(time_vec, y, '--k');
    plot(r, ':k');
    title('');
    ylabel('Amplitude');
    xlabel('Time (seconds)');
    legend('FLC-PI', 'Linear PI', 'Location', 'SouthEast');
%     save2tikz;

%% FLC PI Mk 1
sim('FLCPI_1')
figure(5);
    hold on; box on; axis([0 10 0 160]);
    plot(y, 'k');
    info = stepinfo(y.Data, y.Time);
    disp(['Rise time (FLC-PI Mk1): ' num2str(info.RiseTime) 's']);
    disp(['Overshoot (FLC-PI Mk1): ' num2str(info.Overshoot) '%']);
    y = lsim(Gcl, data_vec, time_vec);
    plot(time_vec, y, '--k');
    plot(r, ':k');
    title('');
    ylabel('Amplitude');
    xlabel('Time (seconds)');
    legend('FLC-PI', 'Linear PI', 'Location', 'SouthEast');
%     save2tikz;

%% FLC PI Mk 2
sim('FLCPI_2')
figure(6);
    hold on; box on; axis([0 10 0 160]);
    plot(y, 'k');
    info = stepinfo(y.Data, y.Time);
    disp(['Rise time (FLC-PI Mk2): ' num2str(info.RiseTime) 's']);
    disp(['Overshoot (FLC-PI Mk2): ' num2str(info.Overshoot) '%']);
    y = lsim(Gcl, data_vec, time_vec);
    plot(time_vec, y, '--k');
    plot(r, ':k');
    title('');
    ylabel('Amplitude');
    xlabel('Time (seconds)');
    legend('FLC-PI', 'Linear PI', 'Location', 'SouthEast');
%     save2tikz;

%% FLC PI Mk 3
sim('FLCPI_3')
figure(7);
    hold on; box on; axis([0 10 0 160]);
    plot(y, 'k');
    info = stepinfo(y.Data, y.Time);
    disp(['Rise time (FLC-PI Mk3): ' num2str(info.RiseTime) 's']);
    disp(['Overshoot (FLC-PI Mk3): ' num2str(info.Overshoot) '%']);
    y = lsim(Gcl, data_vec, time_vec);
    plot(time_vec, y, '--k');
    plot(r, ':k');
    title('');
    ylabel('Amplitude');
    xlabel('Time (seconds)');
    legend('FLC-PI', 'Linear PI', 'Location', 'SouthEast');
%     save2tikz;
%}

%% Rule firings
figure(8);
    hold on; box on;
    plotmf(flc, 'input', 1)
    axis([-1 1 0 1.2]);
    plot([-0.5 -0.5], [0, 1.2], '--k');
    xlabel('$E$', 'Interpreter', 'Latex');
%     save2tikz;

figure(9);
    hold on; box on;
    plotmf(flc, 'input', 1)
    axis([-1 1 0 1.2]);
    plot([0 0], [0, 1.2], '--k');
    xlabel('$\dot{U}$', 'Interpreter', 'Latex');
%     save2tikz;

figure(10);
    hold on; box on;
    plotmf(flc, 'input', 1)
    axis([-1 1 0 1.2]);
    plot([-0.5 -0.5], [0, 1.2], '--k');
    xlabel('$\dot{U}$', 'Interpreter', 'Latex');
%     save2tikz;




%% Input tests
time_vec = 0:0.01:30;
data_vec = [150*ones(1, 1000) 100*ones(1, 1000), 150*ones(1, 1001)];
r = timeseries(data_vec, time_vec);
sim('FLCPI_3');
figure(13);
    hold on; box on; axis([0 30 0 160]);
    plot(y, 'k');
    y = lsim(Gcl, data_vec, time_vec);
    plot(time_vec, y, '--k');
    legend('FLC-PI', 'Linear PI');
    plot(r, ':k');
    title('');
    ylabel('Amplitude');
    xlabel('Time (seconds)');
%     save2tikz;

time_vec = 0:0.01:30;
data_vec = [0.15*(0:1000), 150*ones(1, 1000), 0.15*(1000:-1:1)];
r = timeseries(data_vec, time_vec);
sim('FLCPI_3');
figure(14);
    hold on; box on; axis([0 30 0 160]);
    plot(y, 'k');
    y = lsim(Gcl, data_vec, time_vec);
    plot(time_vec, y, '--k');
    legend('FLC-PI', 'Linear PI');
    plot(r, ':k');
    title('');
    ylabel('Amplitude');
    xlabel('Time (seconds)');
%     save2tikz;
%}
time_vec = 0:0.01:30;
data_vec = 150*ones(1,3001);
r = timeseries(data_vec, time_vec);
tl_vec = [0*(1:1000), 1*ones(1,1000),0*(2001:3001) ];
TL = timeseries(tl_vec, time_vec);
sim('FLCPI_4');
figure(15);
    hold on; % box on; axis([0 30 0 160]);
    plot(y, 'k');
    y = lsim(Gcl, data_vec, time_vec);
    plot(time_vec, y, '--k');
    legend('FLC-PI', 'Linear PI');
    plot(r, ':k');
    title('');
    ylabel('Amplitude');
    xlabel('Time (seconds)');
%     save2tikz;


