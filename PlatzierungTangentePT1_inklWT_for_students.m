%Hochschule Luzern T&A
%Markus Birrer
%Modul LRS
%Mai 2023

clc; clear all; close all;

%positiver Schritt
load("Schrittantwort_200mm_1930_2V3_auf_2V45.mat");  %<-TODO STUDENTS

%negativer Schritt
%load("Schrittantwort_200mm_1930_2V3_auf_2V15.mat");  %<-TODO STUDENTS


%Horizontale Cursors
y_Ausgangsgroesse_Start = 20; % [mm] <-TODO STUDENTS
y_Ausgangsgroesse_Ende = 100;  % [mm]<-TODO STUDENTS

%Vertikale Cursors
TimeStart = 100;  % [ms] <-TODO STUDENTS  bei Auslösung des Sprunges / Schrittes (Pumpenspannung)
Time632 = 4000; %[ms] <-TODO STUDENTS   tunen Sie den Zeitwert so dass die vertikale Linie die 63.2%-Linie (rot) auf dem PTx-Verlauf schneidet


disp('file was loaded');

%Zur besseren Darstellung auf dem plot
VerstaerkungsfaktorSchritt = 100;  %<-TODO STUDENTS: wählen Sie einen sinnvollen Verstärkungsfaktor, damit Ihnen der Schritt sinnvoll angezeigt wird auf dem plot

figure(1);

plot(HeightsHeight2);
hold on;
grid minor;
plot(VoltagePump.*VerstaerkungsfaktorSchritt,'m'); %jeder einzelne Wert im Vektor wird mit dem Verstärkungsfaktor multipliziert


%Identifikationsverfahren 3 für PT1-Elemente
%Berechnung des 63.2% Wertes des "Endwert"
Schritthoehe_y = (y_Ausgangsgroesse_Start - y_Ausgangsgroesse_Ende);
Endwert632_y = ((Schritthoehe_y*0.632)+y_Ausgangsgroesse_Start);
disp("63.2%");
disp(Endwert632_y);


xline(TimeStart,"k",'LineStyle','-');
xline(Time632,"k",'LineStyle','-');
yline(y_Ausgangsgroesse_Start,'-');
yline(y_Ausgangsgroesse_Ende,'-');
yline(Endwert632_y,"r");
xlabel("Zeit [ms]");
ylabel("Fuellhoehe [mm]");

% %Platzierung Wendetangente
% %PROBLEM: 
% % Die X und Y Achse sind nicht gleich skaliert, dass gibt eine
% %Verzerrung bei der Berechnung mit Winkel; Vorschlag für Winkel ist 0.1 bis
% %5 Grad
% 
% %Defines
% xPosition=2962;
% yPosition=213;
% Laenge=2000;
% alpha_deg = (2); 
% 
% %Berechnung
% lx = ((Laenge*cosd(alpha_deg))/2);
% ly = ((Laenge*sind(alpha_deg))/2);
% xlow = (xPosition-lx);
% ylow = (yPosition-ly);
% 
% xhigh = (xPosition+lx);
% yhigh = (yPosition+ly);
% X = [xlow xhigh];
% Y = [ylow yhigh];
% 
% 
% line(X,Y,'Color','red','LineStyle','--')

%Berechnung T1
x = [TimeStart Time632];
yPosition = [y_Ausgangsgroesse_Start  y_Ausgangsgroesse_Ende];
%line(x,y,'Color','red');

%Berechnung kstr 
Eingangsgroesse_low = 0.1; % [V] <-TODO STUDENTS
Eingangsgroesse_high = 0.2; % [V] <-TODO STUDENTS

result = (2 - 1 + 4 * 2); %TODO STUDENTS: Wie muss kstr berechnet werden?
Verstaerkung_kstr = (1*1/1); %TODO STUDENTS

disp('kstr');
disp(Verstaerkung_kstr);

TimeT1 = ((Time632 - TimeStart)/1000);

disp('TimeT1: ');
disp(TimeT1);

