% Name: Lamin Jammeh
% Class: EE480 Online
% Semster: Fall 2023
% Final Exam

%% ******************* Question 1 *************
clear;
clc;
syms t n;
T = 4 % Period of the function
w = 2*pi/T

% Define the function
x = (0.5*t*heaviside(t)) - heaviside(t-1);

% Calculate the Fourier coefficients using integration
a0 = (1/T) * int(x, t, 0, T)
an = (2/T) * int(x * cos(w*n*t), t, 0, T)
bn = (2/T) * int(x * sin(w*n*t), t, 0, T)

Fourier_series = a0  + an*cos(w*n*t) + bn*sin(w*n*t)
%% ******************* Question 2 Voltage at capacitior *************
clear;
clc;

syms s

% Define the transfer function
H = 1/(s^2 + s - 1);

% define the w-max
wmax = 10;
w = 0:0.01:wmax;

% Substitute s with jw (j times omega) for frequency domain analysis
H_jw = subs(H, s, 1i*w);

% Calculate magnitude
magnitude = simplify(abs(H_jw));

% Calculate phase
phase = angle(H_jw);

%plot the mag and phase vs freq(w)
subplot(2,1,1)
plot(w,magnitude,'r',"LineWidth",2)
xlabel('\Omega');
ylabel('|H_j\omega|');
title('Magnitude vs freqency \omega')
grid on

%% ******************* Question 2 Voltage at inductor *************
clear;
clc;

syms s

% Define the transfer function
H = s^2/(s^2 + s - 1);

% define the w-max
wmax = 10;
w = 0:0.01:wmax;

% Substitute s with jw (j times omega) for frequency domain analysis
H_jw = subs(H, s, 1i*w);

% Calculate magnitude
magnitude = simplify(abs(H_jw));

% Calculate phase
phase = angle(H_jw);

%plot the mag and phase vs freq(w)
subplot(2,1,1)
plot(w,magnitude,'r',"LineWidth",2)
xlabel('\Omega');
ylabel('|H_j\omega|');
title('Magnitude vs freqency \omega')
grid on

subplot(2,1,2)
plot(w,phase,'r',"LineWidth",2)
xlabel('\Omega');
ylabel('<H_j\omega');
title('Phase angle vs freqency \omega')
grid on

subplot(2,1,2)
plot(w,phase,'r',"LineWidth",2)
xlabel('\Omega');
ylabel('<H_j\omega');
title('Phase angle vs freqency \omega')
grid on

%% ******************* Question 2 Voltage at resistor *************
clear;
clc;

syms s

% Define the transfer function
H = s/(s^2 + s - 1);

% define the w-max
wmax = 10;
w = 0:0.01:wmax;

% Substitute s with jw (j times omega) for frequency domain analysis
H_jw = subs(H, s, 1i*w);

% Calculate magnitude
magnitude = simplify(abs(H_jw));

% Calculate phase
phase = angle(H_jw);

%plot the mag and phase vs freq(w)
subplot(2,1,1)
plot(w,magnitude,'r',"LineWidth",2)
xlabel('\Omega');
ylabel('|H_j\omega|');
title('Magnitude vs freqency \omega')
grid on

subplot(2,1,2)
plot(w,phase,'r',"LineWidth",2)
xlabel('\Omega');
ylabel('<H_j\omega');
title('Phase angle vs freqency \omega')
grid on

subplot(2,1,2)
plot(w,phase,'r',"LineWidth",2)
xlabel('\Omega');
ylabel('<H_j\omega');
title('Phase angle vs freqency \omega')
grid on