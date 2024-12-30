% Name: Lamin Jammeh
% Class: EE480 Online
% Semster: Fall 2023
% HW_1

% Basic Problems


%% **********questions 0.1**********

% 0.1(a)
z = 8 + j*3;
v = 9 - j*2;

% (a)i Re(z) + Im(v)
i = real(z) + imag(v);

% (a)ii |z+v|
ii = abs(z+v);

% (a)iii |zv|
iii = abs(z*v);

% (a)iv <z + <v
iv = angle(z) + angle(v);

% (a)v |v/z|
v = abs(v/z);

% (a)vi <(v/z)
vi = angle(v/z);

%%
% (b) trig and polar forms

z = 8 + j*3;
v = 9 - j*2;

% using this conversion were if z = x + y*j in complex form
% z = real[cos(phase) + isin(phase)] where real = |z| phase = angle(z) in g=degree

% (b)i z+v
b_i = z + v;
step1 = abs(b_i);
step2 = rad2deg(angle(b_i)); %change radian to degree
polar_bi = step1*(cos(step2) + i*sin(step2));

%%
z = 8 + j*3;
v = 9 - j*2;
% (b)ii z*v
b_ii = z*v;
step1 = abs(b_ii);
step2 = rad2deg(angle(b_ii));
polar_bii = step1*(cos(step2) + i*sin(step2));

%%
% z^* complex conjugate
z = 8 + j*3;

% (b)iii z^*
b_iii = conj(z);
step1 = abs(b_iii);
step2 = rad2deg(angle(b_iii));
polar_biii = step1*(cos(step2) + i*sin(step2));

%%
z = 8 + j*3;

% (b)iv zz^*
b_iv = conj(z*z);
step1 = abs(b_iv);
step2 = rad2deg(angle(b_iv));
polar_biv = step1*(cos(step2) + i*sin(step2));

%%
z = 8 + j*3;
v = 9 - j*2;
% (b)v z-v
b_v = z - v;
step1 = abs(b_v);
step2 = rad2deg(angle(b_v));
polar_bv = step1*(cos(step2) + i*sin(step2));



%% **********questions 0.2**********
%using the concept that z=x+iy=R(cos(phase)+isin(phase))=re^(i(phase))
%where R is Real and and i factors are Imaginary

% (a) z=6e^(j*pi/4)
% i=Re(z)
z = 6*exp(1)^(j*pi/4);
a_i = real(z);
a_ii = imag(z);

%%
% (b) z=8+j3 and v= 9-j2
z = 8 + j*3;
v = 9- j*2;
i = 0.5*(z + conj(z)); %True
ii = -0.5*j*(v-conj(v));%True

iii_a = real(z + conj(v));
iii_b = real(z + v);
%Therefore [iii_a = iii_b]

iv_a = imag(z + conj(v));
iv_b = imag(z - v);
%Therefor [iv_a = iv_b]



%% **********question 0.9**********
z = 1 + j*1;
w = exp(1)^z;
%(a)
a_i = log(w);
a_ii = real(w);
a_iii = imag(w);

%(b)
b = w + conj(w);

% (c)
c_i = abs(w);
c_ii = angle(w);
c_iii = (abs(w))^2;

% (d) Euler's identiy 
%{
w = e^z
z = 1 + j1
subtitude for z in w
w = e^(1 + j1)
w = e^1 * e^j1
w = 2.72 * e^j1
converting from polar to rectangular
r * e^j(angle) = r[cos(angle) + jsin(angle)]
therefore w = 2.72e^j1 = 2.72[cos(1) + j*sin(1)]
%}



%% **********question 0.10(e)**********

% Phasor = Amplitude of wave < [phase angle in radians]

% i = 4 * cos(2*t + pi/3);
% *****change (i) to Phasor (I)*****
% I = 4 < pi/3 for Phasor**********************

% ii = -4 * sin(2*t + pi/3);
% *****change (ii) to Phasor (II)*****
% II = -4 < pi/3 for Phasor********************

% iii = i + ii
% chnage both 1 and ii to rectangular form first

% changing i to comlex form
angle_I = rad2deg(pi/3); % change phase angle to deg
Re_I = 4*cos(angle_I); % determine the real part of I
Im_I = j*4*sin(angle_I); % determine the imaginary part of I
I = Re_I + Im_I; % new i = I in complex form

% changing ii to comlex form
% change ii to cosine wave by 
    %chnage ii to Positive signal by adding 180degrees or pi
    %change ii to cosine to subtracting 90degrees or pi/2
% New_phase_angle = pi/3 + pi -pi/2 = 5pi/6
% ii_new = 4 * cos(2*t + 5*pi/6);
% *****change ii_new to Phasor (II_new)*****
% II_new = 4 < 5pi/6 for Phasor*****************
angle_II = rad2deg(5*pi/6); % change phase angle to deg
Re_II = 4*cos(angle_II); % determine the real part of I
Im_II = j*4*sin(angle_II); % determine the imaginary part of I
II = Re_II + Im_II;

III = I + II; % III = -1.0126 - j4.0787



%% ***********question 0..13 Discrete-time signals over a Ts period***********

