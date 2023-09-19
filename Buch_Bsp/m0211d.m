%  m0211d.m     (Matlab/Simulink R2007b)
%
%  Bild 2.11d
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0211d.mdl
%
%  (c) 5.7.09  R.Froriep
%
%
% ########################################################
%
%  Anleitung:
%
%  Das m-file öffnet ein Simulink-Fenster und die
%  Zeitdiagrammfenster zu den beiden Scope-Blöcken.
%  Start der Simulation Simulink-Icon "Start simulation".
%  (oder "Simulation" und "Start")
%
%  Zum Variieren von Werten:
%   1. Wert nach clear, in Zeile ohne %-Zeichen ändern
%   2. Editor-Icon "Save and run"
%   3. Simulink-Icon "Start simulation"
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%  R      0.3 < R < 3  (kOhm)
%         Ohmscher Widerstand in kOhm
%   
% ########################################################
clear all
%  Eingabefeld mit Angabe der Voreinstellungen  

   R=2;                %   R=1

% ########################################################
clc
close all

% Weitere RC-Netzwerk Daten:
C=100;        % uF

% Umrechnung auf SI-Einheiten
R=R*1e3;
C=C*1e-6;

% Simulink-Fenster öffnen
open('s0211d')

% Editor öffnen
edit('m0211d.m')
