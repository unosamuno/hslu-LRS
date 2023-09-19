%  m0314.m     (Matlab/Simulink R2007b)
%
%  zu Bild 3.14:
%  PTn und PT1Tt-Glied mittels Wendetangentenverfahren
%
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0314.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   nsp       Zur Simulation einer "gemessenen" Sprungantwort:
%             Anzahl Speicher in der Leitung, 1 < nsp < 7
%              (bei nsp<6 ydach kleiner wählen, damit 
%               Sprungantwort im Diagramm sichtbar bleibt.)
%
%   schalt    Umschalter für die grafische Ausgabe:
%              schalt=0        nur "gemessene" Sprungantwort (S)
%              schalt=1        (S) mit P-Tn-Modell
%              schalt=2        (S) mit P-T1-Tt-Modell
%              schalt=3        (S) mit beiden Modellen
%    
%   ydach     Sprunghöhe der Stellgröße, 0 < ydach < 1.4
%
%   Aus "gemessener" Sprungantwort (schalt=0) ablesen:
%   (Ausdrucken mit "File" und "Print" im Grafik-Fenster)
%   Kps       Proportionalbeiwert der Strecke
%   Tu        Verzugszeit
%   Tg        Ausgleichszeit
%   
%   P-Tn-Modell (rot): aus Tabelle Bild 3.14 ermitteln:
%   n         Modellordnung
%   T1        Zeitkonstante
%   Ttu       Totzeit, bei evtl. Tu-Aufspaltung gemäß Bsp. 3.3
%
%   P-T1-Tt-Modell (blau):  
%   T1=Tg
%   Tt=Tu
%
% ########################################################
clear
    nsp=6;            % nsp=6  

    schalt=3;         % schalt=3
    
    ydach=1;          % ydach=1
    
    Kps=.143;         % Kps=.143
    Tu=2;             % Tu=1
    Tg=8.56;           % Tg=1

    n=3;              % n=3
    T1=2.33;          % T1=2.33
    Ttu=.13;          % Ttu=0.13
    
% ########################################################

close all
fonts=8;


% Modelldaten
% P-Tn  (Kps, n, T1, evtl. Tt, falls Tu-Aufspaltung)
s=tf('s');
G=Kps/(T1*s+1)^n;
zae=G.num{1};
nen=G.den{1};

% P-T1-Tt
T1=Tg;
Tt=Tu+Ttu;

% Gegebene nichtschwingende Strecke mit Ausgleich
R=1;
b=1;
V=1;
T1m=b*V*R/2;


% Integrationsschleife:
te=40;

figure(1)
set(gcf,'Units','normal','Position',[.65 .3 .3 .5], ...
    'NumberTitle','off','MenuBar','fig',...
    'Name',' zu Bild 3.14: Wendetangentenverfahren');

sp21=subplot(2,1,1);
set(gca,'FontSize',fonts,...
    'XLim',[-2 te],...
    'XTick',[0:5:100],...
    'YLim',[0 1.4],...
    'YTick',[-2:.2:2],...
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
    'YLim',[0 .16],...
    'YTick',[0:.02:10],...
    'NextPlot','add',...
    'Box','on');
tachs1=[-.5 te]; tachs2=[0 0];
yachs1=[0 0]; yachs2=[-2 2];
plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
tGGx=[-5 0]; tGGy=[0 0];
plot(tGGx,tGGy,'k','linewidth',1.5)
grid on
title('Schwarz:"Gemessen", rot: P-Tn-Modell, blau: P-T1-Tt')
xlabel('t  \rightarrow')
ylabel('x  \rightarrow')


opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);
[t,x,y]=sim('s0314',[0 te],opts);


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
out=nsp+1;
if schalt==0
    plot(t,y(:,out),'k-','linewidth',1)
end

if schalt==1
    plot(t,y(:,out),'k-','linewidth',1)
    hold on
    plot(t,y(:,8),'r-','linewidth',1)
end

if schalt==2
    plot(t,y(:,out),'k-','linewidth',1)
    hold on
    plot(t,y(:,9),'b-','linewidth',1)
end


if schalt==3
    plot(t,y(:,out),'k-','linewidth',1)
    hold on
    plot(t,y(:,8),'r-','linewidth',1)
    plot(t,y(:,9),'b-','linewidth',1)
end
