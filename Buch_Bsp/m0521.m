%  m0521.m     (Matlab/Simulink R2007b)
%
%  Bild 5.21 a und b
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  keine
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   d       Dämpfungsgrad im Bereich 0.0 < d  <  0.99.
%   omega0  Kennkreisfrequenz im Bereich 0 < omega0 < 1.5
%
%   eps     Toleranzbereich im Bereich 0 < eps < .5
%
% ########################################################
clear

      d=.4;           % d=0.4
      omega0=1;       % omega0=1;

      eps=.05;        % eps=0.05;

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;  

% Geschlossener Kreis PT2
%---------------------------------------------
dstr=sqrt(1-d^2); omegae=omega0*dstr;
sigma=-omega0*d; phi=-atan2(d/dstr,1);

t0=-.5; te=10; t=[0:.1:te];
% Übergangsfunktion:
h=ones(size(t))- exp(sigma*t)*(1/dstr).*cos( omegae*t + ...
    phi*ones(size(t)) );
% Einhüllende:
hoben=ones(size(t))+ exp(sigma*t)*(1/dstr);
hunten=ones(size(t))- exp(sigma*t)*(1/dstr);

figure(1)
set(gcf,'Units','normal','Position',[.52 .52 .45 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 5.21a');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes 

plot(t,h,'r-',t,hoben,'g--',t,hunten,'g--'); 
grid; hold on
set(gca,'FontSize',fonts,...
    'Position',[.15 .2 .8 .7]);
axis([-1 te -.2 2.2])
xlabel('t \rightarrow')
ylabel('h \rightarrow')

tachs1=[-1 te]; tachs2=[ 0 0 ];
plot(tachs1,tachs2,'k')
yachs1=[ 0 0 ]; yachs2=[ -1 2.5 ];
plot(yachs1,yachs2,'k')

zeit=[0 te];
wtolob=1+eps; wtovec=[wtolob wtolob];
wtolun=1-eps; wtuvec=[wtolun wtolun];
plot(zeit,wtovec,'m',zeit,wtuvec,'m')


% Pole
%---------------------------------------------
dstr=sqrt(1-d^2); omegae=omega0*dstr;
sigma=-omega0*d;

figure(2)
set(gcf,'Units','normal','Position',[.52 .05 .45 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 5.21b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes 

plot(sigma,omegae,'rx',sigma,-omegae,'rx','LineW',2)
grid on,  hold on
set(gca,'FontSize',fonts,...
    'Position',[.15 .15 .8 .8],...
    'XTick',[-2.5:.5:.5],'YTick',[-1.5:.5:1.5]);
xmin=-2.5; xmax=.5; ymin=-1.5; ymax=1.5;
axis([xmin xmax ymin ymax])
axis square
xlabel('Re\{s\} \rightarrow')
ylabel('Im\{s\} \rightarrow')

xachs1=[xmin xmax]; xachs2=[ 0 0 ];
plot(xachs1,xachs2,'k')
yachs1=[ 0  0]; yachs2=[ ymin ymax ];
plot(yachs1,yachs2,'k')

incr=pi:.1:2*pi;         
x=omega0*sin(incr); y=omega0*cos(incr);
plot(x,y,'k')

x=[-2.5:.1:0]; y=-abs(omegae/sigma)*x;
plot(x,y,'k')
x=[-2.5:.1:0]; y=abs(omegae/sigma)*x;
plot(x,y,'k')
