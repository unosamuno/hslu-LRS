%  m0433.m    (Für MATLAB/SIMULINK R2007b)
%
%  Zweipunktregler mit Rückführung und P-T1-Tt-Strecke
%
%  Bild 4.33
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0433.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%    Tt  Streckentotzeit im Bereich  .5  < Tt <  1.5 ,
%
%    zdach  Störsprunghöhe im Bereich  -.5 < zdach < 1.5 ,
%
%    wdach Führungssprunghöhe im Bereich  0 < wdach < 1.5
%
%    xD   Schaltdifferenz im Bereich   .1  < xD <  1 ,
%
%    Yh   Stellbereich im Bereich    .1  < Yh <  10 ,
%
%    Kpr  P-Beiwert Kpr der stetigen Rückführung 
%                     im Bereich    .1  < Kpr <  10 ,
%
%    Tr   Zeitkonstante der stetigen Rückführung
%                     im Bereich    .1  < Tr <  3 ,
%
%    Rauschen  Messrauschleistung  0  <  Rauschen  <  1
%
%    te        Simulationsdauer
%
% ########################################################
clear

    Tt=1.5;              % Tt=1.5

    zdach=.5;            % zdach=.5 
    wdach=1;             % wdach=1 

    xD=.05;              % xD=.05   

    Yh=1;                % Yh=1 
    
    Kpr=0.4;             % Kpr=0.4 
    Tr=1;                % Tr=1
  
    Rauschen=.0;         % Rauschen=0
          
    te=20;               % te=20
    
% ########################################################

close all
fonts=8;

% Strecke:
Kps=2;   
T1=2;    % 1
s=tf('s');
Gs=Kps/(T1*s+1);
Gszae=Gs.num{1};
Gsnen=Gs.den{1};

% Umrechnungen
Rauschen=Rauschen*1e-5;

% Koordinatenachsen dimensionieren
Dxtick=5;
St_z_ampl=[-.5 1.5];
St_wx_ampl=[-1. 1];
St_y_ampl=[-.5 1.5];
Fu_z_ampl=[-.5 1.5];
Fu_wx_ampl=[-.2 2.2];
Fu_y_ampl=[-.5 1.5];

t0A=-2;   % Beginn der t-Achse in den Grafiken
teE=te;   % Ende der t-Achse in den Grafiken
te=te-t0A;   %  Simulationsintervallanpassung

w_steptime=-t0A;
z_steptime=-t0A;


figure(1)
set(gcf,'Units','normal','Position',[.5 .4 .48 .4], ...
    'NumberTitle','off','MenuBar','fig',...
    'Name',' Bild 4.33: Zweipunktregler mit verzögerter Rückführung und P-T1-Tt-Strecke');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)

% Simulationsparameter
opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);


% Störverhalten
wdach_=0;
zdach_=zdach;    

[t,x,y]=sim('s0433',[0 te],opts);

t=t0A+t;   % Sprünge und -antworten in Diagrammen um 1 nach links

subplot(3,2,1)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on
plot(t,y(:,2),'k','linewidth',2)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[0:Dxtick:teE],...
    'ylim',St_z_ampl,...
    'ytick',[-10:.5:10]);
xlabel('t \rightarrow'); 
ylabel('z \rightarrow')
title(['Störverhalten'])

subplot(3,2,3)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on
plot(t,y(:,1),'k','linewidth',2)
plot(t,y(:,3),'k','linewidth',1)
plot(t,y(:,5),'k:','linewidth',1)
plot(t,y(:,7),'r','linewidth',1)  % uth+ur
plot(t,y(:,8),'g','linewidth',1)  % ur

set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[0:Dxtick:teE],...
    'ylim',St_wx_ampl,...
    'ytick',[-10:.5:10]);
xlabel('t \rightarrow'); 
ylabel('w, x \rightarrow')


subplot(3,2,5)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on

plot(t,y(:,6),'k','linewidth',1)

set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-0:Dxtick:teE],...
    'ylim',St_y_ampl,...
    'ytick',[-10:1:10]);
xlabel('t \rightarrow'); 
ylabel('y \rightarrow')




% Führungsverhalten:

wdach_=wdach;   
zdach_=0;

[t,x,y]=sim('s0433',[0 te],opts);

t=t0A+t;

subplot(3,2,2)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on
plot(t,y(:,2),'k','linewidth',2)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[0:Dxtick:teE],...
    'ylim',Fu_z_ampl,...
    'ytick',[-10:.5:10]);
xlabel('t \rightarrow'); 
ylabel('z \rightarrow')
title(['Führungsverhalten'])


subplot(3,2,4)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off 
hold on
plot(t,y(:,1),'k','linewidth',2)
plot(t,y(:,3),'k','linewidth',1)
plot(t,y(:,4),'k:','linewidth',1)  % ungeregelt
plot(t,y(:,7),'r','linewidth',1)  % uth+ur
plot(t,y(:,8),'g','linewidth',1)  % ur
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-0:Dxtick:teE],...
    'ylim',Fu_wx_ampl,...
    'ytick',[-10:.5:10]);
xlabel('t \rightarrow'); 
ylabel('w, x \rightarrow')



subplot(3,2,6)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off
hold on

plot(t,y(:,6),'k','linewidth',1)

set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-0:Dxtick:teE],...
    'ylim',Fu_y_ampl,...
    'ytick',[-2:1:10]);
xlabel('t \rightarrow'); 
ylabel('y \rightarrow')












