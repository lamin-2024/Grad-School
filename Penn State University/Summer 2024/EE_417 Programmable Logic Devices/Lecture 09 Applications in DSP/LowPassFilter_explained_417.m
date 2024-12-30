%--------------------------------------------------------------------------
%                             FIR filters
%--------------------------------------------------------------------------
% 1. Finding the filter coefficients in MATLAB based on the filter order,
%    sampling frequency, cutoff frequency, and filter type.
% 2. Using the fft function to find the frequency content of a signal.
% 3. Filtering a signal in MATLAB using the 'filter' function.
% 4. Implementing convolution or MAC (Multiply and Accumulate) technique 
%    to filter the signal, as implemented in Hardware.
%--------------------------------------------------------------------------
close all      % closes any figures that are open
clear          % clears the workspace of MATLAB
clc            % clears the command window
%--------------------------------------------------------------------------
% Defining the parameters of the synthetic input signal:

fs   = 2000;     % the sampling frequency = 2KHz
fmax = fs/2;     % Maximum fundamental frequency that can be sampled by fs

f1 = 50;       % frequency f1 is 50Hz     
f2 = 800;      % frequency f2 is 800Hz 
f3 = 900;      % frequency f3 is 900Hz

A1 = 10;       % Amplitude of the sine wave s1
A2 = 5;        % Amplitude of the sine wave s2 
A3 = 8;        % Amplitide of the sine wave s3   

L = 200;       % the number of samples

t = (0:L-1)/fs;           % Generating the time vector for L samples

s = A1*sin(2*pi*t*f1) + A2*sin(2*pi*t*f2) + A3*sin(2*pi*t*f3);

%--------------------------------------------------------------------------
% Defining the filter parameters:

fc = 400;      % the filter cutoff frequency is 400Hz
Wn = fc/fmax;  % Wn = fc/fmax
order = 8;     % the order of the filter

%coeff = fir1(order,Wn,'low');   % low pass filter
coeff = fir1(order,Wn,'high');   % high pass filter

disp(coeff)

%--------------------------------------------------------------------------
%              Filtering the signal using 3 approaches
%--------------------------------------------------------------------------
% 1. Filtering the signal in MATLAB using the 'filter' function:

output_signal = filter(coeff,1,s);

%--------------------------------------------------------------------------
% 2. Filtering using MAC for 8 filter coefficients: 

x            = length(coeff);     % filter order + 1 = 9 coefficients
sout         = zeros(size(t));

for i=(x+1):length(t)
    sout(i)  = coeff(1)*s(i-0) + ...
               coeff(2)*s(i-1) + ...
               coeff(3)*s(i-2) + ...
               coeff(4)*s(i-3) + ...
               coeff(5)*s(i-4) + ...
               coeff(6)*s(i-5) + ...
               coeff(7)*s(i-6) + ...
               coeff(8)*s(i-7) + ...
               coeff(9)*s(i-8);
end

%--------------------------------------------------------------------------
% 3. Parmetrized MAC code to work with any filter order:
%    (Hardware Implementation with power of 2 scaling and rounding) 

coeff_scaled = (round(coeff*1000))/1000*1024; % rounding coefficients
x            = length(coeff);
sMAC         = zeros(size(t));

for i=(x+1):length(t)
    for j=1:x
    sMAC(i) = sMAC(i) + coeff_scaled(j)*s(i-j+1); 
    end
end 
sMAC = sMAC/1024;
%--------------------------------------------------------------------------
% Plotting the input signal & the filtered signals in the time domain

subplot(2,2,1)
plot(t,s)
title("Original Signal")
subplot(2,2,2)
plot(t,output_signal)
title("LowPass Filtered Signal")
xlabel("Time in s")
hold on
plot(t,sout);
plot(t,sMAC);
legend ('filter','sout','sMAC')

%-------------------------------------------------------------------------
% Creating the fft for the signals:

f = fs/L*(0:(L/2));

Y = fft(s);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

Y_out = fft(output_signal);
P2_out = abs(Y_out/L);
P1_out = P2_out(1:L/2+1);
P1_out(2:end-1) = 2*P1_out(2:end-1);

y_Verilog = fft(sout);
P2v = abs (y_Verilog/(L));
P1v = P2v(1:(L)/2+1);
P1v(2:end-1) = 2*P1v(2:end-1);


subplot(2,2,3)
stem(f,P1,"LineWidth",2)
title("fft Spectrum in the Positive Frequencies")
xlabel("f (Hz)")
ylabel("|fft(input signal)|")

subplot(2,2,4)
stem(f,P1_out,"LineWidth",2)
title("fft Spectrum in the Positive Frequencies")
xlabel("f (Hz)")
ylabel("|fft(output filtered signal)|")
hold on
stem(f,P1v)

%--------------------------------------------------------------------------
