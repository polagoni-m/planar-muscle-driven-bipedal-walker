function f = sim_muscleLegs_Task2(optim_vals, varargin)
warning off;

% --- 1. PARSE INPUTS ---
w_act = 1; w_v = 0; v_tgt = 1; flag_anim = 0; 
t_end = 5; % Default optimization time

mdl = 'muscleLegs_task2'; 

if ~isempty(varargin) && ~isempty(varargin{1})
    innerArgs = varargin{1};
    if numel(innerArgs) >= 1 && ~isempty(innerArgs{1}), weights = innerArgs{1}; w_act = weights(1); w_v = weights(2); v_tgt = weights(3); end
    if numel(innerArgs) >= 2 && ~isempty(innerArgs{2}), flag_anim = innerArgs{2}; end
    if numel(innerArgs) >= 3 && ~isempty(innerArgs{3}), t_end = innerArgs{3}; end
end

% --- 2. SETUP SIMULATION ---
setup_muscleLegs_model;
setup_muscleLegs_ic;

% ---------------------------------------------------------
% CRITICAL STEP: INJECT OPTIMIZATION PARAMETERS
% ---------------------------------------------------------

% A. Handle Leg Parameters (1-12)
params = optim_vals(1:12); 
setup_muscleLegs_ctrl; 

% B. Overwrite Trunk Parameters (13-17)

% --- FIX FOR THETA_TGT = 0 ---
% Instead of multiplying by 0 (which kills the optimization),
% we use an OFFSET.
% If optim_vals(13) = 1 (Initial Guess), theta_tgt = 0.
% Scaling factor 0.1 means +/- 10% change in parameter = +/- 0.01 rad lean.
theta_tgt = 0 + (optim_vals(13) - 1) * 0.1;

% For Gains, we use standard multiplication because base values are non-zero.
base_G_theta_GLU  = 60.0; 
base_G_dtheta_GLU = 5.0; 
base_G_theta_HFL  = 30.0; 
base_G_dtheta_HFL = 3.0; 

G_theta_GLU  = base_G_theta_GLU * optim_vals(14);
G_dtheta_GLU = base_G_dtheta_GLU * optim_vals(15);
G_theta_HFL  = base_G_theta_HFL * optim_vals(16);
G_dtheta_HFL = base_G_dtheta_HFL * optim_vals(17);

% ---------------------------------------------------------

% --- 3. RUN SIMULATION ---
try
    simout = sim(mdl, 'SrcWorkspace', 'current', 'SimMechanicsOpenEditorOnUpdate', flag_anim);
catch
    f = NaN; return;
end

% --- 4. CALCULATE COST ---
try
    t_end_sim = simout.t_end_sim.Data(end);
    x_end = simout.x_end.Data(end);
catch
    f = NaN; return;
end

if t_end_sim < t_end - 0.1
    f = 1e6 + (t_end - t_end_sim);
else
    try
        if isa(simout.int_Am2, 'timeseries'), E_m = simout.int_Am2.Data(end);
        else, E_m = simout.int_Am2(end); end
    catch
        E_m = 0; 
    end
    v_avg = x_end / t_end_sim;
    if x_end > 0.1
        f = w_act * (E_m / x_end) + w_v * (v_tgt - v_avg)^2;
    else
        f = 1e5; 
    end
end
end