%  m0905.m     (Matlab/Simulink R2007b)
%
%  Bild 9.5
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  s0905.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   Sollsprunghöhe Spiegelwinkel wdach (in Grad) 
%                      im Bereich  1.  <  wdach <  6.
%
%  Regler:
%   P-Beiwert    Kpr   im Bereich  3.    < Kpr  <  30.
%   Parameter    TD    im Bereich  0.05  < TD   <  0.3
%   Parameter    T1=0.01*TD  (fest)  
%
% ########################################################
clear

     wdach = 5.;      % wdachgrad=5.

     Kpr   =10.;      % Kpr=10.

     TD    =.1;       % TD = 0.1

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

% Scannermodell:
J=.001;        % Nm/(rad/s^2)=Nms^2, Trägheitsmom.
cR=0.01;       % Nm/(rad/s)=Nms, Reibung
KIS=1/cR; T1=J/cR;    
s=tf('s');
Gs=KIS/s/(T1*s+1);
szae=Gs.num{1};
snen=Gs.den{1};


% Lead-Regler: 
T1=.01*TD;
Gr=Kpr*(TD*s+1)/(T1*s+1);
rzae=Gr.num{1};
rnen=Gr.den{1};


% Führungssprungantwort:
wdachrad=wdach*pi/180;


figure(1)
set(gcf,'Units','normal','Position',[.53 .55 .45 .3], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 9.5');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

t0=-0.001; te=.01; 

opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',te/100);

[t,x,y]=sim('s0905',[0 te],opts);


t=t*1e3;    % s --> ms
t0ms=t0*1e3; tems=te*1e3;
y(:,1)=y(:,1)*180/pi;
y(:,2)=y(:,2)*180/pi;
tachs1=[t0ms tems]; tachs2=[0 0]; 
fachs1=[0 0]; fachs2=[-.5 8]; 
plot(tachs1,tachs2,'k',fachs1,fachs2,'k')
grid on, hold on
set(gca,'FontSize',fonts,...
    'xtick',[-1:10],...
    'ytick',[0:2:10]);
axis([t0ms tems -.5 8.] ); 
title(' Laserscanner-Regelung')
xlabel('t/ms'); ylabel('w, \phi (Grad)')
plot(t,y(:,1),'r',t,y(:,2),'b')

figure(2)
set(gcf,'Units','normal','Position',[.53 .15 .45 .3], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Zugehöriger Stellgrößenverlauf');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

fachs1=[0 0]; fachs2=[-5 10]; 
plot(tachs1,tachs2,'k',fachs1,fachs2,'k')
grid on, hold on
set(gca,'FontSize',fonts,...
    'xtick',[-1:10],'ytick',[-5:5:10]);
axis([ t0ms tems -5 10]); 
xlabel('t/ms'); ylabel('u_M (V)')
y(:,3)=y(:,3)*.1;     % Nm -> V
plot(t,y(:,3))




