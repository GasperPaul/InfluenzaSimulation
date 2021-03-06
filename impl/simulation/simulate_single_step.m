function [state, I_influx, G_influx] = simulate_single_step(...
    current_state, ...
    params, ...
    delta_t...
    )

    state = current_state;

    state(1) = current_state(1) + delta_t * (0 ...
        + params(7) * current_state(5) ...
        + params(8) * current_state(6) ...
        + params(9) * current_state(7) ...
        - current_state(1) * params(1) * current_state(2) * params(10) ...
        - current_state(1) * params(3) * current_state(2) * current_state(3) * current_state(4) ...
        - current_state(1) * params(2) * current_state(3) ...
        - current_state(1) * params(1) * current_state(2) * (1 - params(10)) ...
        - current_state(1) * params(11) * params(12) ...
        );

    state(2) = current_state(2) + delta_t * (0 ...
        + current_state(1) * params(1) * current_state(2) * params(10) ...
        - current_state(2) * params(4) ...
        );

    I_influx = delta_t * (current_state(1) * params(1) * current_state(2) * params(10));


    state(3) = current_state(3) + delta_t * (0 ...
        + current_state(1) * params(2) * current_state(3) ...
        + current_state(1) * params(1) * current_state(2) * (1 - params(10)) ...
        - current_state(3) * params(5) ...
        );

    G_influx = delta_t * current_state(1) * params(2) * current_state(3) ...
        + current_state(1) * params(1) * current_state(2) * (1 - params(10));

    state(4) = current_state(4) + delta_t * (0 ...
        + current_state(1) * params(3) * current_state(2) * current_state(3) * current_state(4) ... 
        - current_state(4) * params(6) ...
        );

    state(5) = current_state(5) + delta_t * (0 ...
        + current_state(2) * params(5) ...
        + current_state(7) * params(8) ...
        - current_state(5) * params(7) ...
        + current_state(1) * params(11) * params(12) ...
        );

    state(6) = current_state(6) + delta_t * (0 ...
        + current_state(3) * params(5) ...
        + current_state(7) * params(7) ...
        - current_state(6) * params(8) ...
        );

    state(7) = current_state(7) + delta_t * (0 ...
        + current_state(4) * params(6) ...
        - current_state(7) * params(8) ...
        - current_state(7) * params(7) ...
        - current_state(7) * params(9) ...
        );

end