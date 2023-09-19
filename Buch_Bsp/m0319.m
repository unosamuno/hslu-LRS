%  m0319.m     (Matlab/Simulink R2007b)
%
%  Bild 3.19 
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0319.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   schalt    Umschalter für die grafische Ausgabe:
%              schalt=0        nur "gemessene" Sprungantwort (S)
%              schalt=1        (S) mit P-T2-Modell 1
%              schalt=2        (S) mit P-T2-Modell 2
%              schalt=3        (S) mit P-T2-Modell 1 und 2
%    
%   ydach     Sprunghöhe der Stellgröße, 0 < ydach < 1.4
%
%   P-T2-Modellparameter aus "gemessener" Sprungantwort (schalt=0) 
%   ermitteln:  (Ausdrucken mit "File" und "Print" im Grafik-Fenster)
%
%     Kps       Proportionalbeiwert der Strecke
%     Delta1    Erster Überschwinger
%
%     und bei Verfahren mit Delta1 und Delta2:
%     Delta2    Erster Unterschwinger
%     Te        Schwingungsdauer
%
%     bzw. bei Verfahren mit Delta1 und t1:
%     t1        Zeitpunkt des ersten Überschwingers
%   
% ########################################################
clear
    
    schalt=3;         % schalt=3
    
    ydach=1;          % ydach=1
    
    Kps=1;            % Kps=1
    Delta1=0.36;      % Delta1=0.36
    
    Delta2=0.15;      % Delta2=0.15
    Te=10.7;          % Te=10.7
    
    t1=6;             % t1=6
        
% ########################################################

close all
fonts=8;


% Modelldaten
% P-T2  (Kps, T1, T2)

% Verfahren 1
theta=log(Delta1/Delta2);    % log ist ln
d=theta/sqrt(pi^2+theta^2);

% genauso:
% theta=log(Delta2/Delta1);  
% d=abs(theta)/sqrt(pi^2+theta^2)

ome=2*pi/Te;
om0=ome/sqrt(1-d^2);

T2=1/om0;
T1=2*d*T2;

s=tf('s');
G=Kps/(T2^2*s^2+T1*s+1);
PT2zae1=G.num{1};
PT2nen1=G.den{1};

% Verfahren 2
k1=Kps*ydach/Delta1;
d=log(k1)/sqrt(pi^2+log(k1)^2);
om0=pi/t1/sqrt(1-d^2);

T2=1/om0;
T1=2*d*T2;

G=Kps/(T2^2*s^2+T1*s+1);
PT2zae2=G.num{1};
PT2nen2=G.den{1};

% Gegebene schwingende Strecke mit Ausgleich
om0=.6;
d=.3;
T2=1/om0;
T1=2*d*T2;
G=1/(T2^2*s^2+T1*s+1)/(.1*s+1)^3;
%G=1/(T2^2*s^2+T1*s+1);
zae=G.num{1};
nen=G.den{1};

% Integrationsschleife:
te=40;

figure(1)
set(gcf,'Units','normal','Position',[.65 .3 .3 .5], ...
    'NumberTitle','off','MenuBar','fig',...
    'Name',' zu Bild 3.19  Schwingende Strecke');

sp21=subplot(2,1,1);
set(gca,'FontSize',fonts,...
    'XLim',[-2 te],...
    'XTick',[0:5:100],...
    'YLim',[0 1.4],...
    'YTick',[0:.2:1.4],...
    'NextPlot','add',...
    'Box','on');
tachs1=[0 te]; tachs2=[0 0];
yachs1=[0 0]; yachs2=[-2 2];
plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
tGGx=[-5 0]; tGGy=[0 0];
plot(tGGx,tGGy,'k','linewidth',1.5)
grid on
xlabel('t  \rightarrow')
ylabel('y  \rightarrow')

sp22=subplot(2,1,2);
set(gca,'FontSize',fonts,...
    'XLim',[-2 te],...
    'XTick',[0:5:100],...
    'YLim',[0 1.6],...
    'YTick',[0:.2:10],...
    'NextPlot','add',...
    'Box','on');
tachs1=[-.5 te]; tachs2=[0 0];
yachs1=[0 0]; yachs2=[-2 2];
plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
tGGx=[-5 0]; tGGy=[0 0];
plot(tGGx,tGGy,'k','linewidth',1.5)
grid on
title('Schwarz:"Gemessen", rot/blau: P-T2-Modelle')
xlabel('t  \rightarrow')
ylabel('x  \rightarrow')


opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);
[t,x,y]=sim('s0319',[0 te],opts);


axes(sp21)                %  y
ysprungx=[0 0];
if ydach>0
    ysprungy=[0 ydach];
else
    ysprungy=[ydach 0];
end

plot(ysprungx,ysprungy,'k','linewidth',1.5)
plot(t,y(:,1),'k-','linewidth',1.5)

axes(sp22)                  % x
if schalt==0
    plot(t,y(:,2),'k-','linewidth',1.5)
end

if schalt==1
    plot(t,y(:,2),'k-','linewidth',1)
    hold on
    plot(t,y(:,3),'r-','linewidth',1)
end

if schalt==2
    plot(t,y(:,2),'k-','linewidth',1)
    hold on
    plot(t,y(:,4),'b-','linewidth',1)
end


if schalt==3
    plot(t,y(:,2),'k-','linewidth',1)
    hold on
    plot(t,y(:,3),'r-','linewidth',1)
    plot(t,y(:,4),'b-','linewidth',1)
end
