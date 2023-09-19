%  m0108d.m     (Mabtlab/Simulink R2007b)
%
%  Bild 1.8d
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  s0108d.mdl
%
%  (c) 5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%  
%
% ########################################################
clear all

   

% ########################################################
clc
close all


% Strecke:
s=tf('s');
%Gs=10/(60*s+1)/(0.1*s+1)^3;
Gs=10/(60*s+1)/(.1*s+1);
Tt=.4;

% Regler
Kpr=10;


% Störsprungantwort der Regeldifferenz:
sAdach=.2;
tend=8;

opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.001);

[t,x,y]=sim('s0108d',[0 tend],opts);

figure(1)
set(gcf,'Units','normal',...
    'Position',[.6 .3 .3 .5],...
    'NumberTitle','off','Name',' Bild 1.8d');
ha=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes(ha)

subplot(3,1,1)
tachs1=[0 tend]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
hold on
set(gca,'box',      'on',...
    'xgrid',    'off',...
    'xlim',     [0 tend],...
    'xtick',    [],...
    'xlabel',    text(0,0,'t'),...
    'ygrid',    'off',...
    'ylim',     [0 1],...
    'ytick',    [],...
    'ylabel',    text(0,0,'s_A ')...
    )
y(:,1)=y(:,1)+.5;
plot(t,y(:,1),'k','linewidth',1.5)


subplot(3,1,2)
tachs1=[0 tend]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
hold on
set(gca,'box',      'on',...
    'xgrid',    'on',...
    'xlim',     [0 tend],...
    'xtick',    [],...
    'xlabel',    text(0,0,'t'),...
    'ygrid',    'on',...
    'ylim',     [0 .15],...
    'ytick',    [],...
    'ylabel',    text(0,0,'h')...
    )
Sollwert=.1;
y(:,2)=y(:,2)+Sollwert;
plot(t,y(:,2),'k','linewidth',1.5)
w=[Sollwert Sollwert];
plot(tachs1,w,'k','linewidth',1.5)


subplot(3,1,3)
tachs1=[0 tend]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
hold on
set(gca,'box',      'on',...
    'xgrid',    'on',...
    'xlim',     [0 tend],...
    'xtick',    [],...
    'xlabel',    text(0,0,'t'),...
    'ygrid',    'on',...
    'ylim',     [0 1],...
    'ytick',    [],...
    'ylabel',    text(0,0,'s_Z')...
    )
y(:,3)=y(:,3)+.5;
plot(t,y(:,3),'k','linewidth',1.5)

