%  m0312b.m     (Matlab/Simulink R2007b)
%
%  Bild 3.12 
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0312b.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%    
%   ydach     Sprunghöhe der Stellgröße, -1.5<ydach<1.5
%
%
% ########################################################
clear

    ydach=1;        % ydach=1


% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

s=tf('s');

% Strecke mit Ausgleich, PTn-Glied
R=1;
b=1;
V=1;
T1=b*V*R/2;

% Integrationsschleife:
te=30;

figure(1)
set(gcf,'Units','normal','Position',[.65 .7 .3 .2], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 3.12a  Sprungfunktion');

set(gca,'FontSize',fonts,...
    'XLim',[-2 te],...
    'XTick',[0],...
    'YLim',[0 1.5],...
    'YTick',[0:.5:2],...
    'NextPlot','add',...
    'Box','on');
tachs1=[-2 te]; tachs2=[0 0];
yachs1=[0 0]; yachs2=[-2 2];
plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
tGGx=[-2 0]; tGGy=[0 0];
plot(tGGx,tGGy,'k','linewidth',1.5)
grid off
xlabel('t  \rightarrow')
ylabel('y  \rightarrow')


figure(2)
set(gcf,'Units','normal','Position',[.65 .4 .3 .2], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 3.12b Sprungantwort');

set(gca,'FontSize',fonts,...
    'XLim',[-2 te],...
    'XTick',[0],...
    'YLim',[0 .16],...
    'YTick',[0:.04:.2],...
    'NextPlot','add',...
    'Box','on');
tachs1=[-2 te]; tachs2=[0 0];
yachs1=[0 0]; yachs2=[-2 2];
plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
tGGx=[-2 0]; tGGy=[0 0];
plot(tGGx,tGGy,'k','linewidth',1.5)
grid off
xlabel('t  \rightarrow')
ylabel('x  \rightarrow')


    opts=simset('Solver','ode45',...
        'InitialState',[],...
        'MaxStep',.01);
    [t,x,y]=sim('s0312b',[0 te],opts);


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
    
    %plot(t,y(:,2),'k-','linewidth',1.5)    %  PT1
    hold on
    %plot(t,y(:,3),'k-','linewidth',1.5)    %  Verzög. 2. Ordn.
    %plot(t,y(:,4),'k-','linewidth',1.5)    %  Verzög. 3. Ordn.
    
    %plot(t,y(:,5),'k-','linewidth',1.5)    %  Verzög. 4. Ordn.
    %plot(t,y(:,6),'k-','linewidth',1.5)    %  Verzög. 5. Ordn.
     plot(t,y(:,7),'k-','linewidth',1.5)    %  Verzög. 6. Ordn.

