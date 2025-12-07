% Task 3: Behavior 2 - Crouch Walking (Fixed)
clear; close all; clc;
if exist('ext', 'dir'), addpath('.\ext'); end

objFile = 'sim_muscleLegs_Task3'; 
flag_anim = 0;              
t_end = 5; 

% Use stable walking params as start (Warm Start)
if exist('./param/optim_results_task2_set1.mat', 'file')
    load('./param/optim_results_task2_set1.mat', 'bestever');
    param0 = bestever.x;
else
    param0 = ones(17,1);
end
sigma0 = 0.3 * abs(param0); 

cmaes_opts.DispModulo = 1;  
cmaes_opts.maxiter    = 50; 
cmaes_opts.PopSize    = 16; 
cmaes_opts.SaveFilename = 'cmaes_task3_crouch.mat'; 

% Mode 3 = Crouch
varargin{1} = [0, 0, 0]; 
varargin{2} = flag_anim;
varargin{3} = t_end;
varargin{4} = 3; 

disp('Starting Task 3 Optimization (Crouch Walking)...');
[xmin, fmin, counteval, stopflag, out, bestever] ...
    = cmaes(objFile, param0, sigma0, cmaes_opts, varargin);

save('./param/optim_results_task3_crouch.mat', 'xmin', 'bestever', 'out');
disp('Visualizing Crouch...');
sim_muscleLegs_Task3(bestever.x, {[0,0,0], 1, 15, 3});