%  m0252.m     (Matlab/Simulink R2007b)
%  
%  Bild 2.52 a und b
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: keine
%
%  (c) 5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   Pendelmasse    m   im Bereich  0.3   < m  <  2.
%   Pendellänge    l   im Bereich  0.2   < l  <  .4
%   Reibungskoeff. cR  im Bereich  0.02  < cR < 0.5.
%
% ########################################################
clear

     m =.5;       % m=0.5 (kg)
     l =.2;       % l=0.2 (m)
     cR=.05;      % cR=.05 (Nm/(rad/s))

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

% Stehendes Pendel:
g=9.81;
a2=+1;
a1=+cR/(m*l*l);
a0=-g/l;
b0=-1/(m*l);
s=tf('s');
Gs=b0/(a2*s^2+a1*s+a0)
zae=Gs.num{1};
nen=Gs.den{1};


b=.05;       % Impulsintensität

te=5; t=0:.01:te;

figure(1)   % Impulsantwort
set(gcf,'Units','normal','Position',[.6 .5 .38 .3], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.52b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)

axes
set(gca,'FontSize',fonts,...
    'Position',[.18 .2 .7 .75],...
    'XLim',[0 te],...
    'XTick',[0:1:te],...
    'YLim',[-30 5],...
    'YTick',[-30:10:20],...
    'NextPlot','add',...
    'Box','on');
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
grid off
xlabel('t / s \rightarrow')
ylabel('\vartheta / Grad \rightarrow')


%  Auswertung von Lösungsformel auf S.73:
pole=roots(nen);
s1=pole(1);
s2=pole(2);
A1=b0*b/(s1-s2);
A2=b0*b/(s2-s1);
theta= A1*exp(s1*t) + A2*exp(s2*t);
theta=(180/pi)*theta;
plot(t,theta,'k-','LineWidth',1.5);


figure(2)   % Pole
set(gcf,'Units','normal','Position',[.29 .5 .3 .3], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.52a');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

plot(s1,0,'bx',s2,0,'bx','linewidth',2)
set(gca,'FontSize',fonts,...
    'Position',[.1 .15 .8 .8],...
    'DataAspectRatio',[1 1 1],...
    'XLim',[-10 8],...
    'XTick',[-10:2:8],...
    'YLim',[-8 8],...
    'ytick',[-8:2:8],...
    'NextPlot','add');
grid on
re1=[-10 8 ]; re2=[0 0]; im1=[0 0]; im2=[-8 8];
plot(re1,re2,'k'), plot(im1,im2,'r','LineW',2)
xlabel('Re\{s\} \rightarrow')
ylabel('Im\{s\} \rightarrow')
