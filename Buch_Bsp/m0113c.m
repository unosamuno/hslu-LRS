%  m0113c.m     (Matlab/Simulink R2007b)
%
%  Bild 1.13c
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  s0113c.mdl
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
Gs=180/(.2*s+1)^3;

% Sollwert
Tsoll=100;

% Regler
Kpr=10;


% Störsprungantwort der Regeldifferenz:
sAdach=.2;
tend=1.3;

opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);

[t,x,y]=sim('s0113c',[0 tend],opts);

figure(1)
set(gcf,'Units','normal',...
    'Position',[.6 .3 .3 .3],...
    'NumberTitle','off','Name',' Bild 1.13c');
ha=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes(ha)

tachs1=[0 tend]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
hold on
set(gca,'box',      'on',...
    'xgrid',    'off',...
    'xlim',     [0 tend],...
    'xtick',    [],...
    'xlabel',    text(0,0,'t'),...
    'ygrid',    'off',...
    'ylim',     [0 130],...
    'ytick',    [],...
    'ylabel',    text(0,0,'T ')...
    )
y(:,1)=y(:,1)+0;
plot(t,y(:,1),'k','linewidth',1.5)
w=[Tsoll Tsoll];
plot(tachs1,w,'k','linewidth',1.5)
yplot=50*y(:,2)+0;
plot(t,yplot,'k','linewidth',1.5)

