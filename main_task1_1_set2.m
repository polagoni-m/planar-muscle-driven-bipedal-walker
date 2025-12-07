% ME 5374 HW2 Task 1-2: Optimization (Set 2)
clear; close all; clc;

% --- 0. PATH SETUP ---
if exist('ext', 'dir'), addpath('.\ext'); end

% --- 1. CONFIGURATION FOR SET 2 (HIGH SPEED) ---
% "Control parameter set 2: w_e=0, w_v=1, v_tgt=10 m/s"
w_act = 0;     % Zero penalty for effort (Sprint Mode)
w_v   = 1;     % Weight on Velocity Error
v_tgt = 10.0;  % Target Velocity (10 m/s)

% --- 2. SETTINGS ---
objFile = 'sim_muscleLegs_Task1'; 
flag_anim = 0;              
t_end = 5;                  

% --- 3. INITIAL GUESS ---
% Use your working "ones" parameters as the start point
param0 = ones(12,1);        
sigma0 = 0.2 * abs(param0); 

% --- 4. CMA-ES OPTIONS ---
cmaes_opts.DispModulo = 1;  
cmaes_opts.maxiter    = 50; 
cmaes_opts.PopSize    = 16; 
cmaes_opts.SaveFilename = 'cmaes_task1_2_set2.mat'; 

% --- 5. PACK ARGUMENTS ---
varargin{1} = [w_act, w_v, v_tgt]; 
varargin{2} = flag_anim;
varargin{3} = t_end;

% --- 6. RUN OPTIMIZATION ---
disp('Starting Optimization for SET 2 (High Speed)...');
[xmin, fmin, counteval, stopflag, out, bestever] ...
    = cmaes(objFile, param0, sigma0, cmaes_opts, varargin);

% --- 7. SAVE & VISUALIZE ---
save('./param/optim_results_set2.mat', 'xmin', 'bestever', 'out');
disp('Set 2 Done. Results saved.');
disp('Visualizing Best Solution for Set 2...');
sim_muscleLegs(bestever.x, {[w_act, w_v, v_tgt], 1, 10});