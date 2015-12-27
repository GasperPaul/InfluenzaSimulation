% state:
%  (1) - S            --- S // f(a,t)
%  (2) - I            --- I // f(a,t)
%  (3) - G           
%  (4) - IG
%  (5) - R_I          --- R // f(a,t)
%  (6) - R_G
%  (7) - R_IG
% params:
%  (1)  - beta_I      --- beta // f(a)
%  (2)  - beta_G
%  (3)  - beta_IG
%  (4)  - gamma_I     --- gamma // const
%  (5)  - gamma_G
%  (6)  - gamma_IG
%  (7)  - omega_I     --- omega // f(a)
%  (8)  - omega_G
%  (9)  - omega_IG
%  (10) - X

% example:
% simulate_process([0.95 0.025 0 0 0.025 0 0], [0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.1], 1, 365)


function [ state ] = simulate_process(...
    start_state, ... % start state
    params,      ... % params: see above
    delta_t,     ... % time step for simutation
    period       ... % simulation time
    )
   
    current_state = start_state;
    t = 0;
    while(t < period)
        current_state = simulate_single_step(current_state, params, delta_t);
        t = t + delta_t;
    end
    state = current_state;
end



