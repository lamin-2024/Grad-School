% Name: Lamin Jammeh
% Class: EE480 Online
% Semster: Fall 2023
% HW_9

% Basic Problemsclear;
%% ********** Q4.24b **********
clc;
syms t s;
r = t.*heaviside(t);
r_d = (t-1).*heaviside(t-1);
x = r-r_d-heaviside(t-1);
X_s = laplace(x)

%% ********** Q4.24c **********
clear;
clc;
% Define the time range
t = 0:0.001:10;  % Adjust the range as needed
T = 1;
% Define the ramp function r(t)
r = t.*heaviside(t); % unit ramp interms of unit step r(t)=t*u(t)
r_d = (t-1).*heaviside(t-1); %r(t-1)
x = r-r_d-heaviside(t-1); %x1(t)=r(t)-r(t-1)-u(t-1)
N = 40; % Number of Harmonics
X_dc = 0.5; % dc term or a_0
x_i = zeros(size(t)); %signal starts at t=0
for k = 1:N
    %Xk = 1/T * integral(@(t) t .*exp(-j*2*pi*k*(t/T)),0,T);
    Xk = 1/T *(j/(2*pi.*k));
    x_i = x_i + Xk * exp(j * 2 * pi * k * t / T);
end
X_f = X_dc + x_i; %fourier Term
figure;
subplot(2,1,1);
plot(t, X_f, 'b', 'LineWidth', 2);
xlabel('t');
ylabel('x(t)');
title('Plot of Fourier Series');
grid on;

%for the Magnitude frequency response determine Magnitude of FS and the
%frequency axis

%step 1 determine the Magnitude of Fourier Series (FS) of the signal
magnitude_spectrum = abs(X_f);

%Step 2 determine the freq axis
f0 = 1/T; %fundamental Freq=1/fundamental period
num_coefficients = length(magnitude_spectrum);
f_axis = (0:num_coefficients-1) / num_coefficients * f0;

% Plot the magnitude spectrum
subplot(2,1,2);
stem(f_axis, magnitude_spectrum, 'LineStyle', 'none');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Line Spectrum of Fourier Series (40 Harmonics, T=1s)');
grid on;

%% ********** Q4.26 a **********
clc;
syms t s;
x = heaviside(t)-heaviside(t-1);
X_s = laplace(x)

%% ********** Q4.26b **********
clear;
clc;
% Define the time range
t = 0:0.001:10;  % Adjust the range as needed
T = 2;

x = heaviside(t)-heaviside(t-1);
N = 40; % Number of Harmonics
X_dc = 1; % dc term or a_0
x_i = zeros(size(t)); %signal starts at t=0
for k = 1:N
    Xk = (1-exp(-j*pi.*k)) / (j*pi.*k);
    x_i = x_i + Xk * exp(j * 2 * pi * k * t / T);
end
X_f = X_dc + x_i; %fourier Term

figure;
subplot(2,1,1);
plot(t, X_f, 'b', 'LineWidth', 2);
xlabel('t');
ylabel('x(t)');
title('Plot of Fourier Series');
grid on;

%for the Magnitude frequency response determine Magnitude of FS and the
%frequency axis

%step 1 determine the Magnitude of Fourier Series (FS) of the signal
magnitude_spectrum = abs(X_f);

%Step 2 determine the freq axis
f0 = 1/T; %fundamental Freq=1/fundamental period
num_coefficients = length(magnitude_spectrum);
f_axis = (0:num_coefficients-1) / num_coefficients * f0;

% Plot the magnitude spectrum
subplot(2,1,2);
stem(f_axis, magnitude_spectrum, 'LineStyle', 'none');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Line Spectrum of Fourier Series (40 Harmonics, T=2s)');
grid on;

%% ********** Q4.28 part 1 **********
clear;
clc;
%find the laplace of x(t) and y(t)
syms t s;
x1 = heaviside(t)-heaviside(t-1); 
X_s = laplace(x1)

r = t.*heaviside(t);
r_1 = (t-1).*heaviside(t-1);
r_2 = (t-2).*heaviside(t-2);
y1 = r - 2*r_1 + r_2;
Y_s = laplace(y1)

%% ********** Q4.28 **********
clear;
clc;
% Define the time range
t = 0:0.001:2;  % Adjust the range as needed
T = 2;

%Part 1 x1(t) = u(t)-u(t-1)
x = heaviside(t)-heaviside(t-1);
N = 40; % Number of Harmonics
X_dc = 1; % dc term or a_0
x_i = zeros(size(t)); %signal starts at t=0
for k = 1:N
    Xk = 0.5*(1-exp(-j*pi.*k)) / (j*pi.*k);
    x_i = x_i + Xk * exp(j * 2 * pi * k * t / T);
end
X_f = X_dc + x_i; %fourier Term

%for the Magnitude frequency response determine Magnitude of FS and the
%frequency axis

%step 1 determine the Magnitude of Fourier Series (FS) of the signal
magnitude_spectrum_x = abs(X_f);

