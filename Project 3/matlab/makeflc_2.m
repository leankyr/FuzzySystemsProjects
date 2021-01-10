function [flc] = makeflc_1()
%MAKEFLC Constructor for the FLCPI FIS
    %% General 
    flc = newfis('FLC');
    flc = addvar(flc, 'input', 'dH', [0 1]);
    flc = addvar(flc, 'input', 'dV', [0 1]);
    flc = addvar(flc, 'input', 'theta', [-180 180]);
    flc = addvar(flc, 'output', 'dtheta', [-130 130]);

    %% Fuzzy sets for input dV
    flc = addmf(flc, 'input', 1, 'S', 'trimf', [-0.5 0 0.15]);
    flc = addmf(flc, 'input', 1, 'M', 'trimf', [0 0.15 1]);
    flc = addmf(flc, 'input', 1, 'L', 'trimf', [0.15 1 1.5]);

    %% Fuzzy sets for input dH
    flc = addmf(flc, 'input', 2, 'S', 'trimf', [-0.5 0 0.15]);
    flc = addmf(flc, 'input', 2, 'M', 'trimf', [0 0.15 1]);
    flc = addmf(flc, 'input', 2, 'L', 'trimf', [0.15 1 1.5]);

    %% Fuzzy sets for input theta
    flc = addmf(flc, 'input', 3, 'N', 'trimf', [-180 -180 0]);
    flc = addmf(flc, 'input', 3, 'ZE', 'trimf', [-180 0 180]);
    flc = addmf(flc, 'input', 3, 'P', 'trimf', [0 180 180]);
   
    %% Fuzzy sets for output dtheta
    flc = addmf(flc, 'output', 1, 'N', 'trimf', [-130 -130 -0]);
    flc = addmf(flc, 'output', 1, 'ZE', 'trimf', [-90 0 90]);
    flc = addmf(flc, 'output', 1, 'P', 'trimf', [0 130 130]);


    %% Rulebase
    % [dH dV theta dtheta 1 1]
    rulebase = [1 1 1 2 1 1;
                1 1 2 1 1 1;
                1 1 3 1 1 1;
                1 2 1 2 1 1;
                1 2 2 1 1 1;
                1 2 3 1 1 1;
                1 3 1 2 1 1;
                1 3 2 1 1 1;
                1 3 3 3 1 1;
                2 1 1 3 1 1;
                2 1 2 2 1 1;
                2 1 3 1 1 1;
                2 2 1 3 1 1;
                2 2 2 2 1 1;
                2 2 3 1 1 1;
                2 3 1 3 1 1;
                2 3 2 2 1 1;
                2 3 3 1 1 1;
                3 1 1 3 1 1;
                3 1 2 2 1 1;
                3 1 3 1 1 1;
                3 2 1 3 1 1;
                3 2 2 2 1 1;
                3 2 3 1 1 1;
                3 3 1 3 1 1;
                3 3 2 2 1 1;
                3 3 3 1 1 1];
                        
    flc = addrule(flc, rulebase);

    %% Write to file as an alternative
%      writefis(flc, 'flcpi');
end

