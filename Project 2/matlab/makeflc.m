function [fis] = makeflc()
%MAKEFLC Constructor for the FLCPI FIS
%{    
%% General 
    flc = newfis('FLC-PI');
    flc = addvar(flc, 'input', 'E', [-1 1]);
    flc = addvar(flc, 'input', 'dE', [-1 1]);
    flc = addvar(flc, 'output', 'dU', [-1 1]);

    %% Fuzzy sets for input E
    flc = addmf(flc, 'input', 1, 'NV', 'trimf', [-1.25 -1.00 -0.75]);
    flc = addmf(flc, 'input', 1, 'NL', 'trimf', [-1.00 -0.75 -0.50]);
    flc = addmf(flc, 'input', 1, 'NM', 'trimf', [-0.75 -0.50 -0.25]);
    flc = addmf(flc, 'input', 1, 'NS', 'trimf', [-0.50 -0.25 0.00]);
    flc = addmf(flc, 'input', 1, 'ZR', 'trimf', [-0.25 0.00 0.25]);
    flc = addmf(flc, 'input', 1, 'PS', 'trimf', [0.00 0.25 0.50]);
    flc = addmf(flc, 'input', 1, 'PM', 'trimf', [0.25 0.50 0.75]);
    flc = addmf(flc, 'input', 1, 'PL', 'trimf', [0.50 0.75 1.00]);
    flc = addmf(flc, 'input', 1, 'PV', 'trimf', [0.75 1.00 1.25]);

    %% Fuzzy sets for input dE
    flc = addmf(flc, 'input', 2, 'NV', 'trimf', [-1.25 -1.00 -0.75]);
    flc = addmf(flc, 'input', 2, 'NL', 'trimf', [-1.00 -0.75 -0.50]);
    flc = addmf(flc, 'input', 2, 'NM', 'trimf', [-0.75 -0.50 -0.25]);
    flc = addmf(flc, 'input', 2, 'NS', 'trimf', [-0.50 -0.25 0.00]);
    flc = addmf(flc, 'input', 2, 'ZR', 'trimf', [-0.25 0.00 0.25]);
    flc = addmf(flc, 'input', 2, 'PS', 'trimf', [0.00 0.25 0.50]);
    flc = addmf(flc, 'input', 2, 'PM', 'trimf', [0.25 0.50 0.75]);
    flc = addmf(flc, 'input', 2, 'PL', 'trimf', [0.50 0.75 1.00]);
    flc = addmf(flc, 'input', 2, 'PV', 'trimf', [0.75 1.00 1.25]);

    %% Fuzzy sets for output dU
    flc = addmf(flc, 'output', 1, 'NV', 'trimf', [-1.25 -1.00 -0.75]);
    flc = addmf(flc, 'output', 1, 'NL', 'trimf', [-1.00 -0.75 -0.50]);
    flc = addmf(flc, 'output', 1, 'NM', 'trimf', [-0.75 -0.50 -0.25]);
    flc = addmf(flc, 'output', 1, 'NS', 'trimf', [-0.50 -0.25 0.00]);
    flc = addmf(flc, 'output', 1, 'ZR', 'trimf', [-0.25 0.00 0.25]);
    flc = addmf(flc, 'output', 1, 'PS', 'trimf', [0.00 0.25 0.50]);
    flc = addmf(flc, 'output', 1, 'PM', 'trimf', [0.25 0.50 0.75]);
    flc = addmf(flc, 'output', 1, 'PL', 'trimf', [0.50 0.75 1.00]);
    flc = addmf(flc, 'output', 1, 'PV', 'trimf', [0.75 1.00 1.25]);

    %% Rulebase
    rulebase = zeros(81, 5);
    for i=1:9
        for j=1:9
            rulebase((i-1)*9 + j, :) = [i, j, max(1, min(i + j - 5, 9)), 1, 1];
        end
    end
    flc = addrule(flc, rulebase);
    
    %% Set custom defuzzifier (COS)
    % Unecessary, defuzzifying is handled externally
%     flc = setfis(flc, 'defuzzMethod', 'cosdefuzz');
    
    %% Write to file as an alternative
%      writefis(flc, 'flcpi');
%}

fis = newfis('FLC-PI','mamdani','min','max','min','max','centroid');
%   fis = newfis('FLC-PI','mamdani');
%% Input Vars
fis = addvar(fis,'input','Error',[-1 1]);
fis = addvar(fis,'input','dot_Error',[-1 1]);

