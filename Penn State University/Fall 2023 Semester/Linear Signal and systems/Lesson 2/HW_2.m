% Name: Lamin Jammeh
% Class: EE480 Online
% Semster: Fall 2023
% HW_2

% Basic Problems


%% **********question 1.1**********

%1.1(a)
t = -1:0.1:1;
x_t = 1 - t;

%plotting the x(t) 
subplot(3,2,1);
plot(t,x_t);
title('x(t)=1-t');
grid on;
xlabel('t');
ylabel('x(t)');

%plotting x(t+1)
%let t+1 = t1
x_t1 = 1-(t+1);
subplot(3,2,2);
plot(t,x_t1);
title('x(t+1)=1-t');
grid on;
xlabel('t');
ylabel('x(t+1)');

%plotting x(t-1)
%let t-1 = t2
x_t2 = 1-(t-1);
subplot(3,2,3);
plot(t,x_t2);
title('x(t-1)=1-t');
grid on;
xlabel('t');
ylabel('x(t-1)');

%plotting x(-t)
%let -t = t3
x_t3 = 1-(-t);
subplot(3,2,4);
plot(t,x_t3);
title('x(-t)=1-t');
grid on;
xlabel('t');
ylabel('x(-t)');


%1.1(b)

%plotting 0.5[x(t)+x(-t)]
%note x_t=x(t)  and  x_t3=x(-t)
signal_addition = 0.5 * (x_t + x_t3);
subplot(3,2,5);
plot(t,signal_addition);
title('signal_ addition=0.5[x(t)+x(-t)]');
grid on;
xlabel('t');
ylabel('signal_ addition');

%plotting 0.5[x(t)-x(-t)]
signal_subtraction = 0.5 * (x_t - x_t3);
subplot(3,2,6);
plot(t,signal_subtraction);
title('signal_ subtraction=0.5[x(t)+x(-t)]');
grid on;
xlabel('t');
ylabel('signal_ subtraction');


%% **********question 1.2**********

%1.2(a)
t = -1:0.1:1;
x_t = t;

%plotting x(t+1)
t1 = t + 1;
x_t1 = t1;
subplot(3,1,1)
plot(t,x_t1);
title('x(t+1)=t');
grid on;
xlabel('t');
ylabel('x(t+1)');

%plotting x(-t-1)
t2 = -t + 1;
x_t2 = t2;
subplot(3,1,2)
plot(t,x_t2);
title('x(-t+1)=t');
grid on;
xlabel('t');
ylabel('x(-t+1)');

%plotting y(t)
y_t = x_t1 + x_t2;
subplot(3,1,3)
plot(t,y_t);
title('y(t)=x(t+1) + x(-t+1)');
grid on;
xlabel('t');
ylabel('y(t)');
