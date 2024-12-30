%---------------------------------------------------------------------------------------------------
% Name Lamin Jammeh
% CLass: EE417 Summer 2024
% Lesson 10 HW Question 3
% Group: Ron Kalin/ Lamin Jammeh
% Project Description: The Testbench results are ploted to show the filtered and unfiltered signals
%---------------------------------------------------------------------------------------------------

%Step1 define the TestBench result
time = 10:10:100;
Sample_in = [0, 1, 0, 10, 0, 1, 2, 8, 2, 1];
FIR_out = [0, 0, 0, 0, 0, 7, 10, 70, 100, 7];

%Step2 plot the TestBench results
plot(time, Sample_in, 'LineWidth',2);
hold on;
plot(time, FIR_out, 'LineWidth',2);
grid on;
legend('Unfiltered Signal','Filtered Signal', 'Location','north');

title('FIR__MAC Filtered vs Unfiltered Results');
xticks(0:5:100);
yticks(0:5:100);
xlabel('time in nanoSec');
ylabel('Signal values');
hold off;
