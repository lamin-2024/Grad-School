%%
%Derivative and difference example
%%

clf; clear all
%Symbolic
syms t y z
y = cos(t^2)
z = diff(y)
figure (6)
subplot (211)
ezplot (y,[0,3*pi]); grid %plot y between o and 2pi
hold on
subplot (212)
ezplot(z, [0,2*pi]); grid
%Numeric
Ts = 0.1; % sampling period
t1 = 0 : Ts : 2*pi; % sampled time
y1 = cos (t1.^2) ; % sampling signal
z1 = diff (y1)./diff (t1) ; % difference approximated derivation
figure (6)
subplot (213)
stem (t1, y1, 'k') ;
axis ([0 2*pi 1.1*min(y1) 1.1*max(y1)])
subplot (212)
stem (t1 (1. : length (y1)-1), z1, 'k');
axis ([0 2*pi 1.1*min(z1) 1.1*max(z1)])
legend ('Derivative (blue)','Difference(black)')
hold off
