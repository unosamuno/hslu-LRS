%  m0251.m     (Matlab/Simulink R2007b)
%  
%  Bild 2.51 a und b
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
%   Reibungskoeff. cR  im Bereich  0.02  < cR < 0.285
%
% ########################################################
clear

     m =.5;       % Voreinstellung  m=0.5 (kg)
     l =.2;       % Voreinstellung  l=0.2 (m)
     cR=.05;      % Voreinstellung  cR=.05 (Nm/(rad/s))

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

% Hängendes Pendel:
g=9.81;     % m/s^2
a2=1;
a1=cR/(m*l*l);
a0=+g/l;
b0=1/(m*l);
s=tf('s');
Gs=b0/(a2*s^2+a1*s+a0)
zae=Gs.num{1};
nen=Gs.den{1};


b=.4;   % Impulsintensität

te=5;
t=0:.01:te;

figure(1)    % Impulsantwort
set(gcf,'Units','normal','Position',[.6 .5 .38 .3], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.51b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)

axes;
set(gca,'FontSize',fonts,...
    'Position',[.18 .2 .7 .75],...
    'XLim',[0 5],...
    'XTick',[0:1:5],...
    'YLim',[-30 30],...
    'YTick',[-80:10:80],...
    'NextPlot','add',...
    'Box','on');
tachs1=[0 te]; tachs2=[0 0];
plot(tachs1,tachs2,'k')
grid off
xlabel('t / s  \rightarrow')
ylabel('\phi / Grad  \rightarrow')


pole=roots(nen);

if max(abs(imag(pole)))==0

    %  Einfache reelle Pole
    s1=pole(1);
    s2=pole(2);
    A1=b0*b/(s1-s2);
    A2=b0*b/(s2-s1);
    phi= A1*exp(s1*t) + A2*exp(s2*t);
    phi=(180/pi)*phi;
    plot(t,phi,'k-','linewidth',1.5);


else
    %  Einfache komplexe Pole
    %  (Auswertung der Lösungsformel)
    s=pole(1); sig=real(s); om=imag(s); % Bild A.3.4 Fall 3
    C1=(1/om)*imag(b0*b);    %  =0, daher Sin-Form ohne Umrechnung
    C2=-C1*sig + real(b0*b);
    a=C1;
    b=(C2+C1*sig)/om;
    phi=exp(sig*t).*(a*cos(om*t) + b*sin(om*t));   % Buch S.72
    phi=(180/pi)*phi;
    plot(t,phi,'k-','linewidth',1.5);

end



figure(2)   % Pole
set(gcf,'Units','normal','Position',[.29 .5 .3 .3], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.51a');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)

axes;
set(gca,'FontSize',fonts,...
    'Position',[.1 .15 .8 .8],...
    'DataAspectRatio',[1 1 1],...
    'XLim',[-9 7],...
    'XTick',[-8:2:8],...
    'YLim',[-8 8],...
    'YTick',[-8:2:8],...
    'NextPlot','add',...
    'Box','on');
grid on
xlabel('Re\{s\} \rightarrow')
ylabel('Im\{s\} \rightarrow')
re1=[-9 7 ]; re2=[0 0];
plot(re1,re2,'k'),
im1=[0 0]; im2=[-8 8];
plot(im1,im2,'r','LineW',2)


if max(abs(imag(pole)))==0

    s1=real(pole(1));
    s2=real(pole(2));

    plot(s1,0,'bx',s2,0,'bx','linewidth',2)

else
    sR=real(pole(1));
    sI=imag(pole(1));

    plot(sR,sI,'bx',sR,-sI,'bx','linewidth',2)

end

