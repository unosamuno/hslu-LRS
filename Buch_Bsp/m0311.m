%  m0311.m     (Matlab/Simulink R2007b)
%
%  Bild 3.11 
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0311.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%    
%   ydach     Sprunghöhe der Stellgröße, -1.5<ydach<1.5
%   Kps       Proportionalbeiwert, -1.2 < Kps < 1.2
%
%             (Dämpfungsgrad: d=.2 und d=2 fest)
%
% ########################################################
clear

    ydach=1;        % ydach=1
    Kps=1;          % Kps=1


% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

s=tf('s');

% Strecke mit Ausgleich, ohne Verzögerung
om0=5;
T2=1/om0;

% Integrationsschleife:
te=5;

figure(1)
set(gcf,'Units','normal','Position',[.65 .7 .3 .2], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 3.11a  Sprungfunktion');

set(gca,'FontSize',fonts,...
    'XLim',[-.5 te],...
    'XTick',[0],...
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
    'Name',' Bild 3.11b Sprungantwort');

set(gca,'FontSize',fonts,...
    'XLim',[-.5 te],...
    'XTick',[0],...
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

for i=1:2
    if i==1
        d=.2;
    end
    if i==2
        d=2;
    end
    T1=2*d*T2;
    G=Kps/(T2^2*s^2+T1*s+1);
    zae=G.num{1};
    nen=G.den{1};

    opts=simset('Solver','ode45',...
        'InitialState',[],...
        'MaxStep',.01);
    [t,x,y]=sim('s0311',[0 te],opts);


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
    hold on
end

