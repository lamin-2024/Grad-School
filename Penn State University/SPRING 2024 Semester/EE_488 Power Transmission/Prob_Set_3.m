%Lamin Jammeh
%EE488 Spring 2024
%Problem Set3
%% ************** Q1 ****************************
clear;
clc;

% Define the known  P, Q, V @ each Bus in p.u
V = [1.0+0*1i 1.0+0*1i 1.0+0*1i];
P = [4 -1.5 -0.2];
Q = [0 -0.3 -0.28];

% define impedance Z @ each line in p.u
Z_base = 1.9;
Z12 = 0.076 + 1i*0.38;   Z13 = 0.057 + 1i*0.285; Z23 = 0.019 + 1i*0.057;
Z12 = Z12/Z_base;  Z13 = Z13/Z_base;  Z23 = Z23/Z_base;

% define admittance Y @ each line in p.u
Y11 = 1/Z12 + 1/Z13; Y22 = 1/Z12 + 1/Z23; Y33 = 1/Z23 + 1/Z13;
Y12 = -1/Z12;  Y21 = Y12; 
Y13 = -1/Z13;  Y31 = Y13;
Y23 = -1/Z23;  Y32 = Y23;

Y = [Y11, Y12, Y13;  Y21, Y22, Y23;  Y31, Y32, Y33]

% Conditions for iteration
tol = 0.0001;  err = 1; old = V; count = 0;

%________________ Iteration loop___________________
while (err>tol)
    count = count+1;
    P = [0 -1.5 -0.2];  Q = [0 -0.3 -0.28];
    for k=1
        for n=1:3
            P(k) = P(k)+abs(Y(k,n))*abs(V(n))*cos(angle(V(k))-angle(V(n))-angle(Y(k,n)));
            Q(k) = Q(k)+abs(Y(k,n))*abs(V(n))*sin(angle(V(k))-angle(V(n))-angle(Y(k,n)));
        end
        P(k) = abs(V(k))*P(k); Q(k) = abs(V(k))*Q(k);
    end
    P(2) = P(1,2); Q(2) = Q(1,2);  %this set the fix P and Q values @ bus 2
    P(3) = P(1,3); Q(3) = Q(1,3);  %this sets the fix P and Q value @ bus 3
    % V(1) = (1/Y(1,1)) * ((P(1)-Q(1)*1i)/conj(V(1)) - Y(1,2)*V(2) - Y(1,3)*V(3));
    V(2) = (1/Y(2,2)) * ((P(2)-Q(2)*1i)/conj(V(2)) - Y(2,1)*V(1) - Y(2,3)*V(3));
    V(3) = (1/Y(3,3)) * ((P(3)-Q(3)*1i)/conj(V(3)) - Y(3,1)*V(1) - Y(3,2)*V(2));
    V(1) = V(1)/abs(V(1));  %this retains the mag of voltage source bus
    V_norm = sqrt(V(1)^2+V(2)^2+V(3)^2);
    err = abs(V_norm-old);
    old = V_norm;
end

%________________ The display loop__________________
for i = 1:3
    I = num2str(i); v = num2str(V(i),2); p = num2str(P(i),2); q = num2str(Q(i),2);
    disp(['V(',I,') = ',v,'; P',I,') = ',p,'; Q(',I,') = ',q,]);
end
disp(['iterations = ', num2str(count)]);