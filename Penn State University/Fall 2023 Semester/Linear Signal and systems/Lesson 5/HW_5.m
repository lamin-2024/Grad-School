% Name: Lamin Jammeh
% Class: EE480 Online
% Semster: Fall 2023
% HW_5

% Basic Problems
%%  ********** 3.5b **********
%finding x1(t) 
clear;
clc;
syms t s;
X = (s+2)/(1+(2+s^2));
x = ilaplace(X)


%% ********** question 3.5(c) **********
clear;
clc;
syms t;
z = diff(exp(-t)*heaviside(t))
Z = laplace(z)
Z_simplify = simplifyFraction(Z)

%% ********** question 3.8 **********
clear;
clc;
% ***** Part a *****
% Step 1 define the syms variables
syms t s;
% Step 2 define the x(t)
x = heaviside(t) - 2*heaviside(t-1) + 2*heaviside(t-3) - heaviside(t-4);
% Step 3 plot x(t)
subplot(3,1,1);
fplot(x,[0,10],'r','LineWidth',2);
xlabel('Time (sec)');
ylabel('x(t)');
title('x(t) vs Time');
grid on

% Step 4 differentiate x
x_diff1 = diff(x);
subplot(3,1,2);
fplot(x_diff1,[0,10],'b','LineWidth',2);
xlabel('Time (sec)');
ylabel("d/dt(x(t))");
title("d/dt(x(t)) vs Time");
grid on

% Step 4 differentiate x_diff1
x_diff2 = diff(x_diff1);
subplot(3,1,3);
fplot(x_diff2,[0,10],'g','LineWidth',2);
xlabel('Time (sec)');
ylabel("d2/dt2(x(t))");
title("d2/dt2(x(t)) vs Time");
grid on

% ***** Part b *****
X_s = laplace(x_diff2) % define Laplace transform of d2/dt2 (x(t)

%% ********** 3.9(a) **********
clear;
clc;
% Step 1 define Syms function as s 
syms s;
% define Y(s)
Y = [exp(-2*s)/(s^2 +1)] + [((s+2)^2+2)/(s+2)^3];
y = ilaplace(Y);


%% ********** 3.9(c) **********
% finding the steady state and transient given the out laplace transform
% Y(s)

%find the steady state laplace transform
clear;
clc;
syms t s;
%define the output lapce transform Y(s)
Y = 1/(s*((s+1)^(2) + 4));
%define the inverse laplace transform of Y(s)
y = ilaplace(Y,s,t);
%define the steady steady using the lim as t approches inf
Y_ss = limit(y,t,inf);

%find the transient by subtracting output from steady state response
Y_transient = y - Y_ss;

%% *********** 3.13b **********
clear;
clc;
syms t s;
%define the H(s)
H = (s^2 + 4)/(s*((s+1)^2 + 1));
%define input x(t)
x = cos(2*t)*heaviside(t);
%define X(s)
X = laplace(x);
% Y(s)=H(s)*X(s)
Y = H * X;
y = ilaplace(Y);
%define steady state by using the lim as t approches inf
y_ss = limit(y,t,inf);

%% *********** 3.13c **********
clear;
clc;
syms t s;
%define the H(s)
H = (s^2 + 4)/(s*((s+1)^2 + 1));
%define input x(t)
x = sin(2*t)*heaviside(t);
%define X(s)
X = laplace(x);
% Y(s)=H(s)*X(s)
Y = H * X;
y = ilaplace(Y);
%define steady state by using the lim as t approches inf
y_ss = limit(y,t,inf);

%% *********** 3.13d **********
clear;
clc;
syms t s;
%define the H(s)
H = (s^2 + 4)/(s*((s+1)^2 + 1));
%define input x(t)
x = heaviside(t);
%define X(s)
X = laplace(x);
% Y(s)=H(s)*X(s)
Y = H * X;
y = ilaplace(Y);
%define steady state by using the lim as t approches inf
y_ss = limit(y,t,inf);

%% ********** 3.15a ***********
clear;
clc;
% Note the H(s) =output(s) / input(s) 
syms t s;

% Step find the output laplace S(s)
s_t = (0.5-exp(-t) + 0.5*exp(-2*t))*heaviside(t);% ouput in time domian
S = laplace(s_t);

% Step 2 find the input U(s)
u_t = heaviside(t);
U = laplace(u_t);

% Step 3 find H(s)=S(s)/U(s)
H = S / U;
H_simplify = simplifyFraction(H); % simplified fraction of H(s)