%Step 2 determine the freq axis
f0 = 1/T; %fundamental Freq=1/fundamental period
num_coefficients = length(magnitude_spectrum_x);
f_axis1 = (0:num_coefficients-1) / num_coefficients * f0;

%Part 2 y1(t) = r(t)-2r(t-1)+r(t-2)
r = t.*heaviside(t);
r_1 = (t-1).*heaviside(t-1);
r_2 = (t-2).*heaviside(t-2);
y = r - r_1 + r_2;
Y_dc = 1; % dc term or a_0
y_i = zeros(size(t)); %signal starts at t=0
for k = 1:N
    Yk = 0.5*(exp(-j*2*pi.*k)-exp(-j*pi.*k)+1) / (j*pi*k)^2;
    y_i = y_i + Yk * exp(j * 2 * pi * k * t / T);
end
Y_f = Y_dc + y_i; %fourier Term

%step 1 determine the Magnitude of Fourier Series (FS) of the signal
magnitude_spectrum_y = abs(Y_f);

%Step 2 determine the freq axis
f0 = 1/T; %fundamental Freq=1/fundamental period
num_coefficients = length(magnitude_spectrum_y);
f_axis2 = (0:num_coefficients-1) / num_coefficients * f0;

%Plot the Fourier Series of x(t) and y(t)
figure;
subplot(2,1,1);
plot(t,X_f,'r','LineWidth',2);
xlabel('time');
ylabel('amplitude');
title('Fourier Series plot of x(t)')
subplot(2,1,2);
plot(t,Y_f,'LineWidth',2);
xlabel('time');
ylabel('amplitude');
title('Fourier Series plot of y(t)')

%Plot the Magnitude Line Spectra of x(t) and y(t)
figure;
stem(f_axis1, magnitude_spectrum_x, 'LineStyle', 'none');
hold on;
stem(f_axis2, magnitude_spectrum_y, 'LineStyle', 'none');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Line Spectrum of Fourier Series X(t) vs Y(t) (40 Harmonics, T=2s)');
grid on;
legend('X(t)','Y(t)')
hold off

%% ********** Q4.29 part 1 **********
clear;
clc;
%find the laplace of x(t) and y(t)
syms t s;
x1 = heaviside(t)-heaviside(t-1); 
X_s = laplace(x1)

y1 = heaviside(t)-heaviside(t-0.5); 
Y_s = laplace(y1)

%% ********** Q4.29b **********
clear;
clc;
t1 = 0:0.001:2;
t2 = 0:0.001:1;
w = j*2*pi;
W = (80*pi)/(2*pi); 
T0 = 2;
T1 = 1;
%calculate the x1(t) terms
X_dc = 1; % dc term or a_0
x_i = zeros(size(t1)); %signal starts at t=0
for k = 1:W
    Xk = 0.5*(1-exp(-w.*k/T0)) / (w.*k/T0);
    x_i = x_i + Xk * exp(j * 2 * pi * k * t1 / T0);
end
X_f = X_dc + x_i; %fourier Term

%step 1 determine the Magnitude of Fourier Series (FS) of the signal
magnitude_spectrum_x = abs(X_f);

%Step 2 determine the freq axis
f0 = 1/T0; %fundamental Freq=1/fundamental period
num_coefficients = length(magnitude_spectrum_x);
f_axis1 = (0:num_coefficients-1) / num_coefficients * f0;


%calculate the y1(t) terms
Y_dc = 1; % dc term or a_0
y_i = zeros(size(t2)); %signal starts at t=0
for k = 1:W
    Yk = (1/T1)*((1-exp(-w.*k/2))/w.*k);
    y_i = y_i + Yk * exp(j * 2 * pi * k * t2 / T1);
end
Y_f = Y_dc + y_i; %fourier Term

%step 1 determine the Magnitude of Fourier Series (FS) of the signal
magnitude_spectrum_y = abs(Y_f);

%Step 2 determine the freq axis
f0 = 1/T1; %fundamental Freq=1/fundamental period
num_coefficients = length(magnitude_spectrum_y);
f_axis2 = (0:num_coefficients-1) / num_coefficients * f0;

%Plot the Fourier Series of x(t) and y(t)
figure;
subplot(2,1,1);
plot(t1,X_f,'LineWidth',2);
xlabel('time');
ylabel('amplitude');
title('Fourier Series plot of x(t)')
subplot(2,1,2);
plot(t2,Y_f,'LineWidth',2);
xlabel('time');
ylabel('amplitude');
title('Fourier Series plot of y(t)')

%Plot the Magnitude Line Spectra of x(t) and y(t)
figure;
subplot(2,1,1)
stem(f_axis1, magnitude_spectrum_x, 'LineStyle', 'none');
subplot(2,1,2)
stem(f_axis2, magnitude_spectrum_y, 'LineStyle', 'none');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Line Spectrum of Fourier Series Y(t) (0:80pi, T=1s)');


