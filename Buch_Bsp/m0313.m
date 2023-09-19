%  m313.m     (Matlab/Simulink R2007b)
%
%  Bild 3.13 
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0313.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%    
%   ydach     Sprunghöhe der Stellgröße, -1.5<ydach<1.5
%   Kps       Proportionalbeiwert, -1.2 < Kps < 1.2
%   T1        Zeitkonstante, 0 < T1 < 10
%
% ########################################################
clear

    ydach=1;        % ydach=1
    Kps=1;          % Kps=1
    T1=1;           % T1=1


% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

s=tf('s');

% Strecke mit Ausgleich, PTn-Glied

% Integrationsschleife:
te=14;

figure(1)
set(gcf,'Units','normal','Position',[.65 .7 .3 .2], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 3.13  Sprungfunktion');

set(gca,'FontSize',fonts,...
    'XLim',[-.5 te],...
    'XTick',[0],...
    'YLim',[0 1.5],...
    'YTick',[0],...
    'NextPlot','add',...
    'Box','on');
tachs1=[0 te]; tachs2=[0 0];
yachs1=[0 0]; yachs2=[-2 2];
plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
tGGx=[-1 0]; tGGy=[0 0];
plot(tGGx,tGGy,'k','linewidth',1.5)
grid off
xlabel('t  \rightarrow')
ylabel('y  \rightarrow')


figure(2)
set(gcf,'Units','normal','Position',[.65 .4 .3 .2], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 3.13 Sprungantworten');

set(gca,'FontSize',fonts,...
    'XLim',[-.5 te],...
    'XTick',[0],...
    'YLim',[0 1.1],...
    'YTick',[0],...
    'NextPlot','add',...
    'Box','on');
tachs1=[-.5 te]; tachs2=[0 0];
yachs1=[0 0]; yachs2=[-2 2];
plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
tGGx=[-1 0]; tGGy=[0 0];
plot(tGGx,tGGy,'k','linewidth',1.5)
grid off
xlabel('t  \rightarrow')
ylabel('x  \rightarrow')


opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);
[t,x,y]=sim('s0313',[0 te],opts);


figure(1)           %  y
ysprungx=[0 0];
if ydach>0
    ysprungy=[0 ydach];
else
    ysprungy=[ydach 0];
end
plot(ysprungx,ysprungy,'k','linewidth',1.5)

plot(t,y(:,1),'k-','linewidth',1.5)


figure(2)            % x

%plot(t,y(:,2),'k-','linewidth',1.5)
hold on
plot(t,y(:,3),'k-','linewidth',1.5)
plot(t,y(:,4),'k-','linewidth',1.5)
plot(t,y(:,5),'k-','linewidth',1.5)
plot(t,y(:,6),'k-','linewidth',1.5)
plot(t,y(:,7),'k-','linewidth',1.5)

