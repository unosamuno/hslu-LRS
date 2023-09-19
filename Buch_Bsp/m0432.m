%  m0432.m    (Für MATLAB/SIMULINK R2007b)
%
%  Zweipunkt-Regler mit verzögerter Rückführung 
%
%  Bild 4.32
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0432.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%    xD   Schaltdifferenz im Bereich  .1  < xD <  .3 ,
%
%    Yh   Stellbereich  (ymin=0, ymax=Yh)
%               im Bereich    .1  < Yh <  10 ,
%
%    Kpr  P-Beiwert im Bereich   .1  < Kpr <  10 ,
%
%    Tr   Zeitkonstante im Bereich  .1  < Tr <  3 ,
%
%    edach  Sprunghöhe der Regeldifferenz
%               im Bereich    -.2 < edach <  1.3 ,
%
%    te     Simulationsdauer
%
% ########################################################
clear
   xD=.2;          % xD=.2
   Yh=1;           % Yh=1
   Kpr=1.2;        % Kpr=1.2 
   Tr=.5;          % Tr=.5
   edach=.6;       % edach=.6
        
   te=3;           % te=3
    
% ########################################################

close all
fonts=8;


% Koordinatenachsen dimensionieren
Dxtick=1;
x_ampl=[-.5 1.3];
y_ampl=[-.2 1.5];


t0A=-.5;   % Beginn der t-Achse in den Grafiken
teE=te;   % Ende der t-Achse in den Grafiken
te=te-t0A;   %  Simulationsintervallanpassung
    
figure(1)
set(gcf,'Units','normal','Position',[.6 .3 .4 .5], ...
    'NumberTitle','off','MenuBar','fig',...
    'Name',' Bild 4.32: Zweipunktregler mit verzögerter Rückführung');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)



% Simulationsparameter
opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);


% Simulation:

[t,x,y]=sim('s0432',[0 te],opts);

t=t0A+t;   % Sprünge und -antworten in Diagrammen um 1 nach links

figure(1)
axes('Position',[.13 .12 .8 .8])
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-10:Dxtick:teE],...
    'ylim',x_ampl,...
    'ytick',[-10:.5:10]);
xlabel('t \rightarrow'); 
ylabel('e, y_r, y  \rightarrow');

grid off; 
hold on
box on

tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
yrab=edach-y(:,6);
plot(t,y(:,6),'k:','linewidth',1)
plot(t,yrab,'k:','linewidth',1)

plot(t,y(:,1),'k','linewidth',1)
plot(t,y(:,4),'k','linewidth',2)
plot(t,y(:,5),'k','linewidth',2)

y(:,3)=.2*y(:,3)-.5;   % Stellgrösse (für Grafik skaliert)
plot(t,y(:,3),'k','linewidth',2)


