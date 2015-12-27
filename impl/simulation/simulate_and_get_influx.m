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
%  (10) - X
%  (11) - kappa
%  (12) - eff.

% example:
% simulate_and_get_influx([0.95 0.025 0 0 0.025 0 0], [0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.1], 1, 30, 360)


function [state, I] = simulate_and_get_influx(...
    start_state, ... % start state
    params,      ... % params: see above
    delta_t,     ... % time step for simutation
    accumulation_period, ...
    period       ... % simulation time
    )
    
    I = [];
    
    current_state = start_state;
    t = 0;
    current_period = 0;
    current_i_influx = 0;
    while(t < period)
        [current_state, i_influx] = ...
            simulate_single_step(current_state, params, delta_t);
        current_i_influx = current_i_influx + i_influx;

        current_period = current_period + delta_t;
        
        if (current_period >= accumulation_period)
            I = [I current_i_influx];
            current_i_influx = 0;
            current_period = 0;
        end

        t = t + delta_t;
    end
    state = current_state;
end



