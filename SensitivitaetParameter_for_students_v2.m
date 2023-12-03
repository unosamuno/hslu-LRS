%Hochschule Luzern T&A
%Markus Birrer
%Modul LRS Niveauregelung
%Mai 2023

%Dieses file im Ordner mit den Messwerten platzieren. Das File greift auf
%die Messwerte zu

clc; clear all; close all;

%defines
colorSollhoehe = 'm';
colorBoundary = 'r';
colorIsthoehe = 'b';

xlim_upper = 4000;  %[ms]  how much of the x-axis shall be plotted
xlim_lower = 0;

legend_pos_x = 2500;
legend_pos_y = 180;

overshoot_percent = 3;

%Settings for Arbeitshöhe 1
Sollhoehe1_mm = 75;

%Skala
ylim_upper_1 = 95;
ylim_lower_1 = 55;
%Grenzwerte fürs Einregeln
boundary_1 = (Sollhoehe1_mm*overshoot_percent/100);
lower_boundary_1 = (Sollhoehe1_mm-boundary_1);
upper_boundary_1 = (Sollhoehe1_mm+boundary_1);




%Settings for Arbeitshöhe 2
Sollhoehe2_mm = 220;
%Skala
ylim_upper_2 = 250;
ylim_lower_2 = 160;
%Grenzwerte fürs Einregeln
boundary_2 = (Sollhoehe2_mm*overshoot_percent/100);
lower_boundary_2 = (Sollhoehe2_mm-boundary_2);
upper_boundary_2 = (Sollhoehe2_mm+boundary_2);

%Settings for Arbeitshöhe 3
Sollhoehe3_mm = 330;
%Skala
ylim_upper_3 = 370;
ylim_lower_3 = 290;
%Grenzwerte fürs Einregeln
boundary_3 = (Sollhoehe3_mm*overshoot_percent/100);
lower_boundary_3 = (Sollhoehe1_mm-boundary_3);
upper_boundary_3 = (Sollhoehe1_mm+boundary_3);


%kp_medium = 9.009;
%kp_low = (kp_medium/2);
%kp_high = (kp_medium*2);

%Ti_medium = 9.009;
%Ti_low = (Ti_medium/2);
%Ti_high = (Ti_medium*2);

%T0 = 3.1415;






%Plots für Sensitivitätsanalyse

%MyPlot1 = load("1_200_220_9kp009_9Ti009.mat"); %TODO STUDENTS

%MyPlot2 = load("2_200_220_9kp009_9Ti009.mat"); %TODO STUDENTS

%MyPlot3 = load("3_200_220_1930_0kp054_0Ti866.mat"); %TODO STUDENTS

%MyPlot4 = load("4_200_220_9kp009_9Ti009.mat"); %TODO STUDENTS

MyPlot5 = load("5_200_220_9kp009_9Ti009.mat"); %TODO STUDENTS

%MyPlot6 = load("6_200_220_9kp009_9Ti009.mat"); %TODO STUDENTS

%MyPlot7 = load("7_200_220_9kp009_9Ti009.mat"); %TODO STUDENTS

%MyPlot8 = load("8_200_220_9kp009_9Ti009.mat"); %TODO STUDENTS

%MyPlot9 = load("9_200_220_9kp009_9Ti009.mat"); %TODO STUDENTS


figure(1)

% subplot(3,3,1);
% plot(MyPlot1.HeightsHeight2,colorIsthoehe);
% hold on;
% plot(MyPlot1.HeightsReference2,colorSollhoehe);
% hold on;
% yline(lower_boundary,colorBoundary);
% yline(upper_boundary, colorBoundary);
% xlim([xlim_lower xlim_upper]);
% ylim([ylim_lower_2 ylim_upper_2]);
% xlabel('Zeit [ms]');
% ylabel('Fuellhoehe [mm]');
% str = {'kp = 9.009', 'Ti = 9.009', 'T0 = 9.009'}; %TODO STUDENTS
% text(legend_pos_x, legend_pos_y,str); 

