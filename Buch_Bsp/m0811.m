%  m0811.m     (Matlab/Simulink R2007b)
%
%  Bild 8.11 a bis d 
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  s0811.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   T    Schrittweite (Abtastperiode) 
%                      im Bereich  0.01  < T  <  0.2
%
%   m    Pendelmasse im Bereich  0.3   < m  <  2.
%   l    Pendellänge im Bereich  0.1   < l  <  10.
%   cR   Reibungskoeff. im Bereich  0.02  < cR < 0.25.
%
% ########################################################
clear

     T =.1;       % T=0.1

     m =.5;       % m=0.5 (kg)
     l =.2;       % l=0.2 (m)
     cR=.05;      % cR=.05 (Nm/(rad/s))

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;


% Hängendes Pendel:
%---------------------------------------

% Analoges Streckenmodell:
g=9.81;
bb0=1/(m*l);
aa0=g/l;
aa1=cR/(m*l^2);
d=aa1/(2*sqrt(aa0));
Kps=bb0/aa0;
pole=roots([1 aa1 aa0]);
sigma=real(pole(1));
omegae=imag(pole(1));
phi=-atan(d/sqrt(1-d^2));

% Digitales Streckenmodell:
b0=0;
b1=Kps*(1/sqrt(1-d^2)*(cos(phi)...
    + exp(sigma*T)*cos(phi-omegae*T))...
    - 2*exp(sigma*T)*cos(omegae*T));
b2=Kps*(exp(sigma*T)* ( exp(sigma*T) ...
    - 1/sqrt(1-d^2)*cos(phi-omegae*T)) );
a1=-2*exp(sigma*T)*cos(omegae*T);
a2=exp(2*sigma*T);
z=tf('z',T);
Gsz=(b0*z^2+b1*z+b2)/(z^2+a1*z+a2)
dzae=Gsz.num{1};
dnen=Gsz.den{1};



% Impulsintensität
b=0.4;
beta=b/T;   % Höhe=Fläche b / Breite T



figure(1)   % Impulsantwort
set(gcf,'Units','normal','Position',[.6 .53 .4 .3], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 8.11b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes 


te=5;

opts=simset('Solver','FixedStepDiscrete',...
    'InitialState',[],...
    'FixedStep',T);
[t,x,y]=sim('s0811',[0 te],opts);

xachs1=[0 te]; xachs2=[ 0 0 ];
plot(xachs1,xachs2,'k'), grid on, hold on
set(gca,'FontSize',fonts,...
    'Position',[ .15 .2 .75 .75 ],...
    'XLim',[0 5],...
    'XTick',[0:1:5],...
    'YLim',[-30 30],...
    'YTick',[-80:10:80],...
    'NextPlot','add',...
    'Box','on');
plot(t,y(:,1),'bx','LineW',2)
xlabel(' t/s  \rightarrow');
ylabel(' \rm \phi / 1^0  \rightarrow');

figure(2)   % Pole
set(gcf,'Units','normal','Position',[.29 .53 .3 .3], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 8.11a');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes 


zpole=roots([1 a1 a2]);
zR=real(zpole(1));
zI=imag(zpole(1));

rachs=-3:5; rachs=rachs*0.5;
plot(zR,zI,'bx',zR,-zI,'bx','linewidth',2)
grid on, hold on
set(gca,'Position',[ .1 .2 .75 .75 ],...
    'FontSize',fonts,...
    'xtick',rachs);
axis([-1. 2. -1.5 1.5])
axis square
xlabel('Re\{z\}')
ylabel('Im\{z\}')

re1=[-1 2 ]; re2=[0 0]; im1=[0 0]; im2=[-1.5 1.5];
plot(re1,re2,'k',im1,im2,'k')

winkel=0:.1:2.01*pi;
xkreis=cos(winkel);
ykreis=sin(winkel);
plot(xkreis,ykreis,'r')


% Stehendes Pendel
%---------------------------------------

% Analoges Modell:
bb0=-1/(m*l);
aa0=-g/l;
aa1=cR/(m*l^2);
Kps=bb0/aa0;
pole=roots([1 aa1 aa0]);

% Digitales Modell
s1=pole(1);
s2=pole(2);
A0=bb0/((-s1)*(-s2));
A1=bb0/((s1-s2)*s1);
A2=bb0/((s2-s1)*s2);
z1=exp(s1*T);
z2=exp(s2*T);
b0=0;
b1=-(A0*(z1+z2) + A1*(1+z2) + A2*(1+z1));
b2= A0*z1*z2 + A1*z2 + A2*z1;
a1=-(z1+z2);
a2=z1*z2;
z=tf('z',T);
Gsz=(b0*z^2+b1*z+b2)/(z^2+a1*z+a2)
dzae=Gsz.num{1};
dnen=Gsz.den{1};


% Impulsintensität
b=0.05;
beta=b/T;   % Höhe=Fläche b / Breite T


figure(3)   % Impulsantwort
set(gcf,'Units','normal','Position',[.6 .15 .4 .3], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 8.11d');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes 


te=5;

opts=simset('Solver','FixedStepDiscrete',...
    'InitialState',[],...
    'FixedStep',T);
[t,x,y]=sim('s0811',[0 te],opts);


xachs1=[0 te]; xachs2=[ 0 0 ];
plot(xachs1,xachs2,'k'), grid on, hold on

y(:,1)=y(:,1);
plot(t,y(:,1),'bx','linewidth',2)
set(gca,'FontSize',fonts,...
    'Position',[ .15 .2 .75 .75 ],...
    'XLim',[0 te],...
    'XTick',[0:1:te],...
    'YLim',[-30 0],...
    'YTick',[-30:10:0],...
    'NextPlot','add',...
    'Box','on');
xlabel('t / s \rightarrow')
ylabel('\vartheta / 1^0 \rightarrow')


figure(4)    % Pole
set(gcf,'Units','normal','Position',[.29 .15 .3 .3], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 8.11c');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes 


zpole=roots([1 a1 a2]);
zR1=zpole(1); zI1=0;
zR2=zpole(2); zI2=0;

rachs=-3:5; rachs=rachs*0.5;
plot(zR1,zI1,'bx',zR2,zI2,'bx','linewidth',2)
grid on, hold on
set(gca,'Position',[ .1 .2 .75 .75 ],...
    'FontSize',fonts,'xtick',rachs);
axis([-1. 2. -1.5 1.5])
axis square
xlabel('Re\{z\}')
ylabel('Im\{z\}')

re1=[-1 2 ]; re2=[0 0]; im1=[0 0]; im2=[-1.5 1.5];
plot(re1,re2,'k',im1,im2,'k')

winkel=0:.1:2.01*pi;
xkreis=cos(winkel);
ykreis=sin(winkel);
plot(xkreis,ykreis,'r')

