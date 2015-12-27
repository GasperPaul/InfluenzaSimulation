% state:
%  (1) - S
%  (2) - I
%  (3) - G
%  (4) - IG
%  (5) - R_I
%  (6) - R_G
%  (7) - R_IG
% params:
%  (1)  - beta_I
%  (2)  - beta_G
%  (3)  - beta_IG
%  (4)  - gamma_I
%  (5)  - gamma_G
%  (6)  - gamma_IG
%  (7)  - omega_I
%  (8)  - omega_G
%  (9)  - omega_IG
%  (10) - delta_I
%  (11) - delta_G
%  (12) - X

% start_params =  [0.15 0.15 0.05 0.2 0.2 0.2 10/365 10/365 10/365 0.8]; 
% start_state = [0.95 0.025 0 0 0.025 0 0];
% delta_t = 1;
% accumulation_period = 30;
% period = 360;

function [params_opt, value] = fit_parameters_optimal( ...
    start_state, ...
    delta_t, ...
    accumulation_period, ...
    period, ...
    start_params ...
    )

    persistent I_real;
    if isempty(I_real) 
        I_real = dlmread('I.txt');
    end
    
    start_params = struct2array(start_params);
    
    lb = zeros(size(start_params));
    ub = ones(size(start_params));
    % nonlcon = @(x) constraints(start_state, x, delta_t, accumulation_period, period);
    options = optimset('MaxFunEvals', 100000, 'MaxIter', 10000);
    
    f = @(x)error_function(I_real, start_state, delta_t, accumulation_period, period, x);
    [params_opt, value] = fmincon(f, start_params,[],[],[],[],lb,ub,[],options);
    
    params_opt = params2struct(params_opt);
    
    %[state, I, G] = simulate_and_get_influx_with_stabilization(start_state, params_opt, delta_t, accumulation_period, period, stab_period);
    %[state, I_influx] = simulate_and_get_influx(start_state, params_opt, delta_t, accumulation_period, period);
    %[state, I] = simulate_single_step(start_state, params_opt, delta_t);
end

function diff = error_function(I_real, start_state, delta_t, accumulation_period, period, params)
    
    params = params2struct(params);

    [~, I] = simulate_and_get_influx(start_state, params, delta_t, accumulation_period, period);
    %[state, I] = simulate_and_get_influx_with_stabilization(start_state, params, delta_t, accumulation_period, period, stab_period);
    
    diff = sum(abs(I_real - I));
end

function params_struct = params2struct(params)
    params_struct.beta = params(1);
    params_struct.gamma = params(2);
    params_struct.omega = params(3);
end

function [c,ceq] = constraints(start_state, params, delta_t, accumulation_period, period)
    c = [];
    state = simulate_and_get_influx(start_state, params, delta_t, accumulation_period, period);
    ceq = abs(1 - (state.R + state.S + state.I));
end