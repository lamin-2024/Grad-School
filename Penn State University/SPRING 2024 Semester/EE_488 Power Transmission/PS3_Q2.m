%%********************** Problem Set2 Q2 ***************************
clear;
clc;
%______Generator Transient Response Spec____________________________
X2_d = 0.15; % p.u Direct axis, sub-transient reactance
X1_d = 0.25; % p.u Direct axis, transient reactance
X_d = 1.20; % p.u Direct axis, synchronous reactance
T2_d = 0.038; % p.u Direct axis, short-circuit, sub-transient time constant
T1_d = 1.50; % p.u Direct axis, short-circuit, transient time constant
T_A = 0.15; % p.u Aarmature Time constant

%______Transformer Spec____________________________________________
V1_T = 13.8; % KV Tranformer input voltage
V2_T = 138; % KV Transformer output voltage
Z_T = 0.15; % Transformer Z_series

%_____system operating Spec_________________________________________
f = 60; % sytem frequency
w = 2*pi*f;
a = 0;
Vm = sqrt(2)*1.0;
t = 3/f
s = pi/2
ang=rad2deg(w*t+a-s)

%_____________________System base values_____________________________
S_base = 100*10^6;
V_base = 138*10^3;
I_base = S_base/V_base
Z_base = (V_base^2)/S_base

%************************** Q2 (a) *********************************
I_stf = Vm/(Z_T+X2_d)
I_stpA = I_stf*I_base
I_DC = I_stf*exp(-t/T_A)
I_DC_A = I_DC * I_base

%*********************** Q2(b) **************************************
I_ac = Vm*((1/(X2_d+Z_T) - 1/(X1_d+Z_T))*exp(-t/T2_d)+(1/(X1_d+Z_T) - 1/(X_d+Z_T))*exp(-t/T1_d)+1/(X_d+Z_T)) %*sin(w*t + a-s)


