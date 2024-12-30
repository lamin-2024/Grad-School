% Name: Lamin Jammeh
% Class: EE480 Online
% Semster: Fall 2023
% MIDTERM
%%


clear;
clc
% Define the time values (t)
t = 0:1; % Assuming a range of -5 to 5 for t with a step size of 0.1

% Define the function g(t) = t
g = t;

% Define the function k(t) = -t (reflection of g(t))
k = -t;

% Define the delay (3 units)
delay = 3;

% Calculate the delayed signal y(t)
y = k + delay;

% Plot g(t), k(t), and y(t)
figure;
plot(t, g, 'b', 'LineWidth', 2); % Blue curve for g(t)
hold on;
plot(t, k, 'r', 'LineWidth', 2); % Red curve for k(t)
plot(t + delay, y, 'g', 'LineWidth', 2); % Green curve for y(t)

% Add labels and a legend
xlabel('t');
ylabel('g(t), k(t), and y(t)');
legend('g(t) = t', 'k(t) = -t', 'y(t) = k(t - 3)');

% Set plot properties
grid on;
%axis([-5 8 -8 8]); % Adjust axis limits as needed

% Add title
title('Plot of g(t), k(t), and y(t) in MATLAB');

% Display the plot
hold off;

%% *********** Q1 *********
clear;
clc;

t= 0:1;
g_t = t
k_t = -t
y_t = k_t+3
hold on
plot(t,g_t,'r')
plot(t,k_t,'g')
plot(t+3,y_t,'b')
hold off
title('Queestion 1 system1 g(t) to y(t)');
xlabel('t');
legend('g(t) = t','k(t) = g(-t)','y(t) = k(t+3)');
grid on;

%% *********** Q1a *********
t= 0:1;
g_t = t
m_t = g_t+3
z_t = -m_t
hold on
plot(t,g_t,'r')
plot(t,m_t,'g')
plot(t,z_t,'b')
hold off
title('Queestion 1 system2 g(t) to z(t)');
xlabel('t');
legend('g(t) = t','m(t) = g(t+3)','z(t) = m(-t)');
grid on;
%% *********** Q2 *********
t = 0:0.1:1;
x_t = t;
x_t3 = t/3;
subplot(2,1,1)
plot(t,x_t);
title('X(t Q2)');
xlabel('t');
grid on;
subplot(2,1,2)
plot(t,x_t3);
title('X(t/3) Q2');
xlabel('t');
grid on;

% x(t) is compressed by 1/3 on the y-axis

%% ********** Q3 x(t) & p(t) *********
clear;
clc;
t = 0:0.01:100;
p_t = 20*(heaviside(t) - heaviside(t-40)) - 10*(heaviside(t-40)-heaviside(t-60));
P = 1.1*abs(min(p_t))
x_t = (p_t + P).*cos(2.*pi.*t)
subplot(2,1,1)
plot(t,p_t,'r',"LineWidth",2); % Plot x(t) as a function plot
xlabel('Time (sec)');
ylabel("p(t)");
title("p(t) for 0<=t<=100");

subplot(2,1,2)
plot(t,x_t,'r',"LineWidth",2); % Plot x(t) as a function plot
xlabel('Time (sec)');
ylabel("x(t)");
title("x(t) for 0<=t<=100");
%% ********** Q3 y(t) *********
clear;
clc;
t = 0:0.01:100;
p_t = 20*(heaviside(t) - heaviside(t-40)) - 10*(heaviside(t-40)-heaviside(t-60));
P = 1.1*abs(min(p_t))
x_t = (p_t + P).*cos(2.*pi.*t);
y_t = abs(x_t);
plot(t,y_t,'r',"LineWidth",2); % Plot x(t) as a function plot
xlabel('Time (sec)');
ylabel("y(t)");
title("y(t) for 0<=t<=100");
ylim([-1,45]) % assign limits to y axis 

%% ********** Q3 z(t) *********
clear;
clc;
t = 0:0.01:100;
p_t = 20*(heaviside(t) - heaviside(t-40)) - 10*(heaviside(t-40)-heaviside(t-60));
P = 1.1*abs(min(p_t));
x_t = (p_t + P).*cos(2.*pi.*t);
y = abs(x_t);
T_s = 0.01;
h = exp(-0.8.*t).*heaviside(t)
% i wil be using the Transfer function with Laplace for Low Pass (z(t)

z_t = conv(y,h,'same')*T_s;
disp(z_t)
plot(t,z_t,'r',"LineWidth",2); % Plot x(t) as a function plot
xlabel('Time (sec)');
ylabel("z(t)");
title("z(t) for 0<=t<=100");
%% ********** Q3 z(t)-P *********
clear;
clc;
t = 0:0.01:100;
p_t = 20*(heaviside(t) - heaviside(t-40)) - 10*(heaviside(t-40)-heaviside(t-60));
P = 1.1*abs(min(p_t));
x_t = (p_t + P).*cos(2.*pi.*t);
y = abs(x_t);
T_s = 0.01;
h = exp(-0.8.*t).*heaviside(t)
% i wil be using the Transfer function with Laplace for Low Pass (z(t)

z_t = conv(y,h,'same')*T_s;
z_p = z_t - P
plot(t,z_p,'r',"LineWidth",2); % Plot x(t) as a function plot
xlabel('Time (sec)');
ylabel("z(t)-P");
title("z(t)-P for 0<=t<=100");
%% ********** Q4 **********
clear;
clc;
syms t s;
m = pi/2
X_s = 1 / ((s+3-j*(m))*(s+3+j*(m))*(s));
x_t = ilaplace(X_s)
fplot(x_t,[0,5],'r',"LineWidth",2); % Plot x(t) as a function plot
xlabel('Time (sec)');
ylabel("x(t)");
title("x(t) for 0<=t<=5");
ylim([0,0.1]) % assign limits to y axis 
grid on;

%% ********** Q5 **********
clear;
clc;
syms t s;
%for input x(t) = u(t)
Y_s = (1/s + s + 0.5)/(s^2 +0.5*s+0.15);
y_t = ilaplace(Y_s)

%for input x(t) = 2u(t)
Y_s1 = (1/s + s + 0.5)/(s^2 +0.5*s+0.15);
y_t1 = ilaplace(Y_s1)