%LProblem Set 1
%EE488
%Spring 2024
%% ******************** Q3 4 node Power Grid *********************************
clear;
clc;
I_angle1 = 35;
I_angle2 = 50;
I_o1 = deg2rad(I_angle1);
I_o2 = deg2rad(I_angle2);

%********** @ node 1 apply nodal analysis ****************************
%interms of Z
v1_coeff = (1/(j*3))-(1/(j*(3.3)))+(1/5)+(1/(j*(3.5)))+(1/2.5);
V2_coeff = (1/(j*3.3))-(1/5);
V3_coeff = -1/(j*3.5);
V4_coeff = -1/(2.4);

%interms of Y=1/Z
v1_y = 1/v1_coeff;
v2_y = 1/V2_coeff;
v3_y = 1/V3_coeff;
v4_y = 1/V4_coeff;

%********** @ node 2 apply nodal analysis ****************************
%interms of Z
v1_coeff1 = (1/(j*3.3))-(1/5);
V2_coeff1 = (-1/(j*2.4))-(1/(j*3.3))+(1/5)-(1/(j*2.4));
V3_coeff1 = 1/(j*2.4);

%interms of Y=1/Z
v1_y1 = 1/v1_coeff1;
v2_y1 = 1/V2_coeff1;
v3_y1 = 1/V3_coeff1;

%********** @ node 3 apply nodal analysis ****************************
%interms of Z
v1_coeff2 = -1/(j*3.5);
V2_coeff2 = 1/(j*2.4);
V3_coeff2 = (-1/(j*2.4))+(1/(j*2))+(1/(j*3.5))-(1/(j*3.3));
V4_coeff2 = 1/(j*3.3);

%interms of Y=1/Z
v1_y2 = 1/v1_coeff2;
v2_y2 = 1/V2_coeff2;
v3_y2 = 1/V3_coeff2;
v4_y2 = 1/V4_coeff2;

%********** @ node 4 apply nodal analysis ****************************
%interms of Z
v1_coeff3 = -1/2.4;
V3_coeff3 = 1/(j*3.3);
V4_coeff3 = (1/2.4)-(1/(j*3.3))+(1/5);

%interms of Y=1/Z
v1_y3 = 1/v1_coeff3;
v3_y3 = 1/V3_coeff3;
v4_y3 = 1/V4_coeff3;