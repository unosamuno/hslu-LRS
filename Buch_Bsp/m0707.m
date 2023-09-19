%  m0707.m     (Matlab/Simulink R2007b)
%
%  Bild 7.7 a und b
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
%    T      Abtastperiode im Bereich 10. < T < 100.
%
%  Sprungantwort (Bild 7.7a):
%    udach  Sprunghöhe im Bereich  5. < udach < 10.
%
%  Schwingungsantwort (Bild 7.7b):
%    udach  Amplitude im Bereich  5. < udach < 10.
%    om0    Kreisfrequenz im Bereich .0001 < om0 < 0.001.
%
% ########################################################
clear

     T=40;           %  T=40

     udach=10;       %  udach=10

     om0=.0001;      %  om0=0.0001

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;


% Temperaturstrecke

% Analoges Modell:
KPS=.2; wo=.03; d=2;     
s=tf('s');
Gs=KPS*wo^2/(s^2+2*d*wo*s+wo^2);
zae=Gs.num{1};
nen=Gs.den{1};

% Digitales Modell:
dstr=sqrt(d^2-1); 
s1=-wo*(d+dstr); s2=-wo*(d-dstr);
alf1=exp(s1*T); alf2=exp(s2*T);
% A1=(d-dstr)/(2*dstr);
% A2=-(d+dstr)/(2*dstr);
% A3=1;

b0=0;    
b1=KPS*(1+1/(2*dstr)*((d-dstr)*alf1-(d+dstr)*alf2));
b2=KPS*(alf1*alf2+1/(2*dstr)*((d-dstr)*alf2-(d+dstr)*alf1));
a1=-(alf1+alf2);
a2=alf1*alf2;
z=tf('z',T);
Gsz=(b0*z^2+b1*z+b2)/(z^2+a1*z+a2)
zaed=Gsz.num{1};
nend=Gsz.den{1};



figure(1)
set(gcf,'Units','normal','Position',[.53 .6 .45 .35], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 7.7a'); 
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes   

te=520; 

opts=simset('Solver','ode45',...
    'InitialState',[0 0],...
    'MaxStep',10.);
[t1,x1,y1]=sim('s0706_1',[0 te],opts);

opts=simset('Solver','FixedStepDiscrete',...
    'InitialState',[0 0],...
    'FixedStep',T);
[t2,x2,y2]=sim('s0706_2',[0 te],opts);

subplot(2,1,1)
plot(t1,y1(:,1),'g'),grid on, hold on
set(gca,'FontSize',fonts);
axis([0 te -2 15]); 
plot(t2,y2(:,1),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
title('Grün: Analoges Modell, Blau: Digitales Modell')
ylabel('y')

subplot(2,1,2)
plot(t1,y1(:,2),'g'), grid on, hold on
set(gca,'FontSize',fonts);
axis([0 te -.5 2.5]); 
plot(t2,y2(:,2),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
ylabel('x')


figure(2)
set(gcf,'Units','normal','Position',[.53 .1 .45 .35], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 7.7b'); 
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes  

opts=simset('Solver','ode45',...
    'InitialState',[0 0],...
    'MaxStep',1.);
[t1,x1,y1]=sim('s0706_3',[0 te],opts);

opts=simset('Solver','FixedStepDiscrete',...
    'InitialState',[0 0],...
    'FixedStep',T);
[t2,x2,y2]=sim('s0706_4',[0 te],opts);

subplot(2,1,1)
plot(t1,y1(:,1),'g'),grid on, hold on
set(gca,'FontSize',fonts);
axis([0 te -12 12]); 
plot(t2,y2(:,1),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
title('Grün: Analoges Modell, Blau: Digitales Modell')
ylabel('y')

subplot(2,1,2)
plot(t1,y1(:,2),'g'), grid on, hold on
set(gca,'FontSize',fonts);
axis([0 te -1.5 2.5]); 
plot(t2,y2(:,2),'bx','LineW', 2)
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
ylabel('x')

