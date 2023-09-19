%  m0404Bsp.m    (Für MATLAB/SIMULINK R2007b)
%
%  Dimensionierung des Stellbereichs:
%  Je grösser die Amplitude der Störgrösse, um so grösser
%   der erforderliche Stellausschlag
%  Dazu kommt noch der Stellausschlag, wenn die Führungs-
%   grösse verändert wird.
%  Führungs- und Störgesamtverhalten in EINEM Diagramm
%  Vergleich mit jeweils vorherigem Simulationslauf 
%
%  Beispiel 4.4
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0404Bsp.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   Tasten Sie sich mit zdach an die Grenzen eines vorgegebenen 
%   Stellbereichs yGmin < y < yGmax heran und finden Sie damit
%   experimentell heraus, welche max. Störamplitude noch aus-
%   geregelt werden kann.
%   Untersuchen Sie dann mit wdach>0 bzw. wdach<0 den zusätzlichen
%   Stellbereichsbedarf 
%   
%   Ab dem zweiten Programmaufruf erscheint in den Grafiken 
%   jeweils das Ergebnis des vorigen Aufrufs.
%
%   P-T1-Strecke:
%    Kps  P-Beiwert
%    T1   Zeitkonstante
%
%   P-Regler
%    Kpr  Verstärkung  .1  < Kpr <  50 
%    yGmin < y < yGmax    Stellbereich  
%
%   Führungsgrösse:
%    w_steptime   Sprungzeitpunkt  0 < w_steptime < 6
%    wdach        Pos. bzw. neg. konstanter Wert 
%
%   Störgrösse:
%    z_steptime   Sprungzeitpunkt, 0 < z_steptime < 6
%    zdach        Pos. bzw. neg. konstanter Wert 
%
%   te  Simulationsdauer
%
% ########################################################
%clear
   
    Kps=1;               % Kps=1 
    T1=2;                % T1=2
       
    Kpr=3;               % Kpr=3  
    
    yGmax=2;             % yGmax=2
    yGmin=-2;            % yGmin=-2

    w_steptime=5;        % w_steptime=5
    wdach=1;             % wdach=1
    
    z_steptime=0;        % z_steptime=0
    zdach=1;             % zdach=1
       
    te=10;               % te=10
    
% ########################################################

close all
fonts=8;

% Koordinatenachsen dimensionieren
Dxtick=1;
z_ampl=[-5 5];
wx_ampl=[-2.5 2.5];
y_ampl=[-5 5];

% Stellbereich berechnen
ystat=Kpr*Kps/(1+Kpr*Kps)*zdach

% Strecke
s=tf('s');
Gs=Kps/(T1*s+1);     % P-T1-Strecke
Gszae=Gs.num{1};
Gsnen=Gs.den{1};


t0A=-1;       % Beginn der t-Achse in den Grafiken
teE=te;       % Ende der t-Achse in den Grafiken
te=te-t0A;   %  Simulationsintervallanpassung

w_steptime=w_steptime-t0A;
z_steptime=z_steptime-t0A;
wdach_=wdach;
zdach_=zdach;    


figure(1)
set(gcf,'Units','normal','Position',[.5 .1 .48 .8], ...
    'NumberTitle','off','MenuBar','fig',...
    'Name',' Beispiel 4.4: Einfluss Stellbereich bei P-Regler und PT1-Strecke');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.3,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)

% Simulationsparameter
opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);


% Führungs- und Störverhalten

[t,x,y]=sim('s0404Bsp',[0 te],opts);

t=t0A+t;   % Sprünge und -antworten in Diagrammen um 1 nach links

subplot(3,1,1)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-30 30];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on
if exist('yalt','var')==1, plot(talt,yalt(:,2),'b','linewidth',2), end
plot(t,y(:,2),'k','linewidth',2)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[0:Dxtick:teE],...
    'ylim',z_ampl,...
    'ytick',[-30:1:30]);
xlabel('t \rightarrow'); 
ylabel('z \rightarrow')
title(['Gesamtverhalten mit Stellbeschränkung'])


subplot(3,1,2)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-30 30];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on
if exist('yalt','var')==1, plot(talt,yalt(:,1),'b','linewidth',2), end
if exist('yalt','var')==1, plot(talt,yalt(:,3),'b','linewidth',1), end
plot(t,y(:,1),'k','linewidth',2)
plot(t,y(:,3),'k','linewidth',1)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[0:Dxtick:teE],...
    'ylim',wx_ampl,...
    'ytick',[-30:.5:30]);
xlabel('t \rightarrow'); 
ylabel('w, x \rightarrow')


subplot(3,1,3)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-30 30];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on
plot([t0A teE],[yGmin yGmin],'r:',[t0A teE],[yGmax yGmax],'r:')
if exist('yalt','var')==1, plot(talt,yalt(:,4),'b','linewidth',1), end
plot(t,y(:,4),'k','linewidth',1)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-0:Dxtick:teE],...
    'ylim',y_ampl,...
    'ytick',[-30:1:30]);
xlabel('t \rightarrow'); 
ylabel('y \rightarrow')

%end

talt=t;
yalt=y;










