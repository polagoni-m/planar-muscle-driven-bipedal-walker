% ME 5374 HW2 Task 2-2: Optimization (Set 2 - High Speed)
clear; close all; clc;

% --- 0. PATH SETUP ---
if exist('ext', 'dir'), addpath('.\ext'); end

% --- 1. CONFIGURATION FOR SET 2 ---
% "Control parameter set 2: w_e=0, w_v=1, v_tgt=10 m/s"
w_act = 0;     % IGNORE Muscle Effort (Run fast at any cost)
w_v   = 1;     % Focus purely on Velocity
v_tgt = 10.0;  % Target Velocity (10 m/s - Sprinting)

% --- 2. SETTINGS ---
objFile = 'sim_muscleLegs_Task2'; 
flag_anim = 0;              

% --- CRITICAL CHANGE: LONG HORIZON ---
t_end = 15;     % Optimization runs for full 15 seconds 

% --- 3. INITIAL GUESS (Independent) ---
% Start fresh with default multipliers
param0 = ones(17,1);        
sigma0 = 0.2 * abs(param0); % Search radius (20%)

% --- 4. CMA-ES OPTIONS ---
cmaes_opts.DispModulo = 1;  
cmaes_opts.maxiter    = 50; 
cmaes_opts.PopSize    = 16; 
cmaes_opts.SaveFilename = 'cmaes_task2_2_set2.mat'; 

% --- 5. PACK ARGUMENTS ---
varargin{1} = [w_act, w_v, v_tgt]; 
varargin{2} = flag_anim;
varargin{3} = t_end; % This passes '15' to the optimizer function

% --- 6. RUN OPTIMIZATION ---
disp(['Starting Task 2-2 Optimization (SET 2)...']);
if isempty(which('cmaes'))
    error('Error: cmaes.m not found! Check your path.');
end

[xmin, fmin, counteval, stopflag, out, bestever] ...
    = cmaes(objFile, param0, sigma0, cmaes_opts, varargin);

% --- 7. SAVE & VISUALIZE ---
save('./param/optim_results_task2_set2.mat', 'xmin', 'bestever', 'out');
disp('Optimization Done. Results saved.');

% --- VISUALIZATION STEP ---
disp('Visualizing Best Solution for 15 seconds...');
sim_muscleLegs_Task2(bestever.x, {[w_act, w_v, v_tgt], 1, 15});