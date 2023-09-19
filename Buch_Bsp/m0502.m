%  m0502.m     (Matlab/Simulink R2007b)
%
%  Bild 5.2 a und b
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0502.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%    wdach  Sprunghöhe der Führungsgröße
%                   im Bereich  0 < wdach < 1
%    eps    Auf wdach bezogener Toleranzbereich 
%                   im Bereich  1% < eps < 20%
%
%    zdach  Sprunghöhe der Störgröße
%                   im Bereich  0 < zdach < 1
%    epss   Auf zdach bezogener Toleranzbereich
%                         im Bereich  1% < epss < 20%
%
%    Kpr    P-Beiwert im Bereich    10  < Kpr <  40 
%    Tv     Vorhaltzeit im Bereich    0.5 < Tv  <   2 
%
% ########################################################
clear

    wdach=1;      %  wdach=1
    eps=15;       %  eps=15
    zdach=1;      %  zdach=1
    epss=5;       %  epss=5

    Kpr=20;       %  Kpr=20  
    Tv=1.8;       %  Tv=1.8

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

% Stellstrecke:
Kps=.5;   
T1=.5;    % .7
s=tf('s');
Kps=.5;   
T1=.5;    % .7
Gs=Kps/(T1*s+1)^3;
zaeStell=Gs.num{1};
nenStell=Gs.den{1};

% Störstrecke:
Kps=.5;   
T1=.5; 
om0=15;
d=.3;
T2=1/om0; 
T1a=2*d/om0;
Gsz=Kps/(T1*s+1)/(T2^2*s^2+T1a*s+1);
zaeStoer=Gsz.num{1};
nenStoer=Gsz.den{1}

% PD-Regler:
rzae=Kpr*[Tv 1];
rnen=[.005 1];

tend=2;            % Simulationsdauer

eps=eps*wdach/100;
epss=epss*zdach/100;


% Führungsverhalten:
figure(1)
set(gcf,'Units','normal','Position',[.6 .1 .35 .35], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 5.2b: Führungsverhalten');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)

wdach_=wdach;
zdach_=0;    

ogrenz=wdach_ + eps;      % Toleranzbereich
ugrenz=wdach_ - eps;
ugrgraf=[ugrenz ugrenz];
ogrgraf=[ogrenz ogrenz];

opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);

[t,x,y]=sim('s0502',[0 tend],opts);

subplot(2,1,1)
tachs1=[-.5 tend]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-.5 2];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid on; hold on
set(gca,'FontSize',fonts,...
    'Position',[.2 .65 .65 .3]);
axis([-.5 tend -.5 2])
xlabel('t \rightarrow')
ylabel('z \rightarrow')
plot(t,y(:,2),'m','LineW',2)
tm=[-.5 0]; fm=[0 0];
plot(tm,fm,'m','LineW',2)

subplot(2,1,2)
tachs1=[-.5 tend]; tachs2=[ 0 0 ];
xachs1=[ 0 0]; xachs2=[-.5 2];
plot(tachs1,tachs2,'k',xachs1,xachs2,'k')
grid on; hold on
set(gca,'FontSize',fonts,...
    'Position',[.2 .15 .65 .3],...
    'YTick',[-1:.5:3]);
axis([-.5 tend -.5 2])
xlabel('t \rightarrow')
ylabel('w , x \rightarrow')
plot(t,y(:,1),'g','LineW',2)
tgrenz=[0 tend];   
plot(tgrenz,ugrgraf,'r',tgrenz,ogrgraf,'r')
plot(t,y(:,3),'b')
tm=[-.5 0]; fm=[0 0];
plot(tm,fm,'g','LineW',2)
tn=[0 0]; fn=[0 wdach];
plot(tn,fn,'g','LineW',2)



% Störverhalten:
figure(2)
set(gcf,'Units','normal','Position',[.6 .55 .35 .35], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 5.2a: Störverhalten');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)

wdach_=0;   
zdach_=zdach;

ogrenz=wdach_ + epss;     % Toleranzbereich
ugrenz=wdach_ - epss;
ugrgraf=[ugrenz ugrenz];  
ogrgraf=[ogrenz ogrenz];

opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);

[t,x,y]=sim('s0502',[0 tend],opts);

subplot(2,1,1)
tachs1=[-.5 tend]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-.5 2];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid on; hold on
set(gca,'FontSize',fonts,...
    'Position',[.2 .65 .65 .3]);
axis([ -.5 tend -.5 2])
xlabel('t \rightarrow')
ylabel('z \rightarrow')
plot(t,y(:,2),'m','LineW',2)
tm=[-.5 0]; fm=[0 0];
plot(tm,fm,'m','LineW',2)
tn=[0 0]; fn=[0 zdach];
plot(tn,fn,'m','LineW',2)


subplot(2,1,2)
tachs1=[-.5 tend]; tachs2=[ 0 0 ];
xachs1=[ 0 0]; xachs2=[-.5 2];
plot(tachs1,tachs2,'k',xachs1,xachs2,'k')
grid on; hold on
plot(t,y(:,1),'g',t,y(:,3),'b', tgrenz,ugrgraf,'r',tgrenz,ogrgraf,'r'); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .15 .65 .3],...
    'XTick',[-.5:.5:2],'YTick',[-1:.2:1]);
axis([-.5 tend -.2 .6])
xlabel('t \rightarrow')
ylabel('w , x \rightarrow')
plot(t,y(:,1),'g','LineW',2)
plot(tgrenz,ugrgraf,'r',tgrenz,ogrgraf,'r')
plot(t,y(:,3),'b')
tm=[-.5 0]; fm=[0 0];
plot(tm,fm,'g','LineW',2)

% Störverhalten ungeregelt:
rzae=0;
[t,x,y]=sim('s0502',[0 tend],opts);
plot(t,y(:,3),'b:')





