%  m0509.m     (Matlab/Simulink R2007b)
%
%  Bild 5.9 a und b
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%  wpar  Vektor wpar=[ omega1 omega2 ... ] mit Frequenz-
%        werten omega1, omega2, ... auf der Ortskurve  
%
% ########################################################
clear

       wpar=[ .3 .5  1.118  1.88 ];

% ########################################################

menu='none';  % none oder fig
fonts=8; 
close all


% Offener Kreis
%---------------------------------------------
% Strecke:
Kps=1; Ts1=3; Ts2q=2;
s=tf('s');
Gs=Kps/(Ts2q*s^2+Ts1*s+1);
szae=Gs.num{1};
snen=Gs.den{1};

% PI-Regler:
Kpr=5;  Tn=0.4;
Gr=Kpr*(1+1/(Tn*s));
rzae=Gr.num{1};
rnen=Gr.den{1};

% Offener Kreis:
Go=Gr*Gs;
ozae=Go.num{1};
onen=Go.den{1};


% Ortskurve
%---------------------------------------------
figure(1)
set(gcf,'Units','normal','Position',[.6 .51 .3 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 5.9a'); 
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes  

re1=[-30 5]; re2=[ 0 0];
im1=[0 0]; im2=[ -30 5];
plot(re1,re2,'k',im1,im2,'k');
grid on, hold on
set(gca,'FontSize',fonts);
axis([-30 5 -30 5])
axis square

w=0.1:.02:10;            % Ortskurve 
[re,im,w]=nyquist(ozae,onen,w);
plot(re,im,'g','LineW',2)          

incr=0:.1:2*pi;          % Einheitskreis
x=sin(incr); y=cos(incr);
plot(x,y,'k');
hold on

% Parametrierung
[re,im,wpar]=nyquist(ozae,onen,wpar);
plot(re,im,'r.','MarkerSize',12);
wparstring=num2str(wpar);
text(re,im,wparstring,'VerticalAlign','bottom',...
    'HorizontalAlignment','right','fonts',8)


figure(2)
set(gcf,'Units','normal','Position',[.6 .05 .3 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 5.9b'); 
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

re1=[-4 2]; re2=[ 0 0];
im1=[0 0]; im2=[ -3 3];
plot(re1,re2,'k',im1,im2,'k');
grid on, hold on
set(gca,'FontSize',fonts);
axis([-4 2 -3 3])
axis square

w=0.5:.02:10;            % Ortskurve 
[re,im,w]=nyquist(ozae,onen,w);
plot(re,im,'g','LineW',2)          

incr=0:.1:2*pi;          % Einheitskreis
x=sin(incr); y=cos(incr);
plot(x,y,'k');
hold on

% Parametrierung
[re,im,wpar]=nyquist(ozae,onen,wpar);
plot(re,im,'r.','MarkerSize',12); 
text(re,im,wparstring,'VerticalAlign','bottom','fonts',8)
