%  m0520.m     (Matlab/Simulink R2007b)
%
%  Bild 5.20 (nur Führungsübergangsfunktionen)
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:   s0520.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%  Kpr  Reglerverstärkung im Bereich  0.7 < Kpr < 5
%
%  schalt  Ein-/Ausschalter des I-Anteils im PID-Regler   
%          schalt=1/0: ein/aus
%  Tn   Nachstellzeit im Bereich  10  < Tn  < 20
%
%  Tv   Vorhaltzeit im Bereich  0.0 < Tv  < 2
%
%  Tt   Streckentotzeit im Bereich  0.  < Tt  < 2
%
% ########################################################
clear

      Kpr    = 1.5;       % Kpr= 1.5

      schalt = 1  ;       % schalt=1 
      Tn     =10. ;       % Tn =10.

      Tv     = 2. ;       % Tv = 2.

      Tt     = 1. ;       % Tt = 1.

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

% P-T3-Strecke:
s=tf('s');
Gs=1/(2*s+1)/(3*s+1)/(4*s+1);
szae=Gs.num{1};
snen=Gs.den{1};

% PID-Regler:
T1=0.01;     % Zeitkonstante D-Anteil

% Eingangssignale:
zdach=0;
wdach=1;

% Simulation:
figure(1)
set(gcf,'Units','normal','Position',[.6 .55 .35 .35], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 5.20');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes 

tend=60; 


opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.1);
[t,x,y]=sim('s0520',[0 tend],opts);

plot(t,y(:,1),'r',t,y(:,2),'b'); 
grid on;

set(gca,'FontSize',fonts,...
    'Position',[.15 .2 .8 .7],...
    'YTick',[0:.2:2]);
axis([0 tend 0 1.4])
title('Führungsübergangsfunktion');
xlabel('t \rightarrow') 
ylabel('h \rightarrow')
