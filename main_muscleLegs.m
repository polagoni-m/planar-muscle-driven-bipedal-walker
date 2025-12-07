% Segmented Legs Walking Simulation
clear;
close all;
clc;

flag_ctrl = 1;

%load('./param/optim_out_20251106_trq.mat')
%params = out.solutions.recentbest.x;
params = ones(12,1);

% Define parameters, initial conditions, time settings
setup_muscleLegs_model;
setup_muscleLegs_ic;
setup_muscleLegs_ctrl;


% Time settings
t_end = 30;

%out = sim("muscleLegs_task1.slx");
out = sim("muscleLegs_task2.slx");

% % --- Print Active Control Parameters for Report ---
% disp('==================================================');
% disp('       TASK 1-1: SIMULATION PARAMETERS REPORT     ');
% disp('==================================================');
% 
% % Stance Phase Parameters
% fprintf('STANCE LEG CONTROL:\n');
% fprintf('  Hip Torque Constant (tau_H_st):       %8.4f Nm\n', tau_H_st);
% fprintf('  Knee Target Angle (phi_K_tgt_st):     %8.4f rad\n', phi_K_tgt_st);
% fprintf('  Knee Stiffness (P_K_st):              %8.4f Nm/rad\n', P_K_st);
% fprintf('  Knee Damping (D_K_st):                %8.4f Nm/(rad/s)\n', D_K_st);
% fprintf('\n');
% 
% % Swing Phase Parameters (Hip)
% fprintf('SWING LEG - HIP CONTROL:\n');
% fprintf('  Hip Target Angle (phi_H_tgt_sw):      %8.4f rad\n', phi_H_tgt_sw);
% fprintf('  Hip Stiffness (P_H_sw):               %8.4f Nm/rad\n', P_H_sw);
% fprintf('  Hip Damping (D_H_sw):                 %8.4f Nm/(rad/s)\n', D_H_sw);
% fprintf('\n');
% 
% % Swing Phase Parameters (Knee)
% fprintf('SWING LEG - KNEE CONTROL:\n');
% fprintf('  Knee Target Velocities (v_phi_K_tgt): [%.4f, %.4f] rad/s\n', v_phi_K_tgt_sw(1), v_phi_K_tgt_sw(2));
% fprintf('  Hip Reference Angle (phi_H_ref_sw):   %8.4f rad\n', phi_H_ref_sw);
% fprintf('  Knee Stiffness (P_K_sw):              %8.4f Nm/rad\n', P_K_sw);
% fprintf('  Knee Damping (D_K_sw):                %8.4f Nm/(rad/s)\n', D_K_sw);
% disp('==================================================');