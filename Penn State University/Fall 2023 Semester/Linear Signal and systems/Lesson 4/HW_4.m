% Name: Lamin Jammeh
% Class: EE480 Online
% Semster: Fall 2023
% HW_4

% Basic Problems
%% ********** question 2.1 **********
% ********** question 2.1(ai)**********
 clear;
 clc;
x = -20:20; %define the range for the X-axis
y = 100 * x; %y(t) @ -10<x(t)<10
y(x>10) = 1000; % y(t) when x(t)>10
y(x<-10) = -1000; % y(t) when x(t)<-10
plot(x, y, 'LineWidth',2); %plot x(t) vs y(t) at all stages
xlabel('x(t)'); %label x-axis
ylabel('y(t)'); %labels y-axis
title('x(t) vs y(t) for Q2.1a'); %assign a plot title
grid on;

%% ********** question 2.1(aii)**********
%test for linearity using the scaling method since there is only one input
%x(t)
%perform the scale test for Output scenario 1 

%Scale Test alpha*y(t) = alpha*S[x(t)]
 clear;
 clc;
x = -10:10; % define x(t) from -10:10
alpha = 10; %scaling factor is 10


y = mySystem1(x); %mySystem1 is a function defined as y=100x(t)
y_alpha = alpha * mySystem1(x);

 %condition for linearity
 System_is_Linaer = isequal(y_alpha,alpha * y); 
  if System_is_Linaer
      disp('The System is Linear @ -10<x(t)<10');
  else
      disp('System is not Linear @ -10<x(t)<10');
  end

 %% ********** question 2.1(b) **********
 clear;
 clc;
 %notee am changing the y(t) from 100x(t) to be 2x(t) for better resultion on input x(t)
 t = -2:0.001:4; %range of value for t
 u = heaviside(t); % use unit step function already build in matlab as heaviside
 x = 20 * cos(2*pi*t) .* u; %define Input of the system with the sinusoid wave
 y = 2.*(x);%define the output of the system with the system
 figure;
 plot(t,x,'r');
 hold on;
 plot(t,y,'b','LineWidth',2);
 xlabel('t');
 ylabel('Amplitude');
 legend('input=x(t)','output=y(t)')
 title('x(t) vs y(t)');
 grid on;
hold off;

 % *********** question 2.1(c) **********

 t = -2:0.001:4; %range of value for t
 u1 = heaviside(t-2); % use unit step function already build in matlab as heaviside
 x1 = 20 * cos(2*pi*t-2) .* u1; %define Input of the system with the sinusoid wave
 y1 = 2.*(x1);%define the output of the system with the system
 figure;
 plot(t,x1,'r');
 hold on;
 plot(t,y1,'b','LineWidth',2);
 xlabel('t');
 ylabel('Amplitude');
 legend('input=x1(t)','output=y1(t)')
 title('x1(t) vs y1(t)');
 grid on;
 hold off;

 % ********** compare the y(t) to y1(t) or the delayed response **********
 figure;
 plot(t,y,'g','LineWidth',2);
 hold on;
 plot(t,y1,'r','LineWidth',3);
 xlabel('t');
 ylabel('Amplitude');
  legend('input=x1(t)','output=y1(t)')
 title('y(t) vs y1(t)');
 grid on;
 hold off;

 %% ********** question 2.5(b) **********
 clear;
 clc
t = -10:0.01:10; % t range should show peak of y(t) of not increase the range 
y = 1/2 .* (1-exp(-2.*t)) .* heaviside(t); %use matrix multiplication '.*' to include all values of t
plot(t,y,'LineWidth',2);
xlabel('t');
ylabel('y(t)');
title('y(t) plot for question 2.5(b)')
grid on;

%% ********** question 2.22(a) **********
clear;
clc;
% Vo(t) = R(t)Vi(t)
t = 0:0.01:0.2; % time range 
u = heaviside (t);
R = (1 + 0.5*cos(20*pi*t)).*u;
Vi = 1; %input voltage 
Vo = -R * Vi;
figure;
plot(t,Vo, 'LineWidth',2);
xlabel('t');
ylabel('Vo');
title('Output Vo = R * Vi for Q2.22a')
grid on;

