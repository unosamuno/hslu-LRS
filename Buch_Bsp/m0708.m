%  m0708.m     (Matlab/Simulink R2007b)
%
%  Bild 7.8 a und b
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  s0706_1.mdl, s0706_2.mdl, 
%                   s0706_3.mdl, s0706_4.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   T       Abtastperiode im Bereich  .1 < T < .4
%
%  Sprungantwort (Bild 7.8):
%   udach   Sprunghöhe im Bereich .1*pi < udach < .4*pi
%
%  Schwingungsantwort (entsprechend Bild 7.7b):
%   udach   Amplitude im Bereich .1*pi < udach < .4*pi
%   om0     Kreisfrequenz im Bereich 10.  < om0  < 40.
%
% ########################################################
clear

     T=.1;           % T=.1

     udach=.2*pi;    % udach=.2*pi

     om0=20;         % om0=20

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;


% Fliehkraftpendel-Strecke
% Analoges Modell:
rP=.01;       % Pendelabstand in m
l=.1 ;        % Pendellänge in m
m= .5;        % Masse eines Pendels in kg
cR=5e-2;      % Reibkonstante in Nm/(rad/s)
g=9.81;       % Erdbeschleunigung in m/s^2

c1=cR/(2*m*l^2);  c2=g/l;

% Arbeitspunkt:
phi0=45;       
phi0=(pi/180)*phi0;
omega0=sqrt( 2*g*sin(phi0)/(2*rP*cos(phi0)+l*sin(2*phi0)) );

% Lineares Modell:
a0=omega0^2*((rP/l)*sin(phi0)-cos(2*phi0)) + (g/l)*cos(phi0);
a1=cR/(m*l^2);
b0=omega0*((2*rP/l)*cos(phi0)+sin(2*phi0));

KPS=b0/a0;
wo=sqrt(a0);
d=a1/(2*sqrt(a0));     
s=tf('s');
Gs=KPS*wo^2/(s^2+2*d*wo*s+wo^2);
zae=Gs.num{1};
nen=Gs.den{1};



% Digitales Modell:
sig=-wo*d; we=wo*sqrt(1-d^2);
phi=-atan(d/sqrt(1-d^2));

b0=0;
b1=KPS*(1/sqrt(1-d^2)*(cos(phi) + exp(sig*T)*cos(phi-we*T)) ...
    - 2*exp(sig*T)*cos(we*T));
b2=KPS*(exp(sig*T)*(exp(sig*T)- 1/sqrt(1-d^2) * cos(phi-we*T)));
a1=-2*exp(sig*T)*cos(we*T);
a2=exp(2*sig*T);
z=tf('z',T);
Gsz=(b0*z^2+b1*z+b2)/(z^2+a1*z+a2)
zaed=Gsz.num{1};
nend=Gsz.den{1};



figure(1)
set(gcf,'Units','normal','Position',[.53 .6 .45 .35], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 7.8'); 
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.4,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes 

te=2; 

opts=simset('Solver','ode45',...
    'InitialState',[0 0],...
    'MaxStep',0.05);

[t1,x1,y1]=sim('s0706_1',[0 te],opts);

opts=simset('Solver','FixedStepDiscrete',...
    'InitialState',[0 0],...
    'FixedStep',T);

[t2,x2,y2]=sim('s0706_2',[0 te],opts);

subplot(2,1,1)
y1(:,1)=y1(:,1)/pi;
plot(t1,y1(:,1),'g')
grid on, hold on
set(gca,'FontSize',fonts,...
    'XTick',[0:.4:te],...
    'YTick',[-.2:.2:.4])
axis([0 te -.1 .5]); 
y2(:,1)=y2(:,1)/pi;
plot(t2,y2(:,1),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
title('Grün: Analoges Modell, Blau: Digitales Modell')
ylabel('y/\pi')

subplot(2,1,2)
y1(:,2)=(180/pi)*y1(:,2);
y2(:,2)=(180/pi)*y2(:,2);
plot(t1,y1(:,2),'g'), grid on, hold on
set(gca,'FontSize',fonts,...
    'XTick',[0:.4:te],'YTick',[0:4:10]);
axis([0 te -1 10]); 
plot(t2,y2(:,2),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
ylabel('x')


figure(2)
set(gcf,'Units','normal','Position',[.53 .1 .45 .35], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Zu Bild 7.8: Schwingungsanregung'); 
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.4,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes  

opts=simset('Solver','ode45',...
    'InitialState',[0 0],...
    'MaxStep',0.005);

[t1,x1,y1]=sim('s0706_3',[0 te],opts);

opts=simset('Solver','FixedStepDiscrete',...
    'InitialState',[0 0],...
    'FixedStep',T);

[t2,x2,y2]=sim('s0706_4',[0 te],opts);

subplot(2,1,1)
y1(:,1)=y1(:,1)/pi;
plot(t1,y1(:,1),'g'),grid on, hold on
set(gca,'FontSize',fonts,...
    'XTick',[0:.4:te],'YTick',[-.4:.2:.4])
axis([0 te -.5 .5]); 
y2(:,1)=y2(:,1)/pi;
plot(t2,y2(:,1),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
title('Grün: Analoges Modell, Blau: Digitales Modell')
ylabel('y/\pi')

subplot(2,1,2)
y1(:,2)=(180/pi)*y1(:,2);
y2(:,2)=(180/pi)*y2(:,2);
plot(t1,y1(:,2),'g'), grid on, hold on
set(gca,'FontSize',fonts,...
    'XTick',[0:.4:te],'YTick',[-12:4:12])
axis([0 te -10 10]); 
plot(t2,y2(:,2),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
ylabel('x')
