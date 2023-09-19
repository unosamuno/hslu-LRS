%  m0212d.m     (Matlab/Simulink R2007b)
%
%  Bild 2.12d
%  Mann/Schiffelgen/Froriep,
%  Einf�hrung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, M�nchen, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0212d.mdl
%
%  (c) 5.7.09  R.Froriep
%
%
% ########################################################
%
%  Anleitung:
%
%  Das m-file �ffnet ein Simulink-Fenster und die
%  Zeitdiagrammfenster zu den beiden Scope-Bl�cken.
%  Start der Simulation mit "Simulation" und "Start".
%
%  Zum Variieren von Werten, z.B. omK (s.u.):
%   1. Wert nach clear, in Zeile vor %-Zeichen �ndern
%   2. Editor-Icon "Save and run"
%   3. Simulink-Icon "Start simulation"
%
% ########################################################
%
%  Variations-Empfehlungen:
%    omdach      0 < omdach < 20  (rad/s)
%                Schnelle Drehzahl�nderung von 0 auf den
%                konstanten Wert omK 
%
% ########################################################
clear all
%  Eingabefeld mit Angabe der Voreinstellungen  

     omdach=12;                %   omdach=12

% ########################################################
clc
close all

% Fliehkraftpendel Daten
rP=1;          % cm
l=10;          % cm
m=0.5;         % kg
cR=0.05;       % Nms 
g=9.81;        % m/s^2

% Umrechnung auf SI-Einheiten
rP=rP*1e-2;
l=l*1e-2;

% Simulink-Fenster �ffnen
open('s0212d')

% Editor �ffnen
edit('m0212d.m')



