function f = sim_muscleLegs(params, varargin)
warning off;

% --- 1. PARSE INPUTS ---
% Default values
w_act = 1;
w_v = 0;
v_tgt = 1;
flag_anim = 0;
t_end = 10;
mdl = 'muscleLegs';

% Check if varargin has arguments passed from cmaes/user
if ~isempty(varargin) && ~isempty(varargin{1})
    innerArgs = varargin{1};
    % Unpack Weights [w_act, w_v, v_tgt]
    if numel(innerArgs) >= 1 && ~isempty(innerArgs{1})
        weights = innerArgs{1};
        w_act = weights(1);
        w_v   = weights(2);
        v_tgt = weights(3);
    end
    % Unpack Animation Flag
    if numel(innerArgs) >= 2 && ~isempty(innerArgs{2})
        flag_anim = innerArgs{2};
    end
    % Unpack Time Duration
    if numel(innerArgs) >= 3 && ~isempty(innerArgs{3})
        t_end = innerArgs{3};
    end
end

% --- 2. SETUP SIMULATION ---
% Define parameters, initial conditions, time settings
setup_muscleLegs_model;
setup_muscleLegs_ic;
setup_muscleLegs_ctrl;

% --- 3. RUN SIMULATION ---
try
    simout = sim(mdl, 'SrcWorkspace', 'current', ...
        'SimMechanicsOpenEditorOnUpdate', flag_anim);
catch err_sim
    disp(['Simulation failed: ', err_sim.message]);
    f = NaN;
    return;
end

% --- 4. EXTRACT RESULTS ---
% Get simulation end time and final distance
try
    t_end_sim = simout.t_end_sim.Data(end);
    x_end = simout.x_end.Data(end);
catch
    f = NaN; return; % Fail safe if data missing
end

% --- 5. CALCULATE COST FUNCTION ---
% Check if the robot fell early (didn't reach target time)
if t_end_sim < t_end - 0.1 % Allow small tolerance
    % Penalty for falling: Large number + remaining time
    f = 1e6 + (t_end - t_end_sim);
else
    % Robot walked the full duration. Calculate performance cost.
    
    % A. Calculate Muscle Effort (E_m)
    % Try to get the true Muscle Activation Energy (int_Am2) from Simulink
    try
        if isa(simout.int_Am2, 'timeseries')
            E_m = simout.int_Am2.Data(end);
        else
            E_m = simout.int_Am2(end);
        end
    catch
        % Fallback: If int_Am2 block is missing, warn and use 0 or torque proxy
        % (Uncomment torque lines below if you revert to torque-based cost)
        % tau_sum = simout.int_tau_H_L_2.Data(end) + simout.int_tau_K_L_2.Data(end) + ...
        %           simout.int_tau_H_R_2.Data(end) + simout.int_tau_K_R_2.Data(end);
        % E_m = tau_sum; 
        warning('int_Am2 not found in simulation output. Using 0 for effort cost.');
        E_m = 0; 
    end

    % B. Calculate Velocity Cost
    v_avg = x_end / t_end_sim;
    
    % C. Final Cost Formula: f = w_e * (Em / x_end) + w_v * (v_tgt - v)^2
    % (Note: x_end is distance, used to normalize effort per meter)
    if x_end > 0.1
        f = w_act * (E_m / x_end) + w_v * (v_tgt - v_avg)^2;
    else
        f = 1e5; % Penalty if it stood still and didn't move
    end
end
end