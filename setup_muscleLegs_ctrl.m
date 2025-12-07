% stance leg control
tau_H_st = params(1)-1;
phi_K_tgt_st = (params(2)-1)*10*pi/180;
% P_K_st = 100 / (15*pi/180) * params(3);
% D_K_st = 0.1*P_K_st * params(4);
P_K_st = 1 / (15*pi/180) * params(3);
D_K_st = 0.1*P_K_st * params(4);

% swing leg control: hip
phi_H_tgt_sw = 10*pi/180 * params(5);
P_H_sw = 100 / (40*pi/180) * params(6);
D_H_sw = 0.1*P_H_sw * params(7);

% swing leg control: knee
v_phi_K_tgt_sw = [45*params(8) 15*params(9)]*pi/180;
phi_H_ref_sw = (params(10)-1)*10*pi/180;
% P_K_sw = 1000 / (40*pi/180) * params(11);
% D_K_sw = 0.1*P_K_sw * params(12);
P_K_sw = 1 / (40*pi/180) * params(11);
D_K_sw = 0.1*P_K_sw * params(12);

vi_Ctrl_st = 1:4; n_Ctrl_st = length(vi_Ctrl_st);
vi_Ctrl_sw = 5:12; n_Ctrl_sw = length(vi_Ctrl_sw);
CtrlPar = [tau_H_st; phi_K_tgt_st; P_K_st; D_K_st;
            phi_H_tgt_sw; P_H_sw; D_H_sw;
            v_phi_K_tgt_sw(1); v_phi_K_tgt_sw(2); phi_H_ref_sw; P_K_sw; D_K_sw];


% --- Task 2: Trunk Balance Control Parameters ---
% Reference: HW2 Task 2-1 Equations
% S_GLU = [Kp * (theta - theta_tgt) + Kd * d_theta]
% S_HFL = [-Kp * (theta - theta_tgt) - Kd * d_theta]

theta_tgt = 0.001;          % Target angle (0 = vertical)

% Stance Hip Gains (Hand-tuned placeholders - you will tune these!)
% Suggested starting values (adjust if model falls):
G_theta_GLU = 60;      % Proportional gain for Gluteus
G_dtheta_GLU = 5;     % Derivative gain for Gluteus

G_theta_HFL = 30;      % Proportional gain for HFL
G_dtheta_HFL = 3;     % Derivative gain for HFL