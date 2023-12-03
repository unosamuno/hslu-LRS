%Hochschule Luzern T&A
%Markus Birrer
%Modul LRS
%Mai 2023

clc; clear all; close all;


%Measuring Results

yaxis = [0.5 1 1.5 2 2.5 3]; %Pumpensteuerspannung [V]

%Tragen Sie in die unstehende Matrix die Füllhöhen ein
       xaxis = [5   6   7   8   9  10]; %Ventilstellung
	           %-----------------------
Waterlevel =   [0,  0,  0,  0,  0,  0;  %0.5V
                0,  0,  0,  0,  0,  0;  %1V
                0,  0,  0,  0,  0,  0;  %1.5V
                0,  0,  0,  0,  0,  0;  %2V
                0,  0,  0,  0,  0,  0;  %2.5V
                0,  0,  0,  0,  0,  0]  %3V

zaxis = [0 50 100 150 200 250 300 350 400]; %Füllhöhe mm

[a,b] = meshgrid(xaxis,yaxis);

figure(1)
surf(a,b,Waterlevel);
grid on;


title('Statisches Kennlinienfeld Niveauversuch');

xticks(xaxis);
yticks(yaxis);
zticks(zaxis);

xlabel('Position Störventil 1','Position', [7 -1]);
ylabel('Pumpensteuerspannung [V]','Position', [3 1]);
zlabel('Wasserhöhe [mm]');

