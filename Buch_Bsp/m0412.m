%  m0412.m    (Für MATLAB/SIMULINK R2007b)
%
%  I-Regler un P-T1-Strecke ohne/mit Anti-Windup
%
%  Bild 4.12
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0412.mdl
%
%  (c)5.7.09 R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%    ymin < y < ymax    Stellgrössenbegrenzung 
%
%    TB   Zeitkonstante für Einschwingen auf ymin bzw. ymax
%             0.1 < TB < 0.001
%
%    te   Simulationsdauer
%
% ########################################################
clear
    
    ymax=1.2;         % ymax=1.2
    ymin=-ymax;       % ymin=-ymax
    
    TB=0.5;           % TB=0.5
    
    te=40;            % te=40
    
% ########################################################

close all
fonts=8;

% I-Regler
KirWerte=[.5];    % KirWerte=[.5]  

% Strecke:
Kps=1;   
T1=2;    % 1
s=tf('s');
Gs=Kps/(T1*s+1);
Gszae=Gs.num{1};
Gsnen=Gs.den{1};

% Koordinatenachsen dimensionieren
Dxtick=5;
St_z_ampl=[-.5 2.];
St_wx_ampl=[-1.5 1.5];
St_y_ampl=[-1 5];
Fu_z_ampl=[-.5 2.];
Fu_wx_ampl=[-1.5 1.5];
Fu_y_ampl=[-1 5];

wdach=1.5; 
zdach=1.5; 

t0A=-1   % Beginn der t-Achse in den Grafiken
teE=te   % Ende der t-Achse in den Grafiken
te=te-t0A;   %  Simulationsintervallanpassung
    

figure(1)
set(gcf,'Units','normal','Position',[.5 .4 .48 .4], ...
    'NumberTitle','off','MenuBar','fig',...
    'Name',' Bild 4.12: I-Regler m/o Anti-Windup und P-T1-Strecke');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)

% Simulationsparameter
opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);

n=size(KirWerte,2)
for i=1:n
Kir=KirWerte(i);


% Störverhalten OHNE Anti-Windup
wdach_=0;
zdach_=zdach;    

[t,x,y]=sim('s0412',[0 te],opts);

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
title(['Störverhalten OHNE Anti-Windup'])


subplot(3,2,3)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-2 2];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off; 
hold on
plot(t,y(:,1),'k','linewidth',2)
plot(t,y(:,3),'k','linewidth',2)
plot(t,y(:,6),'k:','linewidth',1)
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
plot([t0A teE],[ymin ymin],'k--',[t0A teE],[ymax ymax],'k--')
plot(t,y(:,5),'k','linewidth',2)
plot(t,y(:,7),'k:','linewidth',1)
plot(t,y(:,4),'k','linewidth',1)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-0:Dxtick:teE],...
    'ylim',St_y_ampl,...
    'ytick',[-30:1:10]);
xlabel('t \rightarrow'); 
ylabel('y \rightarrow')




% Störverhalten MIT Anti-Windup

wdach_=0;   
zdach_=zdach;

[t,x,y]=sim('s0412',[0 te],opts);

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
title(['Störverhalten MIT Anti-Windup'])


subplot(3,2,4)
tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-2 2];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')
grid off 
hold on
plot(t,y(:,1),'k','linewidth',2)
%plot(t,y(:,3),'g','linewidth',1)
plot(t,y(:,6),'k:','linewidth',1)
plot(t,y(:,8),'k','linewidth',2)
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
plot([t0A teE],[ymin ymin],'k--',[t0A teE],[ymax ymax],'k--')
%plot(t,y(:,5),'r','linewidth',1)
plot(t,y(:,7),'k:','linewidth',1)
%plot(t,y(:,4),'g','linewidth',1)
plot(t,y(:,9),'k','linewidth',1)
plot(t,y(:,10),'k','linewidth',2)
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-0:Dxtick:teE],...
    'ylim',Fu_y_ampl,...
    'ytick',[-10:1:10]);
xlabel('t \rightarrow'); 
ylabel('y \rightarrow')


end










