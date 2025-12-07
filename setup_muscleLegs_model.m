% model parameters
g = 9.81; % []

l_total = 1;
r_foot = 0.01;
l_leg = l_total-2*r_foot; % [m]
l_thigh = l_leg/2;
l_shank = l_leg/2;

m_total = 80; % [kg]
m_thigh = 8;
m_shank = 4;
m_foot = 1;
m_body = m_total - 2*m_foot; % [kg]

com_thigh = [0 0 0];
I_thigh = [0.1 0.1 0.15]; % [kg*m^2]
com_shank = [0 0 0];
I_shank = [0.1 0.1 0.05]; % [kg*m^2]

% knee joint limit
del_phi_K = 0*pi/180;

setup_muscleLegs_nm;

% ground
plane_height = 0.1;
plane_x = 100;
plane_z = 1;


% --- Task 2: HAT (Head-Arms-Trunk) Parameters ---
% Reference: HW2 Task 2-1 
l_HAT = 0.8;          % [m] Length
m_HAT = 54;           % [kg] Mass
% CoM is [0 0 0] relative to the reference frame (midpoint or connection point)
% NOTE: Instructions say "extends upward from the hip joint". 
% We will handle the offset in the Solid Block geometry.
com_HAT = [0 0 0];    
I_HAT = [0.1 0.1 2.5];% [kg*m^2] Inertia (High pitch inertia)