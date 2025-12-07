function f = sim_muscleLegs_Task3(optim_vals, varargin)
warning off;

% --- 1. PARSE INPUTS ---
% Default values
w_act = 1; w_v = 0; v_tgt = 1; flag_anim = 0; t_end = 5;
mode = 3; % 2=HighStep, 3=Crouch(Fixed)

mdl = 'muscleLegs_task2'; 

if ~isempty(varargin) && ~isempty(varargin{1})
    innerArgs = varargin{1};
    if numel(innerArgs) >= 1, weights = innerArgs{1}; w_act=weights(1); w_v=weights(2); v_tgt=weights(3); end
    if numel(innerArgs) >= 2, flag_anim = innerArgs{2}; end
    if numel(innerArgs) >= 3, t_end = innerArgs{3}; end
    if numel(innerArgs) >= 4, mode = innerArgs{4}; end
end

% --- 2. SETUP SIMULATION ---
setup_muscleLegs_model;
setup_muscleLegs_ic; 
x0 = 1.0; 
assignin('base', 'x0', x0);

% --- INJECT PARAMETERS ---
params = optim_vals(1:12); 
setup_muscleLegs_ctrl; 

theta_tgt = 0 + (optim_vals(13) - 1) * 0.1;
base_G = [60, 5, 30, 3];
G_theta_GLU  = base_G(1) * optim_vals(14);
G_dtheta_GLU = base_G(2) * optim_vals(15);
G_theta_HFL  = base_G(3) * optim_vals(16);
G_dtheta_HFL = base_G(4) * optim_vals(17);

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
    x_start = simout.x_end.Data(1); 
catch
    f = NaN; return;
end

% Fall Penalty
if t_end_sim < t_end - 0.1
    f = 1e6 + (t_end - t_end_sim);
    return;
end

v_avg = (x_end - x_start) / t_end_sim;

switch mode
    case 2 % HIGH STEPPING (Done)
        try
            hip_L = simout.log_phi_H_L.Data; hip_R = simout.log_phi_H_R.Data;
            step_height = quantile(hip_L, 0.95) + quantile(hip_R, 0.95);
        catch, step_height = 0; end
        f = 10 * (0.5 - v_avg)^2 - 10 * step_height;
        
    case 3 % CROUCH WALKING (SMOOTH FIX)
        % Target: 0.6 m/s (Sneaking speed)
        % Reward: Average Knee Flexion
        
        try
            % Calculate average knee bend (rad)
            avg_knee = mean(abs(simout.log_phi_K_L.Data)) + mean(abs(simout.log_phi_K_R.Data));
        catch
            avg_knee = 0;
        end
        
        % SMOOTH COST FUNCTION:
        % 1. Velocity Error: If v=0, cost is 100*(0.6^2) = 36. 
        %    This pushes the robot to move to reduce cost from 36 -> 0.
        % 2. Knee Reward: Subtracts from total.
        f = 100 * (0.6 - v_avg)^2 - 20 * avg_knee;
        
    otherwise
        try, if isa(simout.int_Am2, 'timeseries'), E_m = simout.int_Am2.Data(end); else, E_m = simout.int_Am2(end); end; catch, E_m=0; end
        f = w_act * (E_m / abs(x_end - x_start)) + w_v * (v_tgt - v_avg)^2;
end
end