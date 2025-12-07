% set main initial conditions
x0 = 1;
d_x0 = 1.2;
d_y0 = 0;

% dervie leg initial condition
phi0_H_L = 20*pi/180;
phi0_K_L = 5*pi/180;
phi0_H_R = -20*pi/180; % rad
phi0_K_R = 10*pi/180;

d_phi0_H_L = -d_x0/l_total; % rad/sec
d_phi0_H_R = -d_phi0_H_L; % rad/sec

% dervie COM initial condition
y0 = l_thigh*cos(phi0_H_L) + (l_shank+2*r_foot)*cos(phi0_H_L-phi0_K_L); % error
