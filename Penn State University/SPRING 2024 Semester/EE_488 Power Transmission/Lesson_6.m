%*******This Routine use Gauss Siedel to Sove Power Flow Problem
clear;
clc;
% Admittance Matrix Problem
y11 = 20-50*1i;  y12 = -10+20*1i;  y13 = -10+30*1i;
y22 = 26-52*1i;  y23 = -16+32*1i;  y33 = 26-62*1i;
Y = [y11 y12 y13; y12 y22 y23; y13 y23 y33];

% This section initilizes variables
P_load = -4; Q_load = -2.5; P_PV = 2.0; V_slack = 1.05+0*1i;
V = [V_slack 1.0+0*1i 1.04+0*1i];

% Conditions for iteration
tol = 0.0001;  err = 1; old = V(2); count = 0; mag_source = abs(V(3));

%________________ Iteration loop___________________
while (err>tol)
    count = count+1;
    P = [0 0 0];  Q = [0 0 0];
    for k=1:3
        for n=1:3
            P(k) = P(k)+abs(Y(k,n))*abs(V(n))*cos(angle(V(k))-angle(V(n))-angle(Y(k,n)));
            Q(k) = Q(k)+abs(Y(k,n))*abs(V(n))*sin(angle(V(k))-angle(V(n))-angle(Y(k,n)));
        end
        P(k) = abs(V(k))*P(k); Q(k) = abs(V(k))*Q(k);
    end
    P(2) = P_load; Q(2) = Q_load;  %this set the fix P and Q values @ bus 2
    P(3) = P_PV;                   % this sets the fixed P value @ bus 3
    V(2) = (1/Y(2,2)) * ((P(2)-Q(2)*1i)/conj(V(2)) - Y(2,1)*V(1) - Y(2,3)*V(3));
    V(3) = (1/Y(3,3)) * ((P(3)-Q(3)*1i)/conj(V(3)) - Y(3,1)*V(1) - Y(3,2)*V(2));
    V(3) = mag_source*V(3)/abs(V(3));  %this retains the mag of voltage source bus
    err = abs(V(2)-old);
    old = V(2);
end

%________________ The display loop__________________
for i = 1:3
    I = num2str(i); v = num2str(V(i),2); p = num2str(P(i),2); q = num2str(Q(i),2);
    disp(['V(',I,') = ',v,'; P',I,') = ',p,'; Q(',I,') = ',q,]);
end
disp(['iterations = ', num2str(count)]);




