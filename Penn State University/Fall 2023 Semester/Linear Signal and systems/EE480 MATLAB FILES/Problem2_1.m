clc;
clear all;
                %problem 2.1 A

x=-10:1:10;      % -10<= x(t) <= 10
y= 100*x;        % y(t)= 100x(t)
figure(1)
plot(x,y);
hold on
x=10:1:25;       % 10<= x(t) <= 20
y= 1000*(1+x-x); %y(t) = 1000x(t)
figure(1)
plot(x,y);
hold on
x=-25:1:-10;        % -20<= x(t) <= -10
y= -1000*(1+x-x); %y(t) = -1000x(t)
figure(1)
plot(x,y);
axis([-25 25 -2500 2500])
grid
legend('y(t)= 100x(t);  -10<x(t)<10','y(t)= 1000; x(t)> 10', 'y(t)= -1000; x(t)<-10')
xlabel('x(t)')
ylabel('y(t)')

% 2.1 b

t=-2:0.1:4;     % -2< t <4 
y1=20*cos(2*pi*t).*heaviside(t); % x(t)=20cos(2pit)u(t)
figure(2)
subplot(221)      % plot 4 grap on one figure
plot(t,y1)
axis([-2 4 -30 30])
grid
legend('x(t)= 20cos(2pit)u(t) ')
xlabel('t')
ylabel('x(t)')

t=-2:0.1:4;     % -2< t <4 
y2=2000*cos(2*pi*t).*heaviside(t); % y(t)=2000cos(2pit)u(t)
subplot(222)
plot(t,y2)
axis([-2 4 -2200 2200])
grid
legend('y(t)= 2000cos(2pit)u(t) ')
xlabel('t')
ylabel('y(t)')

% 2.1 c

t=-2:0.1:4;     % -2< t <4 
y3=20*cos(2*pi*(t-2)).*heaviside(t-2); % x(t)=20cos(2pit-2)u(t-2)
subplot(223)
plot(t,y3)
axis([-2 4 -30 30])
grid
legend('x(t-2)= 20cos(2pi(t-2))u(t-2) ')
xlabel('t')
ylabel('x(t-2)')

t=-2:0.1:4;     % -2< t <4 
y4=2000*cos(2*pi*(t-2)).*heaviside(t-2); % y(t)=2000cos(2pit-2)u(t-2)
subplot(224)
plot(t,y4)
axis([-2 4 -2200 2200])
grid
legend('y(t-2)= 2000cos(2pi(t-2))u(t-2) ')
xlabel('t')
ylabel('y(t-2)')

