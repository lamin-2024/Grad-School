% Eg1
clear;
clc;
% Step 1 define syms as t as real t and s as complex laplace
syms t s;
% Step 2 define the function to be transform to laplace transform
u = heaviside(t); %define u(t)
%Step 3 perofm Laplace Transform
u = laplace(u); % define U(s)
%%
% Eg 2
clear;
clc;
% Step 1 define syms as t as real t and s as complex laplace
syms t s;
% Step 2 define the function to be transform to laplace transform
p=heaviside(t)-heaviside(t-1); % define p(t)=u(t)-u(t-1)
%Step 3 perofm Laplace Transform
p=laplace(p); % defien P(s)
%% ********** Eg3 **********
clear;
clc;
%find Laplace of x(t)=e^(-t)*u(t)
% Step 1
syms t ;%define syms as t and s 
%Step 2
x = exp(-t);% * heaviside(t); %defien x(t)=e^(-t)*u(t)
% Step 3
X = laplace(x);

%find Laplace of y(t)=e^(-t)*cos(10t)*u(t)
y = exp(-t) * cos(10*t) * heaviside(t);
Y = laplace(x);

%Plot x and y
%define x-axis
figure;
subplot(2,2,1);
fplot([0,5],x);
axis([0 5,0 1.1]);
numx = [0 1];
denx = [1 1];