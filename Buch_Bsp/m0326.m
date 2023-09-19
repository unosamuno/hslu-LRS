%  m0326.m     (Matlab/Simulink R2007b)
%
%  Bild 3.26 
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0326.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%
%    Totzeit       Tt  im Bereich 0   < Tt  < 12.
%    Ordnung der Pade-Approximation 
%                  ord im Bereich  0  < ord 
%
%    P-Beiwert     Kps  im Bereich 0   < Kps  <  1.5 ,
%    Zeitkonstante T1  im Bereich 0.1 < T1  <  5.
%
%
% ########################################################
clear


     Tt =4;       % Voreinstellung:  Tt =4
     ord=5;       % Voreinstellung:  ord=3

     Kps =1;      % Voreinstellung:  Kps =1
     T1 =1;       % Voreinstellung:  T1 =1

  
% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

% P-Tt, mit Pade
[Ttzae,Ttnen]=pade(Tt,ord);

% P-T1-Tt, exakt  (Sprung verschoben)
s=tf('s');
G=1/(T1*s+1);
PT1zae=G.num{1};
PT1nen=G.den{1};


% Integrationsschleife:
te=16;

figure(1)
set(gcf,'Units','normal','Position',[.65 .6 .3 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 3.26a  rot: Tt-Glied, blau: Pade');

set(gca,'FontSize',fonts,...
    'XLim',[-.5 te],...
    'XTick',[0:2:20],...
    'XGrid','off',...
    'YLim',[-.5 1.5],...
    'YTick',[-.5:.5:1.5],...
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


figure(2)
set(gcf,'Units','normal','Position',[.65 .25 .3 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 3.26b rot: PT1Tt-Glied, blau: Pade');

set(gca,'FontSize',fonts,...
    'XLim',[-.5 te],...
    'XTick',[0:2:20],...
    'XGrid','off',...
    'YLim',[-.5 1.5],...
    'YTick',[-.5:.5:1.5],...
    'YGrid','off',...
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
[t,x,y]=sim('s0326',[0 te],opts);


figure(1)
plot(t,y(:,1),'r-','linewidth',1.5)   
plot(t,y(:,2),'b-','linewidth',1.5) 

figure(2)
plot(t,y(:,3),'r-','linewidth',1.5)   
plot(t,y(:,4),'b-','linewidth',1.5)   

