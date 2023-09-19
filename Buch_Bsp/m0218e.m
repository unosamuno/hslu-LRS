%  m0218e.m     (Matlab/Simulink R2007b)
%
%  Bild 2.18d und e
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0218d.mdl
%
%  (c) 5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%    phi0        Pendelausschlag im Arbeitspunkt in Grad
%                im Bereich  45 < phi0 < 60
%
%    DomdachVec   -30 < DomdachVec(i) < 30  (rad/s)
%                Vektor mit konstanten Abweichungen om-om0 
%                der Drehzahl om vom Arbeitspunktwert
%                om0, für die die Abweichung phi-phi0 der 
%                Pendelauslenkung vom Arbeitspunkt der Reihe 
%                nach simuliert wird.
%
% ########################################################
clear all

  phi0=45;      % Voreinstellung  phi0=45
  
  DomdachVec=[-1.5 :.5: 1.5 ];  % DomdachVec=[-15 :5: 15 ]          

% ########################################################
clc
close all
fonts=9;

% Streckendaten:
rP=1;         % cm
l=10;         % Pendellänge in cm
m=.5;         % Masse eines Pendels in kg
cR=0.05;      % Reibkonstante in Nm/(rad/s)
g=9.81;       % Erdbeschleunigung in m/s^2

% Umrechnung auf SI-Einheiten
rP=rP*1e-2;
l=l*1e-2;

c1=cR/(m*l^2);  c2=g/l;

phi0=(pi/180)*phi0;   % Umrechnung Grad in rad   
omega0=sqrt( (2*g*sin(phi0))./(2*rP*cos(phi0)+l*sin(2*(phi0))) );

% Daten des linearen Modelles:
a0=omega0^2*((rP/l)*sin(phi0)-cos(2*phi0)) + (g/l)*cos(phi0);
a1=cR/(m*l^2);
b0=omega0*((2*rP/l)*cos(phi0)+sin(2*phi0));

tsprung=.5;   % Zeitpunkt der Sprunganregung
te=3;


figure(1)
set(gcf,'Units','normal','Position',[.45 .45 .5 .3], ...
    'NumberTitle','off','MenuBar','none',...
    'Name',' Bild 2.18e');
ha=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes(ha)

sp1=subplot(1,2,1);
set(gca,'FontSize',fonts,...
    'Position',[.16 .2 .3 .7],...
     'XLim',[0 te],...
    'XTick',[0:1:te],...
    'YLim',[-2 2],...
    'YTick',[-10:1:10],...
    'NextPlot','add',...
    'Box','on');
grid on
xlabel('\itt \rm/ s \rightarrow')
ylabel('\it\Delta\omega   \rm/ (rad/s) \rightarrow')

sp2=subplot(1,2,2);
set(gca,'FontSize',fonts,...
    'Position',[.59 .2 .3 .7],...
    'XLim',[0 te],...
    'XTick',[0:1:te],...
    'YLim',[-20 20],...
    'YTick',[-30:5:30],...
    'NextPlot','add',...
    'Box','on');
grid on 
xlabel('\itt \rm/ s \rightarrow')
ylabel('\it\Delta\phi  \rm/ Grad \rightarrow')


Anzahl=size(DomdachVec,2);
for i=1:Anzahl    % Sprungantwort für versch, Sprunghöhen
    
    Domdach=DomdachVec(i);
       
    opts=simset('Solver','ode45',...
        'InitialState',[],...
        'MaxStep',0.04);
    [t,x,y]=sim('s0218d',[0 te],opts);
    
    axes(sp1)     
    plot(t,y(:,1),'k','linewidth',1.5)
    
    axes(sp2)     
    y(:,2)=(180/pi)*y(:,2);  % rad in Grad
    y(:,3)=(180/pi)*y(:,3);  % rad in Grad
    plot(t,y(:,2),'k--',t,y(:,3),'k','linewidth',1.5)
    
        
end






