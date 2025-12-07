% Task 3: Behavior 2 - High Stepping
clear; close all; clc;
if exist('ext', 'dir'), addpath('.\ext'); end

objFile = 'sim_muscleLegs_Task3'; 
flag_anim = 0;              
t_end = 5; 

% Start with ones
param0 = ones(17,1);
sigma0 = 0.2 * abs(param0); 

cmaes_opts.DispModulo = 1;  
cmaes_opts.maxiter    = 50; 
cmaes_opts.PopSize    = 16; 
cmaes_opts.SaveFilename = 'cmaes_task3_highstep.mat'; 

% Mode 2 = High Stepping
varargin{1} = [0, 0, 0]; 
varargin{2} = flag_anim;
varargin{3} = t_end;
varargin{4} = 2; 

disp('Starting Task 3 Optimization (High Stepping)...');
[xmin, fmin, counteval, stopflag, out, bestever] ...
    = cmaes(objFile, param0, sigma0, cmaes_opts, varargin);

save('./param/optim_results_task3_highstep.mat', 'xmin', 'bestever', 'out');
disp('Visualizing High Stepping...');
sim_muscleLegs_Task3(bestever.x, {[0,0,0], 1, 15, 2});