
clear;
clc;
Zl= 1i*0.42;
Zr=1i*0.45;
Vm = 1.032-1i*0.228;
% Vm= Vm_mag(cos(Vm_angle) + 1i*sin(Vm_angle));
Vg=1.00 -1i*0.0;
Vf=(Vg/Zl +Vm/Zr)/(1/Zl +1/Zr)
% Vf = sqrt(2)*(vf)
r = abs(Vf); % Magnitude of z
theta_rad = angle(Vf); % Phase angle of z in radians
theta_deg = rad2deg(theta_rad); % Convert phase angle to degrees

fprintf('Magnitude: %.2f\n', r);
fprintf('Phase angle: %.2f degrees\n', theta_deg);

Zth = (Zl * Zr)/(Zl+Zr)
If=Vf/Zth
I = abs(If); % Magnitude of z
I_theta_rad = angle(If); % Phase angle of z in radians
I_theta_deg = rad2deg(theta_rad); % Convert phase angle to degrees

fprintf('Magnitude: %.2f\n', I);
fprintf('Phase angle: %.2f degrees\n', I_theta_deg);

I_A = 724.68*If
I_Amag = abs(I_A) % Magnitude of z
I_A_theta_rad = angle(I_A) % Phase angle of z in radians
I_A_theta_deg = rad2deg(theta_rad) % Convert phase angle to degrees