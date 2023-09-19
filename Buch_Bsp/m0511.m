%  m0511.m     (Matlab/Simulink R2007b)
%
%  Bild 5.11 a und b
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
%  wpar  Vektor wpar=[ omega1 omega2 ... ] mit Frequenz-
%        werten omega1, omega2, ... auf Ortskurven bzw.
%        im Frequenzkennlinien im Bereich .01 < omegai < 1 
%                            
% ########################################################
clear

   wpar=[ .01  .1  1. ];        %  wpar=[.01 .1 1.] 

% ########################################################

menu='none';  % none oder fig
close all
fonts=8; 


% Offener Kreis
%  Nr.1:
Kps1=2.5; Ts1=5; Tt1=8;
s=tf('s');
Go=( 1/(Ts1*s+1)^3 )*exp(-Tt1*s);
Go1=Kps1*Go;
Go1=pade(Go1,3);   
ozae1=Go1.num{1};
onen1=Go1.den{1};

%  Nr.2:
Kps2=1.5; 
Go2=Kps2*Go;
Go2=pade(Go2,3);   
ozae2=Go2.num{1};
onen2=Go2.den{1};



% Ortskurven
figure(1)
set(gcf,'Units','normal','Position',[.53 .53 .45 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 5.11a: Ortskurven');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes  

re1=[-1.5 2.5]; re2=[ 0 0];
im1=[0 0]; im2=[ -2.5 1.5];
plot(re1,re2,'k',im1,im2,'k');
grid on, hold on
set(gca,'FontSize',fonts, ...
    'Position',[.1 .15 .8 .8],...
    'XTick',[-1:2],'YTick',[-2:1]);
axis([-1.5 2.5 -2.5 1.5])
axis square
xlabel('Re\{Go\} \rightarrow')
ylabel('Im\{Go\} \rightarrow')

w=logspace(-4,2,600);      %  Ortskurven
[re1,im1,w]=nyquist(ozae1,onen1,w);
[re2,im2,w]=nyquist(ozae2,onen2,w);
plot(re1,im1,'g',re2,im2,'g--')

incr=0:.1:2*pi;            % Einheitskreis
x=sin(incr); y=cos(incr);
plot(x,y,'k');

% Parametrierung
[re1,im1,wpar]=nyquist(ozae1,onen1,wpar);
[re2,im2,wpar]=nyquist(ozae2,onen2,wpar);
plot(re1,im1,'r.',re2,im2,'r.','MarkerSize',12); 
wparstring=num2str(wpar);
text(re1,im1,wparstring,'VerticalAlign','bottom',...
    'HorizontalAlignment','right','fonts',8)
text(re2,im2,wparstring,'VerticalAlign','bottom',...
    'HorizontalAlignment','right','fonts',8)


% Frequenzgang im Bode-Diagramm
figure(2)
set(gcf,'Units','normal','Position',[.53 .05 .45 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 5.11b: Bode-Diagramme');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes  

dBachs=[-2,-1,0,1,2]*10;
phachs=[-5,-4,-3,-2,-1,0,1,2,3,4,5]*90;

w=logspace(-2,0,500);  %  Frequenzachse

[betr1,phas1,w]=bode(ozae1,onen1,w);
[betr2,phas2,w]=bode(ozae2,onen2,w);

subplot(2,1,1)
betr1=20*log10(betr1);
betr2=20*log10(betr2);
semilogx(w,betr1,'g',w,betr2,'g--')
grid on; hold on
set(gca,'FontSize',fonts,'YTick',dBachs)
axis([0.01 1 -10 10])
db1=[.01 1]; db2=[ 0 0 ];
semilogx(db1,db2,'k')
xlabel('\omega/(rad/s) \rightarrow','fonts',8)
ylabel('|G_O|_{dB} \rightarrow')

subplot(2,1,2)
semilogx(w,phas1,'g',w,phas2,'g--'); grid on; hold on
set(gca,'FontSize',fonts,'YTick',phachs);
axis([0.01 1 -270 0])
grd1=[.01 1]; grd2=[ -180 -180 ];
semilogx(grd1,grd2,'k')
xlabel('w  (rad/s)')
ylabel('/Go')
xlabel('\omega/(rad/s) \rightarrow','fonts',8)
ylabel('/G_O \rightarrow')

% Parametrierung
[betr1,phas1,w]=bode(ozae1,onen1,wpar);
[betr2,phas2,w]=bode(ozae2,onen2,wpar);

subplot(2,1,1)
betr1=20*log10(betr1);
betr2=20*log10(betr2);
plot(wpar,betr1,'r.',wpar,betr2,'r.','Markers',12)
wparstring=num2str(wpar);
text(wpar,betr1,wparstring,'VerticalAlign','bottom',...
    'HorizontalAlignment','left','fonts',8)
text(wpar,betr2,wparstring,'VerticalAlign','bottom',...
    'HorizontalAlignment','left','fonts',8)

subplot(2,1,2)
plot(wpar,phas1,'r.',wpar,phas2,'r.','Markers',12)
wparstring=num2str(wpar);
text(wpar,phas1,wparstring,'VerticalAlign','bottom',...
    'HorizontalAlignment','left','fonts',8)