% ********** question 2.22(b) **********
%if the switch close at t0=50msec
% Vo(t+(0.05) = R(t+0.05)Vi(t+0.05)
t0 = 0.05;        % Starting time in seconds (50 ms)
t1 = t0:0.01:0.2; % Time vector from t0 to 0.2 seconds with a step of 1 ms

u1 = heaviside (t0); % Unit step function starting at t0


% Calculate the values of R(t) for the given time vector:
R1 = (1 + 0.5 * cos(20 * pi* (t1 - t0))) .* u1;

% Calculate Vo(t) using the equation Vo(t) = R(t) * Vi(t):
Vo1 = -R1 .* Vi;

% Plot Vo(t):
figure;
plot(t1, Vo1);
xlabel('Time (s)');
ylabel('Vo(t) (V)');
title('Plot of Vo(t) with t0 = 50 ms for Q2.22b');
grid on;



% ********** Reason for Time invariant **********

% the unit step response u(t) makes the system Time Invariant because it
% only allows the system to be active at t>=0 irrespective of the anytime
% shifting

% Vi(t) =1V which is time independent so the input voltage of the system won't change with time

%R(t) has a cos(20pit) which is equal to cos(10*2pi*t) with make the R(t)
%time invariant sine cos(2pi)=cos(0)=1 and any number multiply by zero is
%zero regarles of time shifting 

%% ********** question 2.25 **********
clear;
clc;
% Note the Impulse response concoluted with the Input of the system gives
% the output
%Step 1 convolute h(t) with x(t)
%Step 2 Apply the diode effect 

% Define Impulse Response h(t)=e^(-2t).u(t)
figure;
t = 0:0.001:20;
u = heaviside(t); % u(t)
h = exp(-2*t).*u;
subplot(2,2,1)
plot(t,h,'LineWidth',2);
xlabel('Time (s)');
ylabel('h(t)');
title("Impulse Response h(t)=e^(-2t).u(t)");
grid on;

% Define input x1(t)=cos(2pi*t)[u(t)-u(t-20)]
u1 = heaviside(t-20); % defines u(t-20)
x1_t = cos(2*pi*t).*(u-u1); %Defines x1(t)
subplot(2,2,2)
plot(t,x1_t,'LineWidth',2);
xlabel('Time (s)');
ylabel('x1(t)');
title("Input x1(t)=cos(2pi*t)[u(t)-u(t-20)]");
grid on;

% Step 1 convolute x(t) with h(t)
y_t = conv(x1_t,h,"same"); % Output without diode effect
subplot(2,2,3)
plot(t,y_t,'LineWidth',2);
xlabel('Time (s)');
ylabel('y(t)');
title('Output without Diode effect');
grid on;

% Apply Diode effect this will clip all negative values of y(t)
d = max(y_t,0); % Diode effect
y1_t=(y_t).*d;   % Apply diode effect to the output
subplot(2,2,4)
plot(t,y1_t,'LineWidth',2);
xlabel('Time (s)');
ylabel('y1(t)');
title('Output with Diode effect');
grid on;


% ********** using input x2(t) **********

% Define input x2(t)=sin(pi*t)e^(-20t)[u(t)-u(t-20)]
figure;
x2_t = sin(pi*t).*exp(-20*t).*(u-u1); %Defines x1(t)
subplot(2,2,1)
plot(t,x2_t,'LineWidth',2);
xlabel('Time (s)');
ylabel('x2(t)');
title("Input x2(t)=sin(pi*t)e^(-20t)[u(t)-u(t-20)]");
grid on;

% Step 1 convolute x(t) with h(t)
y_t2 = conv(x2_t,h,"same"); % Output without diode effect
subplot(2,2,2)
plot(t,y_t2,'LineWidth',2);
xlabel('Time (s)');
ylabel('y(t)');
title('Output without Diode effect');
grid on;

% Apply Diode effect this will clip all negative values of y(t)
d = max(y_t2,0); % Diode effect
y2_t=(y_t2).*d;   % Apply diode effect to the output
subplot(2,2,3)
plot(t,y2_t,'LineWidth',2);
xlabel('Time (s)');
ylabel('y2(t)');
title('Output with Diode effect');
grid on;

% ********** using input x3(t) **********
%input x3(t)=r(t)-2r(t-2)+r(t-4)

% Step 1 define input x3(t) into 3 sections r(t),-2r(t-2), and r(t-4)
figure;
x3(t >= 0) = 1; % defines the r(t) as unit step
x3(t >= 2) = -2 * exp(-2 * (t(t >= 2)-2)); % defines -2r(t-2) @t>=2
x3(t >= 4) = exp(-2*(t(t >= 4)-4)); % defines r(t-4) @t>=4

subplot(3,1,1)
plot(t,x3,'LineWidth',2);
xlabel('Time (s)');
ylabel('x3(t)');
title("Input x3(t)=r(t)-2r(t-2)+r(t-4)");
grid on;

% Step2 defines output y3(t) for input x3(t)
y3 = conv(x3, h, 'full'); % convolute x3(t)*h(t) for all parts of x3(t)

y3 = y3(1:length(t)); % define length of y3 to be the same as range of t

subplot(3,1,2)
plot(t,y3,'LineWidth',2);
xlabel('Time (s)');
ylabel('y(t)');
title('Output without Diode effect');
grid on;

% Step3 Apply Diode effect this will clip all negative values of y(t)
d = max(y3,0); % Diode effect
y3_t=(y3).*d;   % Apply diode effect to the output
subplot(3,1,3)
plot(t,y3_t,'LineWidth',2);
xlabel('Time (s)');
ylabel('y3(t)');
title('Output with Diode effect');
grid on;

