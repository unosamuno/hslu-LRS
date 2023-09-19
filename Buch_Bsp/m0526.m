%  m0526.m     (Matlab/Simulink R2007b)
%
%  Bild 5.26
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  s0526.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   Kir  Reglerverstärkung im Bereich  0.1 < Kir < 20
%
%
% ########################################################
clear

      Kir=.66;       % Voreinstellung Kpr=0.66

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;


% P-T1-Strecke: 
Kps=1.5;  
T1=0.25;


% Störsprungantwort der Regeldifferenz:
stept0=0.001; 
zdach=1;
tend=5; 

opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);

[t,x,y]=sim('s0526',[0 tend],opts);

figure(1)
set(gcf,'Units','normal','Position',[.6 .55 .35 .35], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 5.26');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

tachs1=[0 tend]; tachs2=[0 0]; 
plot(tachs1,tachs2,'k')
grid on, hold on
set(gca,'FontSize',fonts,...
    'Position',[.15 .2 .75 .7],...
    'YTick',[-2:.2:.2]);
axis([0 tend -1.2 0.4])
title(' Regeldifferenz');
xlabel('t \rightarrow'), ylabel('e \rightarrow')
plot(t,y(:,1),'b')

figure(2)
set(gcf,'Units','normal','Position',[.6 .1 .35 .35], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Zu Bild 5.26');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

tachs1=[0 tend]; tachs2=[0 0]; 
plot(tachs1,tachs2,'k')
grid on, hold on
set(gca,'FontSize',fonts,...
    'Position',[.15 .2 .75 .7],...
    'YTick',[-2:.5:2]);
axis([0 tend -2. .5])
title(' Zugehöriger Stellgrößenverlauf');
xlabel('t \rightarrow'), ylabel('y \rightarrow')
plot(t,y(:,2),'b')
