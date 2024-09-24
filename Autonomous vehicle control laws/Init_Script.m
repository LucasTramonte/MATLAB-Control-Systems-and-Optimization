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
