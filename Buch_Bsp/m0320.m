%  m0320.m     (Matlab/Simulink R2007b)
%
%  Bild 3.20 
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  10.Aufl., Hanser-Verlag, München, 2005
%  ISBN 3-446-40303-5
%
%  Unterprogramme: s0320.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%    
%   ydach     Sprunghöhe der Stellgröße, -1.5<ydach<1.5
%   Kis       Proportionalbeiwert, -1.2 < Kps < 1.2
%
% ########################################################
clear

    ydach=1;        % ydach=1
    Kis=.5;          % Kps=1    

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

s=tf('s');

% Strecke mit Ausgleich, ohne Verzögerung
G=Kis/s;

zae=G.num{1};
nen=G.den{1};

% Integrationsschleife:
te=5;

figure(1)
set(gcf,'Units','normal','Position',[.65 .7 .3 .2], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 3.20a  Sprungfunktion');

set(gca,'FontSize',fonts,...
    'XLim',[-.5 te],...
    'XTick',[0:1:te],...
    'YLim',[0 1.5],...
    'YTick',[0:.5:2],...
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
    'Name',' Bild 3.20b Ohne Ausgl., ohne Verzög.');

set(gca,'FontSize',fonts,...
    'XLim',[-.5 te],...
    'XTick',[0:1:te],...
    'YLim',[0 2],...
    'YTick',[0:.5:2],...
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
    'MaxStep',.1);
[t,x,y]=sim('s0320',[0 te],opts);


figure(1)
ysprungx=[0 0];
if ydach>0
    ysprungy=[0 ydach];
else
    ysprungy=[ydach 0];
end
plot(ysprungx,ysprungy,'k','linewidth',1.5)
plot(t,y(:,1),'k-','linewidth',1.5)    %  y


figure(2)
if ydach>0
    ysprungy=[0 y(1,2)];
else
    ysprungy=[y(1,2) 0];
end
plot(ysprungx,ysprungy,'k','linewidth',1.5)
plot(t,y(:,2),'k-','linewidth',1.5)    %  x
