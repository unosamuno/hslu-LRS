%  m0906.m     (Matlab/Simulink R2007b)
%
%  Bild 9.6 b, c und d
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0906_1.mdl, s0906_2.mdl, s0906_3.mdl 
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   wdach   Sollsprunghöhe Spiegelwinkel (in Grad)
%           im Bereich  1.  < wdach  <  6.
%
%   Regler:
%   T       Abtastintervall (in ms)
%           im Bereich  0.05 < T < 1.
%   Kpr     P-Beiwert im Bereich  3.  <  Kpr  <  30.
%   TD      Parameter im Bereich  0.05  <  TD   <    0.3
%
% ########################################################
clear

  wdach = 5.;      % wdach=5.

  T = .1;          % T=0.1
  Kpr =10.;        % Kpr=10.
  TD  =.1;         % TD = 0.1

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

% Lead-Regler: Gr=Kpr*(TD*s+1)/(T1*s+1), TD>T1
T1=.01*TD;
tt0=1e-3;             % Umrechnungsfaktor
TD=TD/tt0;            % s --> ms
T1=T1/tt0;            % s --> ms
s=tf('s');
Gr=Kpr*(TD*s+1)/(T1*s+1);
rzae=Gr.num{1};
rnen=Gr.den{1};
% Digitale Reglerrealisierung (Trapezregel):
b0=Kpr*(T+2*TD)/(T+2*T1);
b1=Kpr*(T-2*TD)/(T+2*T1);
a0=1;
a1=(T-2*T1)/(T+2*T1);
z=tf('z',T);
Grd=(b0*z+b1)/(a0*z+a1)
rzaed=Grd.num{1};
rnend=Grd.den{1};


% Analoges Streckenmodell Gs:
J=.001;        % Nms^2, Trägheitsmoment
cR=0.01;       % Nms, Reibung
KIS=1/cR; T1=J/cR;    
KIS=KIS*tt0;    % s --> ms
T1=T1/tt0;      % s --> ms
s=tf('s');
Gs=KIS/s/(T1*s+1);
szae=Gs.num{1};
snen=Gs.den{1};
% Diskretisierung Strecke:
alf=exp(-T/T1);
b0S=0;         
b1S=-KIS*((1-alf)*T1 -     T);
b2S= KIS*((1-alf)*T1 - alf*T);
a1S=-(1+alf);
a2S=alf;
Gsd=(b0S*z^2+b1S*z+b2S)/(z^2+a1S*z+a2S)
szaed=Gsd.num{1};
snend=Gsd.den{1};



figure(1)   % Führungssprungantwort analog u. digital
set(gcf,'Units','normal','Position',[.47 .65 .51 .27], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 9.6b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

% Analoge Regelung:
wdachrad=wdach*pi/180;
te=10;  

opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',te/100);
[t,x,y]=sim('s0906_1',[0 te],opts);

y(:,1)=y(:,1)*180/pi;
y(:,2)=y(:,2)*180/pi;
t0=-1.;  
tachs1=[t0 te]; tachs2=[0 0];
yachs1=[0 0]; yachs2=[-1 8];
plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
grid on, hold on
set(gca,'Position',[.15 .2 .75 .7],...
    'FontSize',fonts,...
    'xtick',[-1:10],...
    'ytick',[0:2:10]);
xlabel('t (ms)'); ylabel('w, \phi (Grad)')
title(['Regelung analog: hellblau;  digital: dunkelblau (T=',...
        num2str(T),'ms)'])
axis([t0 te -.5 8.]); 
plot(t,y(:,1),'r-',t,y(:,2),'c-')

% Digitale Regelung:
% 1.) w und x auch zwischen kT:
opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',T/10);
[t,x,y]=sim('s0906_2',[0 te],opts);
y(:,2)=y(:,2)*180/pi;
plot(t,y(:,2),'b')

% 2.) w und x nur für kT:
opts=simset('Solver','FixedStepDiscrete',...
    'InitialState',[],...
    'FixedStep',T);
[t,x,yk]=sim('s0906_3',[0 te],opts);

yk(:,2)=yk(:,2)*180/pi;
plot(t,yk(:,2),'bx','markersize',5,'LineW',1)
% Funktionswerte für k<0 Null setzen:
km=floor(abs(t0)/T); % Anzahl Abtastpunkte vor t=0
tkm=[-km:-1]*T; fkm=zeros(size(tkm));
plot(tkm,fkm,'bx','markersize',5,'LineW',1)


open_system('s0906_2')    % Simulink-Fenster öffnen


figure(2)
set(gcf,'Units','normal','Position',[.47 .05 .51 .27], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 9.6d');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

% Analoge Regelung:
opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',te/100);
[t,x,y]=sim('s0906_1',[0 te],opts);

tachs1=[t0 te]; tachs2=[0 0];
yachs1=[0 0]; yachs2=[-5 10];
plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
grid on, hold on
set(gca,'Position',[.15 .2 .75 .7],...
    'FontSize',fonts,...
    'xtick',[-1:10],'ytick',[-5:5:10]);
xlabel('t (ms)'); ylabel('u_m (V)')
title('Regelung analog: hellblau;  digital: dunkelblau')
axis([t0 te -5 10]); 
y(:,3)=y(:,3)*.1;     % Nm -> V
plot(t,y(:,3),'c-')

% Digitale Regelung:
% 1.) y auch zwischen kT:
opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',T/10);
[t,x,y]=sim('s0906_2',[0 te],opts);

y(:,3)=y(:,3)*.1;     % Nm -> V
plot(t,y(:,3),'b')

% 2.) y nur für kT:
opts=simset('Solver','FixedStepDiscrete',...
    'InitialState',[],...
    'FixedStep',T);
[t,x,yk]=sim('s0906_3',[0 te],opts);

yk(:,3)=yk(:,3)*.1;     % Nm -> V
plot(t,yk(:,3),'bx','markersize',5,'linewidth',1)
% Funktionswerte für k<0 Null setzen:
plot(tkm,fkm,'bx','markersize',5,'LineW',1)