% signal x(t) = 4cos(2pi*t) 
% -inf<t<inf and x(n) =x(nTs) = x(t)|t=nTs
% using nyquist theorem fs >= 2f

%{
w = 2*pi*f  where f = frequency
fs >= f     where fs = sampling frequency
fs = 1/Ts   where Ts = sampling period

for x(t) = 4cos(2*pi*t)
2*pi*f = 2*pi
f = 1Hz

therefore for signal to be good fs >= 2Hz

*********Q 0.13(i)**********
Ts = 0.1
fs = 1/0.1 = 10Hz 
fs >= 10Hz
Signal is still good

*********Q 0.13(ii)**********
Ts = 0.5
fs = 1/0.5 = 2Hz 
fs >= 2Hz
Signal is still good

*********Q 0.13(ii)**********
Ts = 1
fs = 1/1 = 1Hz 
fs >= 1Hz
Signal is lost at Ts = 1
%}

% ******Part 2 of question 0.13 *********
Ts = 10^-4; % Sample Period or t interval
t = 0:Ts:3; % sample range from 0 to 3 in steps of 10^-4
x_t = 4*cos(2*pi*t); %function to be ploted
subplot(4,1,1)
stem(t,x_t); % stem plot with t on the x-axis and x(t) on y-axis
xlabel('t_ sec');
ylabel('x(t)');
title('x(t)=4cos(2pi*t) @ Ts=10^-4');

subplot(4,1,2)
Ts_i = 0.1; % Sample Period or t interval
t = 0:Ts_i:3; % sample range from 0 to 3 in steps of 10^-4
x_t = 4*cos(2*pi*t); %function to be ploted
stem(t,x_t); % stem plot with t on the x-axis and x(t) on y-axis
xlabel('t_ sec');
ylabel('x(t)');
title('x(t)=4cos(2pi*t) @ Ts=0.1')

subplot(4,1,3)
Ts_ii = 0.5; % Sample Period or t interval
t = 0:Ts_ii:3; % sample range from 0 to 3 in steps of 10^-4
x_t = 4*cos(2*pi*t); %function to be ploted
stem(t,x_t); % stem plot with t on the x-axis and x(t) on y-axis
xlabel('t_ sec');
ylabel('x(t)');
title('x(t)=4cos(2pi*t) @ Ts=0.5')

subplot(4,1,4)
Ts_iii = 1; % Sample Period or t interval
t = 0:Ts_iii:3; % sample range from 0 to 3 in steps of 10^-4
x_t = 4*cos(2*pi*t); %function to be ploted
stem(t,x_t); % stem plot with t on the x-axis and x(t) on y-axis
xlabel('t_ sec');
ylabel('x(t)');
title('x(t)=4cos(2pi*t) @ Ts=1')



%% ************question 0.16************

%% ************ question 0.19 integrals and Sums**********
f_t = @(t) t;
A = integral(f_t,0,1); % integrate tdt between 0 and 1
% A = 1/2 - 0/2 = 1/2 *********

B = integral(f_t,0,0.5); % integrate tdt between 0 and 0.5
% B = 1/8 -0/2 = 1/8 **********

C = integral(f_t,0.5,1); % integrate tdt between 0.5 and 1
% B = 1/2 - 1/8 = 3/8 **********

% therefore A = B + C
% A = 1/8 + 3/8 = 4/8 = 1/2

% S = E(n)  n=0 to 100
n_interval = (100-0)/100; 
n = 0:n_interval:100;
S = sum(n);

% for [n=0 to n=50] + [n=50 to n=100]
n1 = 0:n_interval:50;
n2 = 50:n_interval:100;
S_1 = sum(n1) + sum(n2);

% for [n=0 to n=50] + [n=51 to n=100]
n3 = 0:n_interval:50;
n4 = 51:n_interval:100;
S_2 = sum(n3) + sum(n4);

% Therefore S = S_2 = 5050 **********************



%% **********question 0.21 Algebra of complex numbers**********
z = 1 + j;
w = -1 + j;
v = -1 - j;
u = 1 - j;

% (a) complex to vector notation (mag and direction or angle)
% (x,y) that coresponds with |z| = (1,1)
%|z| = sqrt(1^2 + 1^2) = sqrt(2);
z_magnitude = abs(z); %magnitude of the vector
% angle of the vector z
% tan^-1 = 1/1 = 1 = 0.7854rad = 45 degrees
angle_z = rad2deg(angle(z)); % angle of vector z in degrees

% (b)
%{
since all the complex number are in vector form they can be added
directly [sum(Re) + sum(Im)]
final sum = (1-1-1+1) + j(1+1-1-1) = 0 + j0 =0
%}
% let t be the sume of the complex numbers
T = u + v + w + z; 
%{
all these vectors are equal in manitude but 2 are in opposite direction or
angle to the other 2 therefore they will cancel each other out
%}

Vectors = [z,w,v,u,T]; %list of vectors or complex numbers to be plotted
compass(Vectors); % compass function
labels = {'z_ line','w_ line','v_ line','u_ line','T_ line'};
legend(labels);






