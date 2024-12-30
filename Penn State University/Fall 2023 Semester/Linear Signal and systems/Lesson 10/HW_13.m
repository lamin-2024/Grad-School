% Name: Lamin Jammeh
% Class: EE480 Online
% Semster: Fall 2023
% HW_13

% Basic Problems
%% *********** 10.36c **********
clear;
clc;
syms z;
%Step defien the two transfer functions
H_1 = 0.2 / (1 + 0.5*z^(-1));
H_2 = (0.8 - 0.2*z^(-1)) / (1 - z^(-1) + 0.5*z^(-2));
%Step2 since the 2 TF are in parallel add the TF 
H_z = H_1 + H_2
H = simplifyFraction(H_z)