% subplot(3,3,2);
% plot(MyPlot2.HeightsHeight2,colorIsthoehe);
% hold on;
% plot(MyPlot2.HeightsReference2,colorSollhoehe);
% hold on;
% yline(lower_boundary,colorBoundary);
% yline(upper_boundary, colorBoundary);
% xlim([xlim_lower xlim_upper]);
% ylim([ylim_lower_2 ylim_upper_2]);
% xlabel('Zeit [ms]');
% ylabel('Fuellhoehe [mm]');
% str = {'kp = 9.009', 'Ti = 9.009', 'T0 = 9.009'}; %TODO STUDENTS
% text(legend_pos_x, legend_pos_y,str); 

% subplot(3,3,3);
% plot(MyPlot3.HeightsHeight2,colorIsthoehe);
% hold on;
% plot(MyPlot3.HeightsReference2,colorSollhoehe);
% hold on;
% yline(lower_boundary_2,colorBoundary);
% yline(upper_boundary_2, colorBoundary);
% xlim([xlim_lower xlim_upper]);
% ylim([ylim_lower_2 ylim_upper_2]);
% xlabel('Zeit [ms]');
% ylabel('Fuellhoehe [mm]');
% str = {'kp = 9.009', 'Ti = 9.009', 'T0 = 9.009'}; %TODO STUDENTS
% text(legend_pos_x, legend_pos_y,str); 

% subplot(3,3,4);
% plot(MyPlot4.HeightsHeight2,colorIsthoehe);
% hold on;
% plot(MyPlot4.HeightsReference2,colorSollhoehe);
% hold on;
% yline(lower_boundary,colorBoundary);
% yline(upper_boundary, colorBoundary);
% xlim([xlim_lower xlim_upper]);
% ylim([ylim_lower_2 ylim_upper_2]);
% xlabel('Zeit [ms]');
% ylabel('Fuellhoehe [mm]');
% str = {'kp = 9.009', 'Ti = 9.009', 'T0 = 9.009'}; %TODO STUDENTS
% text(legend_pos_x, legend_pos_y,str);

subplot(3,3,5);
plot(MyPlot5.HeightsHeight2,colorIsthoehe);
hold on;
plot(MyPlot5.HeightsReference2,colorSollhoehe);
hold on;
yline(lower_boundary,colorBoundary);
yline(upper_boundary, colorBoundary);
xlim([xlim_lower xlim_upper]);
ylim([ylim_lower_2 ylim_upper_2]);
xlabel('Zeit [ms]');
ylabel('Fuellhoehe [mm]');
str = {'kp = 9.009', 'Ti = 9.009', 'T0 = 9.009'}; %TODO STUDENTS
text(legend_pos_x, legend_pos_y,str);

% subplot(3,3,6);
% plot(MyPlot6.HeightsHeight2,colorIsthoehe);
% hold on;
% plot(MyPlot6.HeightsReference2,colorSollhoehe);
% hold on;
% yline(lower_boundary,colorBoundary);
% yline(upper_boundary, colorBoundary);
% xlim([xlim_lower xlim_upper]);
% ylim([ylim_lower_2 ylim_upper_2]);
% xlabel('Zeit [ms]');
% ylabel('Fuellhoehe [mm]');
% str = {'kp = 9.009', 'Ti = 9.009', 'T0 = 9.009'}; %TODO STUDENTS
% text(legend_pos_x, legend_pos_y,str);

% subplot(3,3,7);
% plot(MyPlot7.HeightsHeight2,colorIsthoehe);
% hold on;
% plot(MyPlot7.HeightsReference2,colorSollhoehe);
% hold on;
% yline(lower_boundary,colorBoundary);
% yline(upper_boundary, colorBoundary);
% xlim([xlim_lower xlim_upper]);
% ylim([ylim_lower_2 ylim_upper_2]);
% xlabel('Zeit [ms]');
% ylabel('Fuellhoehe [mm]');
% str = {'kp = 9.009', 'Ti = 9.009', 'T0 = 9.009'}; %TODO STUDENTS
%text(legend_pos_x, legend_pos_y,str);

