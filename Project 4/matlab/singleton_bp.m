function [fis] = singleton_bp()
%SINGLETON_BP Training of a singleton TSK model using back-propagation
    
    %% Initialization
    % Seed the RNG in order to have replicable results
    rng(1) 
    load mg22.dat
    x = mg22(:, 2);
    
    % Create the training, validation and checking sets
    t_trn = 501:1000;
    t_val = 1001:1300;
    t_chk = 1301:1800;
    D_trn = [x(t_trn-12) x(t_trn-6) x(t_trn) x(t_trn+6)];
    D_val = [x(t_val-12) x(t_val-6) x(t_val) x(t_val+6)];
    D_chk = [x(t_chk-12) x(t_chk-6) x(t_chk) x(t_chk+6)];

    % Initialize the FIS using grid partioning
    fis = genfis1(D_trn, 2, 'gbellmf', 'constant');
    
    for i = 1:3
        fis.input(i).name = ['x_' num2str(i)];
        for j= 1:2
            fis.input(i).mf(j).name = ['A_' num2str(i) '^' num2str(j)];
        end
    end
    
    % Initialize the consequents as random constants
    for i = 1:8
        fis.output.mf(i).name = ['w_' num2str(i)];
        fis.output.mf(i).params = rand;
    end

    %% Training
    [~, error_trn, ~, fis, error_val] = ...
        anfis(D_trn, fis, 1000, [0 0 0 0], D_val, 0);

    %% Evaluation
    % Output sets
    O_trn = evalfis(D_trn(:, 1:3), fis);
    O_val = evalfis(D_val(:, 1:3), fis);
    O_chk = evalfis(D_chk(:, 1:3), fis);
    
    % Error sets
    E_trn = D_trn(:, 4) - O_trn;
    E_val = D_val(:, 4) - O_val;
    E_chk = D_chk(:, 4) - O_chk;
    
    %% Plots
    figure;
    box on; hold on; axis tight;
    plot(507:1806, x(507:1806));
    plot(507:1806, [O_trn' O_val' O_chk']);
    plot([1001 1001], [0 1.5], 'r');
    plot([1301 1301], [0 1.5], 'r');
    ylabel('$x(t)$', 'Interpreter', 'Latex');
    xlabel('Time (seconds)');
    legend('Original', 'Prediction');
%     save2tikz
    
    figure;
    box on; hold on; axis tight;
    plot(507:1806, [E_trn' E_val' E_chk']);
    plot([1001 1001], [-0.4 0.4], 'r');
    plot([1301 1301], [-0.4 0.4], 'r');
    ylabel('$e(t)$', 'Interpreter', 'Latex');
    xlabel('Time (seconds)');
%     save2tikz
    
    figure;
    box on; hold on;
    plot(error_trn);
    plot(error_val);
    ylabel('RMSE');
    xlabel('Epochs');
    legend('Training curve', 'Validation curve');
%     save2tikz
    
    figure;
    box on; hold on;
    plotmf(fis, 'input', 1);
    xlabel('$x_1$', 'Interpreter', 'Latex');
%     save2tikz
    
    figure;
    box on; hold on;
    plotmf(fis, 'input', 2);
    xlabel('$x_2$', 'Interpreter', 'Latex');
%     save2tikz
    
    figure;
    box on; hold on;
    plotmf(fis, 'input', 3);
    xlabel('$x_3$', 'Interpreter', 'Latex');
%     save2tikz
    
    %% Error metrics
    MSE_trn = mse(E_trn);
    MSE_val = mse(E_val);
    MSE_chk = mse(E_chk);
    
    sigmay_trn = sum(((D_trn(:,4) - mean(D_trn(:,4))).^2))/500;
    sigmay_val = sum(((D_val(:,4) - mean(D_val(:,4))).^2))/300;
    sigmay_chk = sum(((D_chk(:,4) - mean(D_chk(:,4))).^2))/500;

    RMSE_trn = sqrt(MSE_trn);
    RMSE_val = sqrt(MSE_val);
    RMSE_chk = sqrt(MSE_chk);
    
    NMSE_trn = MSE_trn/sigmay_trn;
    NMSE_val = MSE_val/sigmay_val;
    NMSE_chk = MSE_chk/sigmay_chk;
    
    NDEI_trn = sqrt(NMSE_trn);
    NDEI_val = sqrt(NMSE_val);
    NDEI_chk = sqrt(NMSE_chk);
    
    disp('Singleton TSK (BP)')
    disp(['  RMSE_trn: ' num2str(RMSE_trn)])
    disp(['  RMSE_val: ' num2str(RMSE_val)])
    disp(['  RMSE_chk: ' num2str(RMSE_chk)])
    disp(['  NMSE_trn: ' num2str(NMSE_trn)])
    disp(['  NMSE_val: ' num2str(NMSE_val)])
    disp(['  NMSE_chk: ' num2str(NMSE_chk)])
    disp(['  NDEI_trn: ' num2str(NDEI_trn)])
    disp(['  NDEI_val: ' num2str(NDEI_val)])
    disp(['  NDEI_chk: ' num2str(NDEI_chk)])
end
