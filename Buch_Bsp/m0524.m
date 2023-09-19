%  m0524.m     (Matlab/Simulink R2007b)
%
%  Bild 5.24 a und b
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  s0524.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%    Kpr     Reglerverstärkung im Bereich  0.1 < Kpr < 16
%
%  Erlaubtes Polgebiet: 
%    d       Dämpfungsgrad im Bereich 0.0 < d  <  0.99.
%    omega0  Kennkreisfrequenz im Bereich 0 < omega0 < 4
%
% ########################################################
clear

      Kpr=4.16;       % Voreinstellung Kpr=4.16

      d=.7;           % Voreinstellung d=0.7
      omega0=3;       % Voreinstellung omega0=3;

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;  

% Offener Kreis
%---------------------------------------------
% Strecke:
Kps=0.2; T1S=0.8; T2S=sqrt(0.2);
s=tf('s');
Gs=Kps/(T2S^2*s^2+T1S*s+1);
szae=Gs.num{1};
snen=Gs.den{1};

% Regler mit Kpr=1 
Tv=0.33;  T1R=0.25;
Gr=(Tv*s+1)/(T1R*s+1);
rzae=Gr.num{1};
rnen=Gr.den{1};

% Offener Kreis:
Go=Gr*Gs;
ozae=Go.num{1};
onen=Go.den{1};


% WOK
%---------------------------------------------

figure(1)
set(gcf,'Units','normal','Position',[.5 .5 .45 .44], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 5.24a');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes 

re1=[-5 1]; re2=[0 0]; im1=[0 0]; im2=[-5 5]; 
plot(re1,re2,'k',im1,im2,'k')
grid on;  hold on
reachs=[-5:1:5]; imachs=[-5:1:5];
set(gca,'FontSize',fonts,...
    'DataAspectRatio',[1 1 1],...
    'XTick',imachs,'YTick',reachs);
axis([-5 1 -5 5])
xlabel('Re\{s\} \rightarrow')
ylabel('Im\{s\} \rightarrow')

[r,k]=rlocus(ozae,onen);     %  WOK berechnen
plot(r,'c-','LineW',1)       %  WOK plotten

p=roots(onen);               % Pole
z=roots(ozae);               % Nullstellen
plot(real(p),imag(p),'cx',real(z),imag(z),'co',...
    'LineW',2) 

% Pole für gegebenes Kpr einzeichnen:
[rparam,Kpr]=rlocus(ozae,onen,Kpr);
plot(rparam,'rx','LineW',2);
s1=' Rot: Pole des Regelkreises für Kpr=';
title([s1,num2str(Kpr)])

% Erlaubtes Polgebiet
dstr=sqrt(1-d^2); omegae=omega0*dstr;
sigma=-omega0*d;

incr=pi:.1:2*pi;         
x=omega0*sin(incr); y=omega0*cos(incr);
plot(x,y,'k')

x=[-5:.1:0]; y=-abs(omegae/sigma)*x;
plot(x,y,'k')
x=[-5:.1:0]; y=abs(omegae/sigma)*x;
plot(x,y,'k')


% Zeitverhalten
%---------------------------------------------
%  Vorfilter:
Kv=(1+Kps*Kpr)/(Kps*Kpr);      % Damit eb=0

figure(2)
set(gcf,'Units','normal','Position',[.5 .07 .45 .35], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 5.24b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes 

wdach=1;
tstep=0.001;  
te=3.5;

opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);

[t,x,y]=sim('s0524',[0 te],opts);

tachs1=[-0.5 te]; tachs2=[0 0]; 
xachs1=[ 0 0]; xachs2=[-0.2 1.5];
plot(tachs1,tachs2,'k',xachs1,xachs2,'k')
grid on, hold on
set(gca,'FontSize',fonts,...
    'Position',[.15 .17 .75 .7]);
axis([-.5 te -.2 1.5]); 
xlabel('t \rightarrow')
ylabel('x , w \rightarrow')

plot(t,y(:,1),'r','LineW',2) 
plot(t,y(:,2)) 

eps=0.05;  
wtolob=wdach+eps; wtovec=[wtolob wtolob];
wtolun=wdach-eps; wtuvec=[wtolun wtolun];
zeit=[0 te];
plot(zeit,wtovec,'m',zeit,wtuvec,'m')

s1=' Rot: Führungssprungantwort für Kpr=';
title([s1,num2str(Kpr)])

