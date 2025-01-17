
clear
clc
% Given values
%___________________________________________
% x + 0.2y =  0.7     x =  1.0
%x +     y = -0.5     y = -1.5
%___________________________________________

%using the Jacobian mathod

%Initialize a vector for x and y to be 15 by 1 vector
x = zeros(15, 1);   % vector of 15 zeros
y = zeros(15, 1);

%Initial Guess start guessing a value for x and y 
Xprev = 2;
Yprev = 2;

for i=1:15              %open a for loop that runs 15 times
    x(i) = 0.7 - 0.2 * Yprev;
    y(i) = -0.5 - Xprev;

    Xprev = x(i);
    Yprev = y(i);
end

plot(y) % note the value of y converges at around -1.5 this is close to the answer
hold on;
plot(x) % note the value of x converges at around 1.0 this is close to the answer
hold off;

%_____________________________________________________________
% not the Jacobian Method took 8 iteration 
%_____________________________________________________________

%% *********************** Gauss Siedel Method ***************************
%____________________________________________________________
% In Gauss Siedel you determine x(i) using the initial Guess values
% then you use x(i) to determine y(i)
%repeate the loop again and again intil you converge at a point
%____________________________________________________________

%Initialize a vector for x and y to be 15 by 1 vector
x = zeros(15, 1);   % vector of 15 zeros
y = zeros(15, 1);

%Initial Guess start guessing a value for x and y 
Xprev = 2;
Yprev = 2;

for i=1:15              %open a for loop that runs 15 times
    x(i) = 0.7 - 0.2 * Yprev;  %determine x(i)
    y(i) = -0.5 - x(i);        % use x(i) to get y(i)

    Xprev = x(i);
    Yprev = y(i);
end

plot(y) % note the value of y converges at around -1.5 this is close to the answer
hold on;
plot(x) % note the value of x converges at around 1.0 this is close to the answer
hold off;

%________________________________________________________
% note the Guass Siedel Method took 5 iteration
%________________________________________________________