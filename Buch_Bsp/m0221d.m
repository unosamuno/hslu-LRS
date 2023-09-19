%  m0221d.m     (Matlab/Simulink R2007b)
%
%  Bild 2.21c,d 
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0221c.mdl
%
%  (c) 5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%    DudachVec   -1.6 < DudachVec(i) < 1.6  (V)
%                Vektor mit konstanten Abweichungen uP-uP0 
%                der Pumpenspannung uP vom Arbeitspunktwert
%                uP0, für die die Abweichung h-hS des 
%                Füllstands vom Arbeitspunkt der Reihe 
%                nach simuliert wird.
% 
%    DAdachVec   -1.5 < DAdachVec(i) < 1.5  (mm^2)
%                Vektor mit konstanten Abweichungen Aab-Aab0 
%                der Abflußöffnung Aab vom Arbeitspunktwert
%                Aab0, für die die Abweichung h-hS des 
%                Füllstands vom Arbeitspunkt der Reihe 
%                nach simuliert wird.
% 
%   Probieren Sie auch kleinere Schritte z.B.
%      DudachVec=[-1.6:.2:1.6 ]
%
% ########################################################
clear

DudachVec=[-1.6 :.2: 1.6 ];  % DudachVec=[-1.5 -.5 .5 1.5 ]          

DAdachVec=[-1.6 :.2: 1.6 ];  % DAdachVec=[-1.5 -.5 .5 1.5 ]          



% ########################################################

close all
fonts=8;

% Streckendaten:
A=30*1e-4;   % m^2
rho=1e3;     % kg/m^3
cP=2e-3;     % (kg/s)/V
g=9.81;      % m/s^2
DAdachVec=DAdachVec*1e-6;  % mm^2 in m^2

c1=sqrt(2*g)/A;  c2=cP/(rho*A);

% Linearisiertes Modell:
hs=10;   % in cm
Aab0=6;  % in mm^2
hs=1e-2*hs;        % Umrechnung in m
Aab0=1e-6*Aab0;    % Umrechnung in m^2
up0=(c1/c2)*Aab0*sqrt(hs);

k=1/(2*sqrt(hs));
a0=c1*Aab0*k;
b01=c2;
b02=-c1*sqrt(hs);
T1=1/a0;
Kp=b01/a0*100;

% Integrationsschleife:
te=600;
Dudach=0;
DAdach=0;
assignin('base','DAdach',DAdach)

figure(1)
set(gcf,'Units','normal','Position',[.45 .1 .5 .75], ...
    'NumberTitle','off','MenuBar','none',...
    'Name',' Bild 2.21d  Füllstandsstrecke');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

sp221=subplot(2,2,1);
set(gca,'FontSize',fonts,...
    'XLim',[0 600],...
    'XTick',[0:100:600],...
    'YLim',[-2 2],...
    'YTick',[-2:2],...
    'NextPlot','add',...
'Box','on');
tachs1=[0 te]; tachs2=[0 0]; 
plot(tachs1,tachs2,'k')
grid off
xlabel('t \rightarrow')
ylabel('\Deltau_P \rightarrow')

sp222=subplot(2,2,2);
set(gca,'FontSize',fonts,...
    'XLim',[0 600],...
    'XTick',[0:100:600],...
    'YLim',[-10 10],...
    'YTick',[-12:4:12],...
    'NextPlot','add','Box','on');
tachs1=[0 te]; tachs2=[0 0]; 
plot(tachs1,tachs2,'k')
grid off
title('\DeltaA_{ab}=0')
xlabel('t \rightarrow')
ylabel('\Deltah \rightarrow')

Anzahl=size(DudachVec,2);
for i=1:Anzahl
    
    Dudach=DudachVec(i);
        
    opts=simset('Solver','ode45',...
        'InitialState',[hs 0],...
        'MaxStep',1.0);
    [t,x,y]=sim('s0221c',[0 te],opts);
    
    axes(sp221)
    plot(t,y(:,3),'k')
    
    axes(sp222)
    y(:,1)=1e2*y(:,1);        % Dh in cm
    y(:,2)=1e2*y(:,2);        % Dh in cm
    plot(t,y(:,1),'b--',t,y(:,2),'r')
    
end


Dudach=0;

sp223=subplot(2,2,3);
set(gca,'FontSize',fonts,...
    'XLim',[0 600],...
    'XTick',[0:100:600],... 
    'YLim',[-2 2],...
    'YTick',[-2:2],...
    'NextPlot','add','Box','on');
tachs1=[0 te]; tachs2=[0 0]; plot(tachs1,tachs2,'k')
grid off
xlabel('t \rightarrow')
ylabel('\DeltaA_{ab} \rightarrow')

sp224=subplot(2,2,4);
set(gca,'FontSize',fonts,...
    'XLim',[0 600],...
    'XTick',[0:100:600],...
    'YLim',[-10 10],...
    'YTick',[-12:4:12],...
    'NextPlot','add','Box','on');
tachs1=[0 te]; tachs2=[0 0]; plot(tachs1,tachs2,'k')
grid off, hold on
title('\Deltau_P=0');
xlabel('t \rightarrow')
ylabel('\Deltah \rightarrow')

Anzahl=size(DAdachVec,2);
for i=1:Anzahl
    
    DAdach=DAdachVec(i);
        
    opts=simset('Solver','ode45',...
        'InitialState',[hs 0],...
        'MaxStep',1.0);
    [t,x,y]=sim('s0221c',[0 te],opts);
    
    axes(sp223)
    y(:,4)=1e6*y(:,4);      % DAab in mm^2
    plot(t,y(:,4),'k')
    
    axes(sp224)
    y(:,1)=1e2*y(:,1);          % Dh in cm
    y(:,2)=1e2*y(:,2);          % Dh in cm
    plot(t,y(:,1),'b--',t,y(:,2),'r')
    
end







