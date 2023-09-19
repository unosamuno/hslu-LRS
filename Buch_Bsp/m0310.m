%  m0310.m     (Matlab/Simulink R2007b)
%
%  Bild 3.10 
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0310.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%  uAdach   Sprunghöhe Ankerspannung in V
%           im Bereich  0 < uAdach < 45 
%
%  MLdach   Sprunghöhe Lastmoment in Nm
%           im Bereich  0 < MLdach < 450 
%
% ########################################################
clear

   uAdach=40;     % uAdach=20;
   
   MLdach=300;    % MLdach=300


% ########################################################

menu='none';  % none oder fig
close all
fonts=8;


% Streckendaten:
c2=200;   %  magn.Fluß*Stromstärke-->Moment (Nm/(Wb*A))
c3=.2;    %  magn.Fluß*Drehzahl-->EMK-Spannung (V/(Wb*rad/s))
J=200;    %  Trägheitsmoment von Anker und Last (Nm/(rad/s^2))
Phi=1;    %  magn. Fluß  (Wb=Vs)
Ra=1;     %  ohmscher Widerstand im Ankerkreis (Ohm)
%La=1;    %  Induktivität im Ankerkreis (Ohm*s)

T1=J*Ra/(c2*c3*Phi^2);
Kp=1/(c3*Phi);
Kpz=-Ra/(c2*c3*Phi^2);

% Signaldaten
% AP:
ML0=0;                   % in Nm    (mittleres Lastmoment)
wS=0;                    % in rad/s  (Solldrehzahl)
uA0=1/Kp*(wS-Kpz*ML0);   % in V  (zugehörige Ankerspannung)


% Integrationsschleife:
te=25;

figure(1)
set(gcf,'Units','normal','Position',[.45 .1 .5 .75], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 3.10  Gleichstrommotor');


sp311=subplot(3,1,1);
set(gca,'FontSize',fonts,...
    'XLim',[0 te],...
    'XTick',[0:10:60],...
    'YLim',[-0 50],...
    'YTick',[-10:10:50],...
    'NextPlot','add',...
    'Box','on');
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
grid off
xlabel('t \rightarrow')
ylabel('u_A (V)  \rightarrow')


sp312=subplot(3,1,2);
set(gca,'FontSize',fonts,...
    'XLim',[0 te],...
    'XTick',[0:10:60],...
    'YLim',[0 210],...
    'YTick',[-150:30:210],...
    'NextPlot','add','Box','on');
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
grid off
xlabel('t \rightarrow')
ylabel('\omega (rad/s)   \rightarrow')

sp313=subplot(3,1,3);
set(gca,'FontSize',fonts,...
    'XLim',[0 te],...
    'XTick',[0:10:60],...
    'YLim',[-0 500],...
    'YTick',[-100:100:500],...
    'NextPlot','add','Box','on');
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
grid off
xlabel('t \rightarrow')
ylabel('M_L (Nm)   \rightarrow')


opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.1);
[t,x,y]=sim('s0310',[0 te],opts);

axes(sp311)
plot(t,y(:,2),'k-','linewidth',1.5)

axes(sp312)
plot(t,y(:,1),'k-','linewidth',1.5)    %  omega

axes(sp313)
plot(t,y(:,3),'k-','linewidth',1.5)

