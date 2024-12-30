clear;
clc;
% Define the function f(t) and the period T
T = 2;
t = 0:0.001:T; % Time vector

% Create the function f(t) - you can adjust the time resolution as needed
f = heaviside(t) - heaviside(t - 1);

% Calculate the Fourier coefficients using the FFT
% N = length(f); % Number of data points
% Xk = fft(f) / N; % Compute the FFT and normalize by the number of data points
N=20;
F_s = fourierseries(f,T,N); 

f0 = 1/T; %fundamental Freq=1/fundamental period
num_coefficients = length(F_s);
f_axis = (0:num_coefficients-1) / num_coefficients * f0;
% Plot the magnitude of the coefficients
stem(f_axis, abs(F_s))
xlabel('Frequency (Hz)')
ylabel('|X_k|')
title('Fourier Series Coefficients')
grid on
% 
% plot(t, f, 'LineWidth',2)
% xlabel('Frequency (Hz)')
% ylabel('|X_k|')
% title('Fourier Series Coefficients')
% grid on