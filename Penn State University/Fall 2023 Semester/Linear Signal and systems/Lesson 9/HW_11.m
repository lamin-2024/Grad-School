% Name: Lamin Jammeh
% Class: EE480 Online
% Semster: Fall 2023
% HW_11

% Basic Problems
%% *********** 9.29 ***********
clear;
clc;
n = 0:50;
x_0 = 0; x_1 = 1; x_2 = 2; %defeine the give x[n] values
x_i = [x_0 x_1 x_2];% assigns the 3 x[n] values in a [1x3] matrix
x_ii = zeros(1,47); %create an empty matric of [1x47]
x = [x_i x_ii]; %combine the 2 matrices x_i and x_ii to form [1x50] matrix
%create aloop to calculate the rest fo the x[n] values
for i = 3:50
    x(i+1) = x(i-2) + x(i);
end
%plot the x[n] using the stem function
stem(n,x,'r','LineWidth',2)
xlabel('n')
ylabel('x[n]')
title('Q9.29 plot of x[n] from n=0:50')

%% ********** 9.30a ************
clear;
clc;
 n = -5:20;
 x = 0.5.^(n) .* heaviside(n); % defien x[n]
 % plot x[n] using a stem function
 stem(n,x,'b','LineWidth',2);
 xlabel('n');
 ylabel('x[n]');
 title('Q9.30 plot of x[n] for n=-5:20')

 % ********** 9.30b ***********
 %note since x[n] has unit step the singal is zero at n<0 therefore the
 %energy will be define from 0:20
 n_e = 0:20;
X =  0.5.^(n_e);
%calculate the energy of signal x[n]
E_x = sum((abs(X)).^2);

%% ********** 9.32a **********
clear;
clc;
% STEP1 defien the t range and x(t)
t = 0:0.1:1;
x = 1-t;
% STEP2 define n using the Ts and t
T_s = 0.25;
n = t/T_s;
%STEP3 define the x[n]=x(nxTs)
x_n = 1-(n*T_s);
% STEP4 define x[-n] by flipping the x[n] matrix horizontally
x_n_neg = fliplr(x_n);
%Plot x[n] and x[-n]
figure
stem(n,x_n,'r','LineWidth',2)
hold on
stem(-n,x_n_neg,'b','LineWidth',2)
xlabel('-n:n');
ylabel('x[-n]&x[n]')
legend('x[n]','x[-n]');
title('plot of x[n] and x[-n]')
hold off

% ********** 9.32b **********
%determine the even component of x[n]
x_even = 0.5.*(x_n + x_n_neg); %x_e = 0.5(x[n] + x[-n])
%determine the odd component of the x[n]
x_odd = 0.5.*(x_n - x_n_neg); % x_o = 0.5(x[n] - x[-n])
%plot the even and odd component using stem function
figure
stem(n,x_even,'r','LineWidth',2)
hold on
stem(n,x_odd,'b','LineWidth',2)
xlabel('n');
ylabel('x_e & x_o')
title('Plot of Even and Odd components of x[n]')
legend('x_e[n]','x_o[n]');
hold off;

% ********** 9.32c **********
x_sum = x_even + x_odd; %combine the even and odd componen to form x_sum
figure 
subplot(2,1,1)
stem(n,x_sum,'r','LineWidth',2);
xlabel('n');
ylabel('x_sum')
title('Plot of Even + Odd components of x[n]')
grid on;
subplot(2,1,2)
stem(n,x_n,'b','LineWidth',2);
xlabel('n');
ylabel('x_sum')
title('Plot of x[n]')
grid on;

%% ********** 9.34a **********
clear;
clc;
n = -10:0.1:10; %define a range for n
x_n = cos(2*pi*n/7); %define x[n]
% down-sampling or compress x[n]
z_n = cos(2*pi*2*n/7); %define z[n] = x[2n]

% plot x[n] and z[n]
figure
subplot(2,1,1)
stem(n,x_n)
xlabel('n');
ylabel('x[n]')
title('Plot of x[n]')

subplot(2,1,2)
stem(n,z_n)
xlabel('n');
ylabel('z[n]')
title('Plot of z[n] = x[2n] or (x[n] compressed or down-sampled by 2')

% ********** 9.34b **********
% up-sampling or expand x[n]
y_n = cos(2*pi*n/14); % y[n] = x[n/2] = cos(2*pi*2*n/(7*2))
figure
subplot(2,1,1)
stem(n,x_n)
xlabel('n');
ylabel('x[n]')
title('Plot of x[n]')

subplot(2,1,2)
stem(n,y_n)
xlabel('n');
ylabel('y[n]')
title('Plot of y[n] = x[n/2] or (x[n] expanded or up-sampled by 2') 
