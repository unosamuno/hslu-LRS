%  m0109b.m     (Matlab/Simulink R2007b)
%
%  Bild 1.9b
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  s0109b.mdl
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
Gs=1/(8*s+1)^3;


Kpr=1;

% Störsprungantwort der Regeldifferenz:
zdach=-.3;
wdach=0;
tend=100;

opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);

[t,x,y]=sim('s0109b',[0 tend],opts);

figure(1)
set(gcf,'Units','normal',...
    'Position',[.6 .3 .3 .5],...
    'NumberTitle','off','Name',' Bild 1.9b');
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
    'ylim',     [0.2 .9],...
    'ytick',    [],...
    'ylabel',    text(0,0,'\vartheta_a ')...
    )
z0=.7;
y(:,1)=y(:,1)+z0;
plot(t,y(:,1),'k','linewidth',2)


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
    'ylim',     [19.6 20.1],...
    'ytick',    [],...
    'ylabel',    text(0,0,'T')...
    )
x0=20;                               % gewünschte Raumtemp.
x=x0+[wdach wdach];
plot(tachs1,x,'k','linewidth',1.5)
y(:,2)=y(:,2)+x0;                    % mit Regelung
plot(t,y(:,2),'k','linewidth',1.5)
y(:,4)=y(:,4)+x0;                    % ohne Regelung
plot(t,y(:,4),'k--','linewidth',1.5)


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
    'ylim',     [.3 .8],...
    'ytick',    [],...
    'ylabel',    text(0,0,'s_Z')...
    )
y0=.5;
y0_line=[y0 y0];                             % ohne Regelung
plot(tachs1,y0_line,'k--','linewidth',1.5)
y(:,3)=y(:,3)+y0;                            % mit Regelung
plot(t,y(:,3),'k','linewidth',1.5)

