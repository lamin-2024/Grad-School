% Name: Lamin Jammeh
% Class: EE480 Online
% Semster: Fall 2023
% HW_8

% Basic Problems
%% ********* Q 4.6 **********
clear;
clc;
w = 2*pi;
t = 0:0.01:1;
x_t = t.*heaviside(t)-t.*heaviside(t-1);
plot(t,x_t);
xlabel('x(t)'); %label x-axis
ylabel('y(t)'); %labels y-axis
title('x(t)'); %assign a plot title
grid on;

%% 
t = -30:0.1:30;
x = 1+cos(2*pi*t)+cos(6*t);
plot(t,x)
how tohgrid on