% subplot(3,3,8);
% plot(MyPlot8.HeightsHeight2,colorIsthoehe);
% hold on;
% plot(MyPlot8.HeightsReference2,colorSollhoehe);
% hold on;
% yline(lower_boundary,colorBoundary);
% yline(upper_boundary, colorBoundary);
% xlim([xlim_lower xlim_upper]);
% ylim([ylim_lower_2 ylim_upper_2]);
% xlabel('Zeit [ms]');
% ylabel('Fuellhoehe [mm]');
% str = {'kp = 9.009', 'Ti = 9.009', 'T0 = 9.009'}; %TODO STUDENTS
% text(legend_pos_x, legend_pos_y,str);


% subplot(3,3,9);
% plot(MyPlot9.HeightsHeight2,colorIsthoehe);
% hold on;
% plot(MyPlot9.HeightsReference2,colorSollhoehe);
% hold on;
% yline(lower_boundary,colorBoundary);
% yline(upper_boundary, colorBoundary);
% xlim([xlim_lower xlim_upper]);
% ylim([ylim_lower ylim_upper]);
% xlabel('Zeit [ms]');
% ylabel('Fuellhoehe [mm]');
% str = {'kp = 9.009', 'Ti = 9.009', 'T0 = 9.009'}; %TODO STUDENTS
% text(legend_pos_x, legend_pos_y,str);




%xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

%Betrachtung des optimierten Reglers auf verschiedenen Arbeitshöhen

%TODO STUDENTS -> uncomment the full block beneath

% MyPlot_high_X = load("3_200_220_1930_0kp054_0Ti866.mat"); %TODO STUDENTS
% MyPlot_low_X = load("3_200_220_1930_0kp054_0Ti866.mat"); %TODO STUDENTS

% figure(2);
% title('Vergleich Reglerverhalten auf verschiedenen Arbeitshöhen');


% subplot(3,1,1);
% plot(MyPlot_high_X.HeightsHeight2,colorIsthoehe);
% hold on;
% plot(MyPlot_high_X.HeightsReference2,colorSollhoehe);
% hold on;
% title('Sollhoehe XXX mm'); %TODO STUDENTS
% yline(lower_boundary_1,colorBoundary);
% yline(upper_boundary_1, colorBoundary);
% xlim([xlim_lower xlim_upper]);
% ylim([ylim_lower_1 ylim_upper_1]);
% xlabel('Zeit [ms]');
% ylabel('Fuellhoehe [mm]');
% str = {'kp = 9.009', 'Ti = 9.009', 'T0 = 9.009'}; %TODO STUDENTS
% text(legend_pos_x, legend_pos_y,str); 



% subplot(3,1,2);
% plot(MyPlotX.HeightsHeight2,colorIsthoehe); %TODO STUDENTS X ersetzen durch den oben gewählten/analyisierten Regler
% hold on;
% plot(MyPlotX.HeightsReference2,colorSollhoehe); %TODO STUDENTS X ersetzen durch den oben gewählten/analyisierten Regler
% hold on;
% title('Sollhoehe XXX mm'); %TODO STUDENTS
% yline(lower_boundary_2,colorBoundary);
% yline(upper_boundary_2, colorBoundary);
% xlim([xlim_lower xlim_upper]);
% ylim([ylim_lower_2 ylim_upper_2]);
% xlabel('Zeit [ms]');
% ylabel('Fuellhoehe [mm]');
% str = {'kp = 9.009', 'Ti = 9.009', 'T0 = 9.009'}; %TODO STUDENTS
% text(legend_pos_x, legend_pos_y,str); 

% subplot(3,1,3);
% plot(MyPlot_low.HeightsHeight2,colorIsthoehe); 
% hold on;
% plot(MyPlot_low.HeightsReference2,colorSollhoehe); 
% hold on;
% title('Sollhoehe XXX mm'); %TODO STUDENTS
% yline(lower_boundary_3,colorBoundary);
% yline(upper_boundary_3, colorBoundary);
% xlim([xlim_lower xlim_upper]);
% ylim([ylim_lower_3 ylim_upper_3]);
% xlabel('Zeit [ms]');
% ylabel('Fuellhoehe [mm]');
% str = {'kp = 9.009', 'Ti = 9.009', 'T0 = 9.009'}; %TODO STUDENTS
% text(legend_pos_x, legend_pos_y,str); 