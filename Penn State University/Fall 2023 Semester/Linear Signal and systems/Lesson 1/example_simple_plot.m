% learning to plot in matlab
X = 1:5:100; % X starts at 1 and stops at 100 with increaments of 5
Y = 1:6:120;
plot (X)
plot (X) % Plots the X function and displays it on a different window
plot (Y,'DisplayName','Y'); hold on;plot(X,'DisplayName','X'),hold off; % plot with Display Name will assign name to the plot hold on will plot more fuction to the graph hold off will close the graph


% you can save the entire workspace or a variable in the workspace as a .
% mat file