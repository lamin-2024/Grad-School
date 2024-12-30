clear; clf
Ts= 0.1
t = -5:Ts:5;
% create ramps
y1 = ramp(t,3,3); % slope of 3 and % advance by 3
y2 = ramp(t,-6,1); % slope of -6, advance % by 1
y3 = ramp(t,3,0); % slope of 3, no % advancement or delay

% create unit step
y4 = -3 * ustep(t,-3); % amplitude of % -3, delayed % by 3
% total signal
y = y1 + y2 + y3 + y4
plot (t,y,'k'); axis([-5 5 -1 7]);
grid
