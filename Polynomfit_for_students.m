%Hochschule Luzern T&A
%Markus Birrer
%Modul LRS Niveauregelung
%Mai 2023

clc; clear all; close all;

%Polynomfit
OrderofPolyfit = 1;

Height_mm_0 = 0;
Current_Pressure_mA_0 = 9999;  %TODO STUDENTS 

Height_mm_1 = 30;
Current_Pressure_mA_1 = 9999; %TODO STUDENTS

Height_mm_2 = 60;
Current_Pressure_mA_2 = 9999; %TODO STUDENTS

Height_mm_3 = 90;
Current_Pressure_mA_3 = 9999; %TODO STUDENTS 

Height_mm_4 = 120;
Current_Pressure_mA_4 = 9999; %TODO STUDENTS

Height_mm_5 = 150;
Current_Pressure_mA_5 = 9999; %TODO STUDENTS

Height_mm_6 = 180;
Current_Pressure_mA_6 = 9999; %TODO STUDENTS

Height_mm_7 = 210;
Current_Pressure_mA_7 = 9999; %TODO STUDENTS

Height_mm_8 = 240;
Current_Pressure_mA_8 = 9999; %TODO STUDENTS

Height_mm_9 = 270;
Current_Pressure_mA_9 = 9999; %TODO STUDENTS

Height_mm_10 = 300;
Current_Pressure_mA_10 = 9999; %TODO STUDENTS

Height_mm_11 = 330;
Current_Pressure_mA_11 = 9999; %TODO STUDENTS

Height_mm_12 = 360;
Current_Pressure_mA_12 = 9999; %TODO STUDENTS

Height_mm_13 = 390;
Current_Pressure_mA_13 = 9999; %TODO STUDENTS

%Put the different values in a rowvector
Height_values = [Height_mm_0,Height_mm_1,Height_mm_2,Height_mm_3,Height_mm_4,Height_mm_5,Height_mm_6,Height_mm_7,Height_mm_8,Height_mm_9,Height_mm_10,Height_mm_11,Height_mm_12,Height_mm_13]; 
Current_Pressure_Values = [Current_Pressure_mA_0,Current_Pressure_mA_1,Current_Pressure_mA_2,Current_Pressure_mA_3,Current_Pressure_mA_4,Current_Pressure_mA_5,Current_Pressure_mA_6,Current_Pressure_mA_7,Current_Pressure_mA_8,Current_Pressure_mA_9,Current_Pressure_mA_10,Current_Pressure_mA_11,Current_Pressure_mA_12,Current_Pressure_mA_13];


%Plot the values for a control
figure(1);
plot(Height_values,Current_Pressure_Values);
title ("Values for a control");



fitvariables = polyfit(Current_Pressure_Values,Height_values,1);

disp('fitvariables');
disp(fitvariables);

disp('a');
a = fitvariables(1,1)

disp('b');
b = fitvariables(1,2)

Height_values_calc = ((Current_Pressure_Values*a)+b);


figure(2);
plot(Current_Pressure_Values,Height_values,'b');
hold on;
plot(Current_Pressure_Values,Height_values_calc,'r');
hold on;
%plot(Current_Pressure_Values,Height_values_calc_cor,'c');
%hold on;
legend('measured','fitted');
xlabel('Current_Pressure[mA]');
ylabel('Waterheight[mm]');




