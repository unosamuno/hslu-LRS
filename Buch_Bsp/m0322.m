%  m0322.m     (Matlab/Simulink R2007b)
%
%  Bild 3.22 
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0322.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   schalt    Umschalter für die grafische Ausgabe:
%              schalt=0        nur "gemessene" Sprungantwort (S)
%              schalt=1        (S) mit I-Tn-Modell
%              schalt=2        (S) mit I-T1-Tt-Modell
%              schalt=3        (S) mit beiden Modellen
%    
%   ydach     Sprunghöhe der Stellgröße, 0<ydach<1.5
%
%   Aus "gemessener" Sprungantwort (schalt=0) ablesen:
%   (Kann mit "File" und "Print" im Grafik-Fenster ausgedruckt werden)
%   Kis       Proportionalbeiwert der Strecke
%   Tu        Verzugszeit
%   xu        x an der Stelle Tu
%
%   I-Tn-Modell (rot):
%   n         Modellordnung (aus Bild 3.24a ermitteln)
%   T1        Zeitkonstante (aus Bild 3.24b ermitteln)
%
%   I-T1-Tt-Modell (blau)
%   Tt        Totzeit, 0 < Tt < Tu
%
% ########################################################
clear
    schalt=3;        % schalt=3
    
    ydach=1.;        % ydach=1
    
    Kis=.6;          % Kis=1   (aus schalt=0 abgelesene Werte)  
    Tu=1.8;          % Tu=1.8
    
    n=4;             % n=4
    T1=.45;          % T1=.45
    
    Tt=.8;            % Tt=.8
     
% ########################################################

close all
fonts=8;

s=tf('s');


% Modelldaten
% I-Tn  (Kis, n, T1)
G=Kis/s/(T1*s+1)^n;
ITnzae=G.num{1};
ITnnen=G.den{1};

% I-T1-Tt
T1=Tu-Tt;        

% "Gemessene" Sprungantwort
%  einer nichtschwingenden Strecke ohne Ausgleich
 Ta=.1;           % Ta=.1
 Tb=.2;           % Tb=.2
 Tc=.6;           % Tc=.6
G=Kis/s/(Ta*s+1)^2/(Tb*s+1)^2/(Tc*s+1)^2;
zae=G.num{1};
nen=G.den{1};

% Integrationsschleife:
te=8;

figure(1)
set(gcf,'Units','normal','Position',[.65 .3 .3 .5], ...
    'NumberTitle','off','MenuBar','fig',...
    'Name',' Bild 3.22 Strecke o. Ausgl. mit Verzög.');

sp21=subplot(2,1,1);
set(gca,'FontSize',fonts,...
    'XLim',[-.5 te],...
    'XTick',[0:1:20],...
    'XGrid','off',...
    'YLim',[0 1.5],...
    'YTick',[0:.2:2],...
    'YGrid','off',...
    'NextPlot','add',...
    'Box','on');
tachs1=[0 te]; tachs2=[0 0];
yachs1=[0 0]; yachs2=[-2 2];
plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
tGGx=[-1 0]; tGGy=[0 0];
plot(tGGx,tGGy,'k','linewidth',1.5)
xlabel('t  \rightarrow')
ylabel('y  \rightarrow')


sp22=subplot(2,1,2);
set(gca,'FontSize',fonts,...
    'XLim',[-.5 te],...
    'XTick',[0:.5:20],...
    'XGrid','on',...
    'YLim',[0 3],...
    'YTick',[0:.2:3],...
    'YGrid','on',...
    'NextPlot','add',...
    'Box','on');
tachs1=[-.5 te]; tachs2=[0 0];
yachs1=[0 0]; yachs2=[-2 20];
plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
tGGx=[-1 0]; tGGy=[0 0];
plot(tGGx,tGGy,'k','linewidth',1.5)
xlabel('t  \rightarrow')
ylabel('x  \rightarrow')


opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.1);
[t,x,y]=sim('s0322',[0 te],opts);


figure(1)
axes(sp21)
ysprungx=[0 0];
if ydach>0
    ysprungy=[0 ydach];
else
    ysprungy=[ydach 0];
end
plot(ysprungx,ysprungy,'k','linewidth',1.5)
plot(t,y(:,1),'k-','linewidth',1.5)    %  y


axes(sp22)
if schalt==0
plot(t,y(:,2),'k-','linewidth',1)    %  x
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
