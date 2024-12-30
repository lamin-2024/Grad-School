%%*************Transient current plot *******************************
clear;
clc;
num = 1000;
t = linspace(0,1,num);
ydc = 9.43*exp(-6.67*t);
yss = 0.76*sin(377*t);
ysub = 1.67*exp(-20*t).*sin(377*t);
ytran = 4.24*exp(-0.833*t).*sin(377*t);
y = sqrt(2)*(ysub + ytran + yss) + ydc;
plot(t,y);