% Name: Lamin Jammeh
% Class: EE480 Online
% Semster: Fall 2023
% HW_3

% Basic Problems
%% ********** question 1.24 **********
clear
clc
% grab enough sample period of the signal and expand if necessary
t = -4:0.01:4; %sample from -2 to 2 in steps of 0.01
x_t = cos(pi * t); % define the x(t)
plot(t,x_t, 'b',LineWidth=2); % x(t) is the blue line
hold on;

%expanded signal 
x_t2 = cos(pi * t/2); % define x(t/2)
plot(t,x_t2, 'r',LineWidth=3); % x(t/2) is the red line 

%compressed signal
x_t3 = cos(pi * 2*t); %define x(2t)
plot (t,x_t3, 'g',LineWidth=4); % x(2t) is the green line

%label the graph
title('signal expansion and compression');
xlabel('t_ sec');
legend('x(t)','x(t/2)','x(2t)');
grid on;
hold off;


%% ********** question 1.29_a **********
clear
clc
f_s = 20000;
t = 0:0.05:40; %sampling period
A = 1;
omega = 2;
s_t = (t.^2)/4;
y_t = A * cos(omega * t + s_t);
plot(t,y_t)
sound(y_t,f_s)
%% ********** question 1.29_b **********
clear
clc
f_s = 20000;
t = 0:0.05:40; %sampling period
A = 1;
omega = 2;
s_t = -2 * sin(t);
y_t = A * cos(omega * t + s_t);
plot(t,y_t)
sound(y_t,f_s)

