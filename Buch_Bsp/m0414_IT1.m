%  m0414_IT1.m    (Für MATLAB/SIMULINK R2007b)
%
%  PI-Regler und I-T1-Strecke  Gs=1/s/(2*s+1)
%
%  Abschn. 4.2.3
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0414.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%    KprWerte=[ Kpr1 Kpr2 ... ]  P-Beiwerte    
%                   im Bereich    .1  < Kpri <  10 ,
%
%    KirWerte=[ Kir1 Kir2 ... ]  I-Beiwerte
%                   im Bereich    .1  < Kiri <  10 ,
%
%    te    Simulationsdauer
%
% ########################################################
clear
    
    KprWerte=[2    2];     % KprWerte=[ 2  2  ]  

    KirWerte=[0   .3];     % KirWerte=[ 0  .3 ] 
   
    te=24;                 % te=24
    
% ########################################################

close all
fonts=8;

% Strecke:
Kps=1;   
T1=2;    % 1
s=tf('s');
Gs=Kps/s/(T1*s+1);
Gszae=Gs.num{1};
Gsnen=Gs.den{1};


% Koordinatenachsen dimensionieren
Dxtick=2;
St_z_ampl=[-.5 1.5];
St_wx_ampl=[-1 .5];
St_y_ampl=[-2 3];
Fu_z_ampl=[-.5 1.5];
Fu_wx_ampl=[-.5 2];
Fu_y_ampl=[-2 3];

wdach=1; 
zdach=1; 

t0A=-1;       % Beginn der t-Achse in den Grafiken
teE=te;       % Ende der t-Achse in den Grafiken
te=te-t0A;   %  Simulationsintervallanpassung
    
figure(1)
set(gcf,'Units','normal','Position',[.5 .4 .48 .4], ...
    'NumberTitle','off','MenuBar','fig',...
    'Name',' Abschn. 4.2.3: PI-Regler und I-T1-Strecke (gestrichelt: P-Regler)');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)

% Simulationsparameter
opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);

n=size(KprWerte,2);
for i=1:n
Kpr=KprWerte(i);
Kir=KirWerte(i);
Tn=Kpr/Kir

% Störverhalten
wdach_=0;
zdach_=zdach;    

[t,x,y]=sim('s0414',[0 te],opts);

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
zachs1=[ 0 0]; zachs2=[-5 2];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on
plot(t,y(:,1),'k','linewidth',2)
if i==1, plot(t,y(:,3),'k:','linewidth',1), end
if i==2, plot(t,y(:,3),'k','linewidth',1), end
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[0:Dxtick:teE],...
    'ylim',St_wx_ampl,...
    'ytick',[-3:.5:10]);
xlabel('t \rightarrow'); 
ylabel('w, x \rightarrow')


subplot(3,2,5)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on

if i==1, plot(t,y(:,4),'k:','linewidth',1), end
if i==2, plot(t,y(:,4),'k','linewidth',1), end

set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-0:Dxtick:teE],...
    'ylim',St_y_ampl,...
    'ytick',[-3:1:10]);
xlabel('t \rightarrow'); 
ylabel('y \rightarrow')




% Führungsverhalten:

wdach_=wdach;   
zdach_=0;

[t,x,y]=sim('s0414',[0 te],opts);

t=t0A+t;

subplot(3,2,2)
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
    'ylim',Fu_z_ampl,...
    'ytick',[-3:.5:10]);
xlabel('t \rightarrow'); 
ylabel('z \rightarrow')
title(['Führungsverhalten'])


subplot(3,2,4)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-2 2];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off 
hold on
plot(t,y(:,1),'k','linewidth',2)

if i==1, plot(t,y(:,3),'k:','linewidth',1), end
if i==2, plot(t,y(:,3),'k','linewidth',1), end

set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-0:Dxtick:teE],...
    'ylim',Fu_wx_ampl,...
    'ytick',[-3:.5:10]);
xlabel('t \rightarrow'); 
ylabel('w, x \rightarrow')



subplot(3,2,6)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off
hold on

if i==1, plot(t,y(:,4),'k:','linewidth',1), end
if i==2, plot(t,y(:,4),'k','linewidth',1), end

set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-0:Dxtick:teE],...
    'ylim',Fu_y_ampl,...
    'ytick',[-3:1:10]);
xlabel('t \rightarrow'); 
ylabel('y \rightarrow')


end










