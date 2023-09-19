%  m0416.m    (Für MATLAB/SIMULINK R2007b)
%
%  PD-Regler: Sprung- und Anstiegsantwort 
%
%  Bild 4.16
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0416.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%    Kpr  P-Beiwert im Bereich .1  < Kpr <  10 ,
%    Tv   Vorhaltzeit im Bereich .1  < Tv <  10 ,
%    T1D  Zeitkonstante D-Anteil .01*Tv  < T1D <  .1*Tv ,
%
%    edach    Sprunghöhe der Regeldifferenz e
%    eAdach   Steigung der Regeldifferenz e
%
%    te       Simulationsdauer
%
% ########################################################
clear
    
    Kpr=1;            % Kpr=1 
    Tv=.5;            % Tv=.5 
    T1D=.05;          % T1D=.05 
    
    edach=1;          % edach=1
    eAdach=2;         % eAdach=2
    
    te=1.5;           % te=1.5
    
% ########################################################

close all
fonts=8;


% Koordinatenachsen dimensionieren
Dxtick=1;
eSprung=[-.5 1.5];
eSprAntw=[-.3 5];
eAnstfkt=[-.5 1.5];
eAnstAntw=[-.3 3];

t0A=-.5;   % Beginn der t-Achse in den Grafiken
teE=te;   % Ende der t-Achse in den Grafiken
te=te-t0A;   %  Simulationsintervallanpassung
    
figure(1)
set(gcf,'Units','normal','Position',[.5 .4 .48 .33], ...
    'NumberTitle','off','MenuBar','fig',...
    'Name',' Bild 4.16: PD-Regler');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

% Simulationsparameter
opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);


[t,x,y]=sim('s0416',[0 te],opts);

t=t0A+t;   % Sprünge und -antworten in Diagrammen um 1 nach links

subplot(2,2,1)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on
plot(t,y(:,1),'k','linewidth',2)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-10:Dxtick:teE],...
    'ylim',eSprung,...
    'ytick',[-10:.5:10]);
xlabel('t \rightarrow'); 
ylabel('e \rightarrow')
title(['Sprungantworten'])

subplot(2,2,3)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on

plot(t,y(:,2),'k','linewidth',2)
plot(t,y(:,3),'k:','linewidth',1)

set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-10:Dxtick:teE],...
    'ylim',eSprAntw,...
    'ytick',[-10:1:10]);
xlabel('t \rightarrow'); 
ylabel('y \rightarrow')




% Anstiegantworten:

[t,x,y]=sim('s0416',[0 te],opts);

t=t0A+t;

subplot(2,2,2)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on
plot(t,y(:,4),'k','linewidth',2)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-10:Dxtick:teE],...
    'ylim',eAnstfkt,...
    'ytick',[-10:.5:10]);
xlabel('t \rightarrow'); 
ylabel('e \rightarrow')
title(['Anstiegsantworten'])


subplot(2,2,4)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off
hold on
plot(t,y(:,5),'k','linewidth',2)
plot(t,y(:,6),'k:','linewidth',1)
plot(t,y(:,7),'k:','linewidth',1)
plot(t,y(:,8),'k','linewidth',1)
plot(t,y(:,9),'k','linewidth',1)

set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-10:Dxtick:teE],...
    'ylim',eAnstAntw,...
    'ytick',[-10:1:10]);
xlabel('t \rightarrow'); 
ylabel('y \rightarrow')










