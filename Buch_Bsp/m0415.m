%  m0415.m     (MATLAB/SIMULINK R2007b)
%
%  PI-Regler mit Anti-Windup 
%  
%  Bild 4.15
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2008
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0415.mdl 
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   Kpr     Proportionalbeiwert P-Anteil
%           im Bereich  ymax-0.3  < Kpr  <  ymax+0.3
%   Kir     Proportionalbeiwert I-Anteil
%           im Bereich  -.1  < Kir  <  .3
%   edach   Sprunghöhe Regeldifferenz
%           im Bereich  -1  < edach  <  1.
%   ymax    obere Begrenzung der Stellgrösse
%           im Bereich  .1 < ymax  <  1
%   ymin    untere Begrenzung der Stellgrösse
%           im Bereich  -1 < ymin  <  -.1
%   TB      Zeitkonstante für Einschwingen auf ymin bzw. ymax
%           0.1 < TB < 0.001
%
% ########################################################
clear
  Kpr=.8;            % Kpr=.2 oder .8 
  Kir=.2;            % Kir=.2
  edach =1;          % edach=1
  ymax=.5;           % ymax=.5
  ymin=-.5;          % ymin=-.5
  TB=.5;             % TB=.1

  te=40;  
  
% ########################################################
close all
menu='fig';  % none oder fig
fonts=8;


figure(1)   
set(gcf,'Units','normal','Position',[.47 .05 .51 .85], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' PI-Regler ohne/mit Anti-Windup');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.2,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

t0g=0;  % Start Grafik

opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',te/1000);
[t,x,y]=sim('s0415',[0 te],opts);


subplot(4,1,1)
plot([t0g te],[0 0],'k');
hold on
plot(t,y(:,1),'k','linewidth',2)
grid on
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0g te],...
    'xtick',[-10:10:te],...
    'ylim',[-2 2],...
    'ytick',[-3:.5:10]);
xlabel('t'); 
ylabel('e')
title(['Analoger PI-Regler ohne/mit Anti-Windup'])

subplot(4,1,2)
plot([t0g te],[0 0],'k');
hold on
% Begrenzung
plot([t0g te],[ymax ymax],'r:','linewidth',2)
plot([t0g te],[ymin ymin],'r:','linewidth',2)

plot(t,y(:,2),'k','linewidth',2)
plot(t,y(:,5),'m--','linewidth',2)
grid on
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0g te],...
    'xtick',[-10:10:te],...
    'ylim',[-3 3],...
    'ytick',[-3:1:10]);
xlabel('t'); 
ylabel('yR, y')

subplot(4,1,3)
plot([t0g te],[0 0],'k');
hold on
% Begrenzung
plot([t0g te],[ymax ymax],'r:','linewidth',2)
plot([t0g te],[ymin ymin],'r:','linewidth',2)

plot(t,y(:,3),'k','linewidth',2)
plot(t,y(:,6),'g--','linewidth',2)
grid on
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0g te],...
    'xtick',[-10:10:te],...
    'ylim',[-1 1],...
    'ytick',[-40:.5:40]);
xlabel('t'); 
ylabel('yRA, yA')


subplot(4,1,4)
plot([t0g te],[0 0],'k');
hold on
plot(t,y(:,7),'m--','linewidth',2)
plot(t,y(:,8),'g--','linewidth',2)
grid on
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0g te],...
    'xtick',[-10:10:te],...
    'ylim',[-.4 .4],...
    'ytick',[-30:.1:30]);
xlabel('t'); 
ylabel('uI, uIA')

