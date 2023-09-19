%  m0709.m     (Matlab/Simulink R2007b)
%
%  Bild 7.9
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
%  Sprungantwort (Bild 7.9):
%   udach   Sprunghöhe im Bereich .5 < udach < 1.
%
%  Schwingungsantwort (entsprechend Bild 7.6b):
%   udach   Amplitude im Bereich .5  < udach < 1.
%   om0     Kreisfrequenz im Bereich 300. < om0  < 800.
%
% ########################################################
clear

     T=0.02;         %  T=.02

     udach=1;        %  udach=1

     om0=300;        %  om0=500

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;


% Gleichstrommotor:

% Analoges Streckenmodell:
J=.001;     % Nm/(rad/s^2)=Nms^2, Trägheitsmom.
cR=0.01;    % Nm/(rad/s)=Nms, Reibung
KIS=1/cR; T1=J/cR;    
s=tf('s');
Gs=KIS/s/(T1*s+1);
zae=Gs.num{1};
nen=Gs.den{1};


% Digitales Streckenmodell:  
alf=exp(-T/T1);
b0=0;
b1=KIS*(-(1-alf)*T1 + T);
b2=KIS*((1-alf)*T1 - alf*T);
a1=-(1+alf);
a2=alf;
z=tf('z',T);
Gsz=(b0*z^2+b1*z+b2)/(z^2+a1*z+a2)
zaed=Gsz.num{1};
nend=Gsz.den{1};


figure(1)
set(gcf,'Units','normal','Position',[.53 .6 .45 .35], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 7.9'); 
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.4,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes   

te=.4; 

opts=simset('Solver','ode45',...
    'InitialState',[0 0],...
    'MaxStep',0.01);
[t1,x1,y1]=sim('s0706_1',[0 te],opts);

opts=simset('Solver','FixedStepDiscrete',...
    'InitialState',[0 0],...
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
plot(t1,y1(:,2),'g'), grid on, hold on
set(gca,'FontSize',fonts);
axis([0 te -5 30]); 
plot(t2,y2(:,2),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
ylabel('x')


figure(2)
set(gcf,'Units','normal','Position',[.53 .1 .45 .35], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Zu Bild 7.9: Schwingungsanregung'); 
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.4,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes   

opts=simset('Solver','ode45',...
    'InitialState',[0 0],...
    'MaxStep',0.001);
[t1,x1,y1]=sim('s0706_3',[0 te],opts);

opts=simset('Solver','FixedStepDiscrete',...
    'InitialState',[0 0],...
    'FixedStep',T);
[t2,x2,y2]=sim('s0706_4',[0 te],opts);

subplot(2,1,1)
plot(t1,y1(:,1),'g'),grid on, hold on
set(gca,'FontSize',fonts);
axis([0 te -1.2 1.2]); 
plot(t2,y2(:,1),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
title('Grün: Analoges Modell, Blau: Digitales Modell')
ylabel('y')

subplot(2,1,2)
plot(t1,y1(:,2),'g'), grid on, hold on
set(gca,'FontSize',fonts);
axis([0 te -5 30]); 
plot(t2,y2(:,2),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
ylabel('x')

