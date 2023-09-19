%  m0527.m     (Matlab/Simulink R2007b)
%
%  Bild 5.27 
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  s0527.mdl
%  Datendatei:      s0527_optim.mat 
%
%  (c)5.7.09  R.Froriep
%
% ........................................................
%
%  Hinweis:
%    
%     Simulink Response Optimization erforderlich.
%
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%  Strecke:
%    Beispiel 5.13
%
%  PID-Reglerparameter (Startwerte für die Optimierung) 
%
%  Kpr  Proportionalwert 
%  Iein Schalter für I-Anteil: Iein=0 AUS, Iein=1 EIN
%  Tn   Nachstellzeit
%  Tv   Vorhaltzeit
% 
%
% ########################################################
clear

   Kpr=.5;           %  Kpr=.5
   Iein=1;           %  Iein=1
   Tn =10;           %  Tn=10
   Tv =0;            %  Tv=0

% ########################################################

menu='none';  % none oder fig
close all

s=tf('s');
Gs=1/(2*s+1)/(3*s+1)/(4*s+1);
szae=Gs.num{1};
snen=Gs.den{1};

Tt=.1;  

open_system('s0527')



