%
% by Seungmoon Song
% adapted from April 2021 model
% for ME 5374
%
% changes:
% - Constant moment arms for all muscles
% - No biarticular muscles
%   - (+ no ankle) The model may to too weak for running 
%


% --------------------------------- %
% 1 Shared Muscle Tendon Parameters %
% --------------------------------- %

% excitation-contraction coupling
init_stim   = 0.01;
tau_act     =  0.01; %[s] delay time constant
tau_deact	=  0.04; %[s] delay time constant

% contractile element (CE) force-length relationship
w       =   0.56; %[lopt] width
c       =   0.05; %[]; remaining force at +/- width
w_pe	= w;

% CE force-velocity relationship
N    =   1.5; %[Fmax] eccentric force enhancement
K    =     5; %[] shape factor

% Series elastic element (SE) force-length relationship
eref_se =  0.04; %[lslack] tendon reference strain


% ----------------------------- %
% 2. MUSCLE-SKELETON PARAMETERS %
% ----------------------------- %

% VAStus group
% attachement
rVAS        = 0.05;         % [m]
phirefVAS   = 60*pi/180;    % [rad] reference angle at which MTU length equals 
rhoVAS      = 0.6;          %       sum of lopt and lslack
% muscle
FmaxVAS     = 5000; % maximum isometric force [N]
loptVAS     = 0.08; % optimum fiber length CE [m]
vmaxVAS     =   12; % maximum contraction velocity [lopt/s]
lslackVAS   = 0.23; % tendon slack length [m]

% BFSH (bicep femoris short head)
% attachement
rBFSH    	= 0.04;         % [m]   constant lever contribution 
phirefBFSH 	= 160*pi/180;   % [rad] reference angle at which MTU length equals 
rhoBFSH    	= 0.7;          %       sum of lopt and lslack
% muscle
FmaxBFSH	=  350; % maximum isometric force [N]
loptBFSH    = 0.12; % optimum fiber length CE [m]
vmaxBFSH    =   12; %6 % maximum contraction velocity [lopt/s]
lslackBFSH  = 0.10; % tendon slack length [m]

% Hip FLexor group
%attachement
rHFL       =       0.08; % [m]   constant lever contribution 
phirefHFL  = 20*pi/180; % [rad] reference angle at which MTU length equals 
rhoHFL     =        0.5; %       sum of lopt and lslack          
% muscle
FmaxHFL   = 2000; % maximum isometric force [N]
loptHFL   = 0.11; % optimum fiber length CE [m]
vmaxHFL   =   12; % maximum contraction velocity [lopt/s]
lslackHFL = 0.10; % tendon slack length [m]

 % GLUtei group
 % attachement
rGLU       =       0.08; % [m]   constant lever contribution 
phirefGLU  = 60*pi/180; % [rad] reference angle at which MTU length equals 
rhoGLU     =        0.5; %       sum of lopt and lslack 
% muscle
FmaxGLU   = 4000; % maximum isometric force [N]
loptGLU   = 0.11; % optimum fiber length CE [m]
vmaxGLU   =   12; % maximum contraction velocity [lopt/s]
lslackGLU = 0.13; % tendon slack length [m]
