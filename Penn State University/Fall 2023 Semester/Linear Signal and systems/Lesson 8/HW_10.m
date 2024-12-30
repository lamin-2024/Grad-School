% Name: Lamin Jammeh
% Class: EE480 Online
% Semster: Fall 2023
% HW_10

% Basic Problems
%% *********** 5.16a **********
clear;
clc;
% STEP 1 defien the syms function and signal x(t) with p(t)
syms t s w;
t_range = 0:0.001:10;% duration of the signal captures
x = @(t) ((0.5*t*heaviside(t))-heaviside(t-1)); %signal x(t)
p = @(t) (heaviside(t+1)-heaviside(t-2)); %pulse signal

%STEP2 determine the x(t) values with the define  time range
x_values = subs(x(t),t,t_range);

%STEP3 Plot the x(t) with the define time range
plot(t_range,x_values,'r','LineWidth',2);
xlabel('t');
ylabel('x(t)');
title("Plot of x(t) in the time domain")
grid on;

% *********** 5.16b *********
% determine the fourier Transform with fourier function in matlab
P = fourier(p(t), t, w);
%% ********** 5.29 **********
clear;
clc;
% STEP 1 define the duration of the signal and the N(number of Fourier
% coeeficients)
t =0:0.01:10; 
N = 50;

% STEP 2 Define the function or signal x(t) 
x = @(t) (heaviside(t+0.5)-heaviside(t-0.5));

%STEP 2 create a matrix for the Periods and Cn values to be used
T_values = [2,4,8,16];
Cn_values = cell(1,numel(T_values)); % stores Cn values at each T0

% Step 3 create a Loop to deffine w=2pi/T at each T values
for T = 1:numel(T_values) % accesses the T_values or index through T_values
    T0 = T_values(T);
    w = 2*pi/T0;

    % STEP 4 create an empty array for the Cn [1 x Number of Harmonics]
    Cn = zeros(1,N); %opens an array from C1...CN

% STEP 5 calculate the Cn from -N:N using the complex integral method
for n = -N:N
    n_index = n + N + 1; % index through -N:N in increments of +1
    Cn(n_index) = (1 / T) * integral(@(t) x(t) .* exp(-1j * n * w * t), 0, T0); %determine Cn from -N:1:N 
end

% STEP 6 Determine the Cn values for each T0 value
Cn_values{T} = Cn; %determine Cn values for each T0
end

% STEP 7 Plot Cn_mag @ each T0
figure;
for T = 1:numel(T_values) % accesses the T_values or index through T_values
    T0 = T_values(T);
    subplot(numel(T_values), 1, T);
    stem(-N:N, abs(Cn_values{T}), 'r');
    title(['T = ' num2str(T0)]);
    xlabel('Harmonics(n)');
    ylabel('|Fourier Coefficients (c_n)|');
end

%% ********** 5.31 matlab **********    
clear;
clc;
% STEP 1 define syms function interms of t and w
syms t w;

t_range = -10:0.01:10; % duration of the signal x(t)
w_range = -10:0.01:10; %freq range of X(w)

x = @(t) (2*exp(-2*abs(t)));% signal x(t)

% Step 2 determine the FT using the fourier function of matlab
X = fourier(x(t),t,w);

% STEP 3 determine the magnitude of the FT using abs(FT)
X_mag = abs(X);

%STEP 4 determine the Xmag and x(t) values for the given freq and time range using sub(func,old,new)
x_tValue = subs(x(t), t, t_range);
X_magValue = subs(X_mag, w, w_range);

%STEP4 plot the signals to visualize
subplot(2,1,1)
% Plot of signal X(t)
plot(t_range,x_tValue,'r','LineWidth',2)
xlabel('Time (t)');
ylabel('x(t)')
title('Plot to visualize signal x(t)')
grid on;

% use fplot to the fourier transform and Mag spectrum
subplot(2,1,2)
% Plot the magnitude spectrum
stem(w_range, X_magValue);
title('Magnitude Spectrum of x(t)');
xlabel('Frequency (w)');
ylabel('Magnitude');
grid on;

figure;
subplot(2,1,1);
fplot(x,[-2,2]);
axis([-2 2 0 3])
title("Fourier Transform of x(t)")
grid on
subplot(2,1,2);
fplot(X_mag,[-30,30]);
axis([-30 30 0 3])
title("Magnitude Spectrum of X(w)")
grid on;
