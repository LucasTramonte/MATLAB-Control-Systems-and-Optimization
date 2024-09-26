clear all;
close all;
%% Initialization script of closed loop env
% Load tratectory for Parallel parking Rigth
load('SimuEnvSce_Param.mat');
% Assignment to reference trajectory

Te = 0.001;
Time = (0 : Te : Te*(length(x)-1))';

%[Time vref]

xref = timeseries(x,Time);
yref = timeseries(y,Time);
phiref = timeseries(phi,Time);
vref = timeseries(v,Time);
deltaref = timeseries(delta,Time);


% Veh Param
b = 2.8841;             % Length of vehicle
a = 1.61/2;             % Width of vehicle
phiini = 0;             % Initial Cond for kinematics model's integrator 
yini = 0;               % Initial Cond for kinematics model's integrator 
xini = 0;               % Initial Cond for kinematics model's integrator

vmax = 3/3.6;           % vitesse max en m/s
phieq = 20*pi/180;      % Equilibrum point for linearization 

%% Control
Ltot = [sqrt(3) 1 0];

%% LQR
v = -vmax;
b3 = v/b;
a13 = -v*sin(phieq);
a23 = v*cos(phieq);

T_inv = [a23/(a13*b3) -1/b3 1/b3; 1/(a13*b3) 0 0; -a23/a13 1 0];

A = [0 0 -v*sin(phieq); 0 0 v*cos(phieq); 0 0 0];
B = [0; 0; v/b];

Q = eye(2);
Q(1,1) = 1;
R = 10;
A_til = T_inv*A*inv(T_inv);
B_til = T_inv*B;

[L,P,e] = lqr(A_til(1:2, 1:2),B_til(1:2),Q,R);

Ltot = [L 0];



%% Dynamique de l'actionneur direction
s = tf('s');
wn = 5;
epsilon = 1;
V_p = wn^2/(s^2+2*epsilon*wn*s+wn^2);
V_pD = c2d(V_p, Te);

FV_p = (s^2+2*epsilon*wn*s+wn^2)/(s^2+2*5*1*s+5^2);
FV_pD = c2d(FV_p, Te);

