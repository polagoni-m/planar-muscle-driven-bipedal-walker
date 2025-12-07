% ME 5374 HW2 Task 1-2: Optimization (Set 1)
clear; close all; clc;

% --- 0. PATH SETUP ---
if exist('ext', 'dir')
    addpath('.\ext');
end

% --- 1. CONFIGURATION FOR SET 1 ---
% "Control parameter set 1: w_e=1, w_v=1, v_tgt=1 m/s"
w_act = 1;     % Weight on Muscle Effort
w_v   = 1;     % Weight on Velocity Error
v_tgt = 1.0;   % Target Velocity (1 m/s)

% --- 2. SETTINGS ---
objFile = 'sim_muscleLegs_Task1'; 
flag_anim = 0;              % 0 = No animation (faster)
t_end = 5;                  % Simulation duration

% --- 3. INITIAL GUESS (From Task 1-1) ---
param0 = ones(12,1);        % Your working hand-tuned parameters
sigma0 = 0.2 * abs(param0); % Search radius (20% variance)

% --- 4. CMA-ES OPTIONS ---
cmaes_opts.DispModulo = 1;  
cmaes_opts.maxiter    = 50; 
cmaes_opts.PopSize    = 16; 
cmaes_opts.SaveFilename = 'cmaes_task1_2_set1.mat'; 

% --- 5. PACK ARGUMENTS --- 
% cmaes will pass this entire varargin cell as a single argument to the function.
varargin{1} = [w_act, w_v, v_tgt]; 
varargin{2} = flag_anim;
varargin{3} = t_end;

% --- 6. RUN OPTIMIZATION ---
disp('Starting Optimization for SET 1...');
disp(['Target Velocity: ', num2str(v_tgt), ' m/s']);

if isempty(which('cmaes'))
    error('Error: cmaes.m not found! Check your path.');
end

[xmin, fmin, counteval, stopflag, out, bestever] ...
    = cmaes( ...
    objFile, ...    
    param0, ...     
    sigma0, ...     
    cmaes_opts, ... 
    varargin ...    
    );

% --- 7. SAVE & VISUALIZE ---
save('./param/optim_results_set1.mat', 'xmin', 'bestever', 'out');
disp('Optimization Done. Results saved to optim_results_set1.mat');

disp('Visualizing Best Solution for Set 1...');
% FIX: Wrap the arguments in a single cell array {} for the direct call
sim_muscleLegs(bestever.x, {[w_act, w_v, v_tgt], 1, 10});