%  m0405Bsp.m    (Für MATLAB/SIMULINK R2007b)
%
%  P-Regler und P-T1-Strecke, Vorfilter
%
%  Beispiel 4.5
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0405Bsp.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%    wsk  Skalenwert der Führungsgrösse   
%                   im Bereich    40 < wsk < 80
%
%    te   Simulationsdauer
%
%  Die Grafik zeigt zusätzlich links das Einheitsstör-
%  verhalten der Strecke (Daten s.u. unter "Strecke" und
%  zugehörige mdl-Datei) 
%
% ########################################################
clear
    
    wsk=80       % wsk=80
    
    te=10;       % te=10
    
% ########################################################

close all
fonts=8;

% P-Regler
KprWerte=[ 20];  % KprWerte=[1 2 4]  

% Strecke:
Kps=.8;   % Kps=.8
T1=30;    % T1=2
s=tf('s');
Gs=Kps/(T1*s+1);
Gszae=Gs.num{1};
Gsnen=Gs.den{1};


% Koordinatenachsen dimensionieren
Dxtick=1;
St_z_ampl=[-.5 1.5];
St_wx_ampl=[-.2 .1];
St_y_ampl=[-1 2];
Fu_z_ampl=[-.5 1.5];
Fu_wx_ampl=[-10 100];
Fu_y_ampl=[-200 2000];

t0A=-.5;      % Beginn der t-Achse in den Grafiken
teE=te;      % Ende der t-Achse in den Grafiken
te=te-t0A;   %  Simulationsintervallanpassung

%wdach=80; 
w_steptime=-t0A;
zdach=1; 
z_steptime=-t0A;

figure(1)
set(gcf,'Units','normal','Position',[.5 .4 .48 .4], ...
    'NumberTitle','off','MenuBar','fig',...
    'Name',' Beispiel 4.5: Vorfilter bei Temperaturregelung');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)

% Simulationsparameter
opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);

n=size(KprWerte,2);
for i=1:1
Kpr=KprWerte(i);

% Vorfilter
Kv=(1+Kpr*Kps)/Kpr/Kps
wdach=Kv*wsk


% Störverhalten
wdach_=0;
zdach_=zdach;    

[t,x,y]=sim('s0405Bsp',[0 te],opts);

t=t0A+t;   % Sprünge und -antworten in Diagrammen um 1 nach links

subplot(3,2,1)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-2 2];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on
plot(t,y(:,2),'k','linewidth',2)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[0:Dxtick:teE],...
    'ylim',St_z_ampl,...
    'ytick',[-3:.5:10]);
xlabel('t \rightarrow'); 
ylabel('z \rightarrow')
title(['Störverhalten'])


subplot(3,2,3)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-2 2];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on
plot(t,y(:,1),'k','linewidth',2)
plot(t,y(:,3),'k','linewidth',1)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[0:Dxtick:teE],...
    'ylim',St_wx_ampl,...
    'ytick',[-3:.1:10]);
xlabel('t \rightarrow'); 
ylabel('w, x \rightarrow')


subplot(3,2,5)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on
plot(t,y(:,4),'k','linewidth',1)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-0:Dxtick:teE],...
    'ylim',St_y_ampl,...
    'ytick',[-10:1:10]);
xlabel('t \rightarrow'); 
ylabel('y \rightarrow')




% Führungsverhalten:

wdach_=wsk;   
zdach_=0;

[t,x,y]=sim('s0405Bsp',[0 te],opts);

t=t0A+t;

subplot(3,2,2)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 100];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on
plot(t,y(:,2),'k','linewidth',2)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[0:Dxtick:teE],...
    'ylim',Fu_z_ampl,...
    'ytick',[-3:.5:10]);
xlabel('t \rightarrow'); 
ylabel('z \rightarrow')
title(['Führungsverhalten'])


subplot(3,2,4)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 100];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off 
hold on
plot(t,y(:,1),'k','linewidth',2)
plot(t,y(:,3),'k','linewidth',1)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-0:Dxtick:teE],...
    'ylim',Fu_wx_ampl,...
    'ytick',[-20:20:100]);
xlabel('t \rightarrow'); 
ylabel('w, x \rightarrow')

subplot(3,2,6)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-100 2000];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off
hold on
plot(t,y(:,4),'k','linewidth',1)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-0:Dxtick:teE],...
    'ylim',Fu_y_ampl,...
    'ytick',[-400:400:2000]);
xlabel('t \rightarrow'); 
ylabel('y \rightarrow')

end










