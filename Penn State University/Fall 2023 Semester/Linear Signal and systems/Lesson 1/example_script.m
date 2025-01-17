% This is a comment

% Initialize Variable
A=1; % note the ; surpress the statement 
B=2;
C=3;
D=4;

%% Display Variable Note the double %% makes breaks the code into sections
A
B
C
D

%% Math

Sum = A+B+C+D

Product = A*B*C*D

%% Pg38 example
clear all:clc
f=input('input frequency');
A=input('amplitude');
theta=input('phase in degree');
omega=2*pi*f; %freq rad/sec
tmax=1/f;     %one period
time=[]; n=0; %initialization
figure(1)
for t=0:tmax/36:tmax %loop
    z=A*exp(j*(omega*t+theta*pi/180));
    x=real(z); y=imag(z); %projection
    time=[time t];        %sequence
    subplot(1,2,1)
    compass(x,y);         %plot vector
    axis('square')        %square axis
    subplot(1,2,2)
    plot(n*tmax/36,x,'r') %plot x point in red
    axis('square');
    axis([0 tmax -1.1*A 1.1*A]); grid %bounds;grid
    hold on
    if n==0;                 %execute next statement when n=0
        pause(0);
    else
        pause(0.1);
    end
    hold off
end