%% Output Vars
fis = addvar(fis,'output','dot_U',[-1 1]);

%% Membership Functions for Error Input (1)

fis = addmf(fis,'input',1,'NL','trimf',[-1.3333, -1, -0.6666]);
fis = addmf(fis,'input',1,'NM','trimf',[-1, -0.6666, -0.3333]);
fis = addmf(fis,'input',1,'NS','trimf',[-0.6666, -0.3333, 0]);
fis = addmf(fis,'input',1,'ZR','trimf',[-0.3333, 0, 0.3333]);
fis = addmf(fis,'input',1,'PS','trimf',[0, 0.3333, 0.6666]);
fis = addmf(fis,'input',1,'PM','trimf',[0.3333, 0.6666, 1]);
fis = addmf(fis,'input',1,'PL','trimf',[0.6666, 1, 1.3333]);
%}
%% Membership Functions for dot_Error Input (2)
fis = addmf(fis,'input',2,'NL','trimf',[-1.3333, -1, -0.6666]);
fis = addmf(fis,'input',2,'NM','trimf',[-1, -0.6666, -0.3333]);
fis = addmf(fis,'input',2,'NS','trimf',[-0.6666, -0.3333, 0]);
fis = addmf(fis,'input',2,'ZR','trimf',[-0.3333, 0, 0.3333]);
fis = addmf(fis,'input',2,'PS','trimf',[0, 0.3333, 0.6666]);
fis = addmf(fis,'input',2,'PM','trimf',[0.3333, 0.6666, 1]);
fis = addmf(fis,'input',2,'PL','trimf',[0.6666, 1, 1.3333]);


%% Membership Functions for dot_U Output 

fis = addmf(fis,'output',1,'NV','trimf',[-1.25, -1, -0.75]);
fis = addmf(fis,'output',1,'NL','trimf',[-1, -0.75, -0.5]);
fis = addmf(fis,'output',1,'NM','trimf',[-0.75, -0.5, -0.25]);
fis = addmf(fis,'output',1,'NS','trimf',[-0.5, -0.25, 0]);
fis = addmf(fis,'output',1,'ZR','trimf',[-0.25, 0, 0.25]);
fis = addmf(fis,'output',1,'PS','trimf',[0, 0.25, 0.5]);
fis = addmf(fis,'output',1,'PM','trimf',[0.25, 0.5, 0.75]);
fis = addmf(fis,'output',1,'PL','trimf',[0.5, 0.75, 1]);
fis = addmf(fis,'output',1,'PV','trimf',[0.75, 1, 1.25]);

%% Rule Base


% Error == NL
Rules_E_NL = [1 1 1 1 1;1 2 1 1 1;1 3 1 1 1;1 4 2 1 1;1 5 3 1 1;1 6 4 1 1;1 7 5 1 1];
% Error == NM
Rules_E_NM = [2 1 1 1 1;2 2 1 1 1;2 3 2 1 1;2 4 3 1 1;2 5 4 1 1;2 6 5 1 1;2 7 6 1 1];
% Error == NS
Rules_E_NS = [3 1 1 1 1;3 2 2 1 1;3 3 3 1 1;3 4 4 1 1;3 5 5 1 1;3 6 6 1 1;3 7 7 1 1];
% Error == ZR 
Rules_E_ZR = [4 1 2 1 1;4 2 3 1 1;4 3 4 1 1;4 4 5 1 1;4 5 6 1 1;4 6 7 1 1;4 7 8 1 1];
% Error == PS
Rules_E_PS = [5 1 3 1 1;5 2 4 1 1;5 3 5 1 1;5 4 6 1 1;5 5 7 1 1;5 6 8 1 1;5 7 9 1 1];
% Error == PM
Rules_E_PM = [6 1 4 1 1;6 2 5 1 1;6 3 6 1 1;6 4 7 1 1;6 5 8 1 1;6 6 9 1 1;6 7 9 1 1];
% Error == PL
Rules_E_PL = [7 1 5 1 1;7 2 6 1 1;7 3 7 1 1;7 4 8 1 1;7 5 9 1 1;7 6 9 1 1;7 7 9 1 1];

% ruleList

ruleList = [Rules_E_NL;Rules_E_NM;Rules_E_NS;Rules_E_ZR;Rules_E_PS;Rules_E_PM;Rules_E_PL;];

fis=addrule(fis,ruleList);
%}

end

