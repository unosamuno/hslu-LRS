%  m0706.m     (Matlab/Simulink R2007b)
%
%  Bild 7.6 a und b
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
%   T       Abtastperiode im Bereich 10 < T < 30.
%
%  Sprungantwort (Bild 7.6a):
%   udach   Sprunghöhe im Bereich .5 < udach < 1.
%
%  Schwingungsantwort (Bild 7.6b):
%   udach   Amplitude im Bereich .5 < udach < 1.
%   om0     Kreisfrequenz im Bereich .0005 < om0 < 0.01.
%
% ########################################################
clear

     T=20;           %  T=20

     udach=1;        %  udach=1

     om0=.0005;      %  om0=0.0005

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

% Füllstandstrecke:

% Analoges Streckenmodell:
A=30*1e-4;   % A=30cm^2    - Tankquerschnitt in m^2
rho=1e3;     % rho=1g/cm^3 - Flüss.dichte in kg/m^3
cP=2e-3;     % cP=2(g/s)/V - Motorkonstante in (kg/s)/V
g=9.81;      % Erdbeschleunigung in m/s^2

c1=sqrt(2*g)/A;  c2=cP/(rho*A);

% Arbeitspunkt:
hs=10;                % cm
Aab0=6;               % mm^2
hs=1e-2*hs;           % cm --> m
Aab0=1e-6*Aab0;       % mm^2 --> m^2
up0=(c1/c2)*Aab0*sqrt(hs);

k=1/(2*sqrt(hs));
a0=c1*Aab0*k;
b01=c2;
KPS=b01/a0; T1=1/a0;    
s=tf('s');
Gs=KPS/(T1*s+1);
zae=Gs.num{1};
nen=Gs.den{1};

% Digitales Streckenmodell:
a=exp(-T/T1);   
b1=KPS*(1-a);
a1=-a;
z=tf('z',T);
Gsz=b1/(z+a1)
zaed=Gsz.num{1};
nend=Gsz.den{1};


figure(1)
set(gcf,'Units','normal','Position',[.53 .6 .45 .35], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 7.6a'); 
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes  

te=300; 

opts=simset('Solver','ode45',...
    'InitialState',[0],...
    'MaxStep',1.);

[t1,x1,y1]=sim('s0706_1',[0 te],opts);

opts=simset('Solver','FixedStepDiscrete',...
    'InitialState',[0],...
    'FixedStep',T);

[t2,x2,y2]=sim('s0706_2',[0 te],opts);

subplot(2,1,1)
plot(t1,y1(:,1),'g'),grid on, hold on
set(gca,'FontSize',fonts);
axis([0 te -.5 1.5]); 
plot(t2,y2(:,1),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
title('Grün: Analoges Modell, Blau: Digitales Modell')
ylabel('y')

subplot(2,1,2)
y1(:,2)=1e2*y1(:,2);  % Umrechnung Dh in cm
y2(:,2)=1e2*y2(:,2);  % Umrechnung Dh in cm
plot(t1,y1(:,2),'g'), grid on, hold on
set(gca,'FontSize',fonts);
axis([0 te -1 6]); 
plot(t2,y2(:,2),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
ylabel('x')


figure(2)
set(gcf,'Units','normal','Position',[.53 .1 .45 .35], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 7.6b'); 
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes 

te=300; 

opts=simset('Solver','ode45',...
    'InitialState',[0],...
    'MaxStep',.1);

[t1,x1,y1]=sim('s0706_3',[0 te],opts);

opts=simset('Solver','FixedStepDiscrete',...
    'InitialState',[0],...
    'FixedStep',T);

[t2,x2,y2]=sim('s0706_4',[0 te],opts);

subplot(2,1,1)
plot(t1,y1(:,1),'g'),grid on, hold on
set(gca,'FontSize',fonts);
axis([0 te -.5 1.5]); 
plot(t2,y2(:,1),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
title('Grün: Analoges Modell, Blau: Digitales Modell')
ylabel('y')

subplot(2,1,2)
y1(:,2)=1e2*y1(:,2);  % Umrechnung Dh in cm
y2(:,2)=1e2*y2(:,2);  % Umrechnung Dh in cm
plot(t1,y1(:,2),'g'), grid on, hold on
set(gca,'FontSize',fonts);
axis([0 te -1 6]); 
plot(t2,y2(:,2),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
ylabel('x')

