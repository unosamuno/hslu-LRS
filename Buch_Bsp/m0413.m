%  m0413.m     (MATLAB/SIMULINK R2007b)
%
%  PI-Regler:  Sprungantwort 
%  
%  Bild 4.13
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2008
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0413.mdl 
%
%  (c)5.7.09 R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   Kpr          Proportionalbeiwert P-Anteil
%                  im Bereich  0  < Kpr  <  5
%   Kir          Proportionalbeiwert I-Anteil
%                  im Bereich  -.1  < Kir  <  .3
%   edachWerte   Sprunghöhe Regeldifferenz
%                  im Bereich  -1  < edach  <  1.
%   te           Simulationsdauer
%
% ########################################################
clear
  Kpr=1;            % Kpr=1 
  Kir=4;            % Kir=4

  edachWerte=[  1  1.2 ];  % edachWerte=[-1 .5  1  ]

  te=.5;             % te=1
  
% ########################################################
close all
menu='fig';  % none oder fig
fonts=8;

Tn=Kpr/Kir

% Koordinatenachsen dimensionieren
t0A=-.5;      % Beginn der t-Achse in den Grafiken, t0A=-.5
teE=te;       % Ende der t-Achse in den Grafiken
te=te;        %  Simulationsintervallanpassung
Dxtick=.5;    %  t-Achsenteilung 
e_ampl=[-1 2];
y_ampl=[-1 3];

t0g=0;        % Start Grafik

figure(1)
set(gcf,'Units','normal','Position',[.53 .66 .35 .13], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 4.13:  Sprungantwort PI-Regler');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.9,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

figure(2)
set(gcf,'Units','normal','Position',[.53 .34 .35 .23], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 4.13:  Sprungantwort PI-Regler');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',te/1000);

n=size(edachWerte,2);
for i=1:n
edach=edachWerte(i);


[t,x,y]=sim('s0413',[0 te],opts);


figure(1)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-20 20];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
hold on
plot([t0A 0],[0 0],'k','linewidth',2)
plot(t,y(:,1),'k','linewidth',2)
grid on
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A te],...
    'xtick',[-50:Dxtick:te],...
    'ylim',e_ampl,...
    'ytick',[-10:1:10]);
xlabel('t'); 
ylabel('e')
%title(['Analoger PI-Regler mit/ohne Anti-Windup'])

figure(2)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-20 20];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
hold on
plot([t0A 0],[0 0],'k','linewidth',2)
plot(t,y(:,2),'k','linewidth',2)
grid on
% Verlängerungsgerade nach links runter zur t-Achse
tTn=[0 Tn];
Gerade=edach*Kir*tTn;
tTn=tTn-Tn;
plot(tTn,Gerade,'k:','linewidth',1)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A te],...
    'xtick',[-50:Dxtick:te],...
    'ylim',y_ampl,...
    'ytick',[-10:1:10]);
xlabel('t'); 
ylabel(' y')


end