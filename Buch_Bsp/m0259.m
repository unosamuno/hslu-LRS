%  m0259.m     (Matlab/Simulink R2007b)
%
%  Bild 2.59 a bis d
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
%  Alle Bildteile:
%    P-Beiwert Kp im Bereich 0.1 < Kp < 1.
%    Totzeit   Tt im Bereich  0  < Tt < 2.5
%
%  Bildteil c:
%    Parametrierung der Ortskurve mit omega-Werten  
%                                  mittels Vektor ompar.  
%
% ########################################################
clear

    Kp=1;    % Voreinstellung:  Kp=1

    Tt=1;    % Voreinstellung:  Tt=1

    ompar=[.5 1 1.5]*(pi/Tt); %  ompar=[.5 1 1.5]*(pi/Tt)
                      

% ########################################################

menu='none';  % none oder fig
close all
fonts=8; 


% P-N-Plan
%---------------------------------------------
figure(1)
set(gcf,'Units','normal','Position',[.47 .55 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.59a');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

pole=0;
plot(real(pole),imag(pole)); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.18 .2 .7 .7],...
    'DataAspectRatio',[1 1 1],...
    'NextPlot','add');
axis([-1.5 .5 -1. 1.])
axis square
title('P-N-Plan')
xlabel('Re\{s\} \rightarrow')
ylabel('Im\{s\} \rightarrow')

% Koordinatenachse
re1=[-1.5 .5]; re2=[0 0];
im1=[0 0]; im2=[-1 1];
plot(re1,re2,'k',im1,im2,'k');


% Übergangsfunktion
%---------------------------------------------
figure(2)
set(gcf,'Units','normal','Position',[.73 .55 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.59b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes


% Analytische Lösung:
tend=3;
tincr=.001;
t=0:tincr:tend;
w0=floor(Tt/tincr); wkp=floor((tend-Tt)/tincr); 
h=zeros(1,w0); 
h( 1,(w0+1):size(t,2) ) = Kp*ones(1,(size(t,2)-w0));

plot(t,h,'b'); grid on; 
set(gca,'FontSize',fonts,...
    'Position',[.15 .25 .75 .6],...
    'NextPlot','add');
axis([0 tend 0 1.5])
title('Übergangsfunktion')
xlabel('t \rightarrow')
ylabel('h \rightarrow')


% Ortskurve
%---------------------------------------------
figure(3)
set(gcf,'Units','normal','Position',[.47 .23 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.59c');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

omdwo=0:.01:2*pi/Tt;  
G=Kp*exp(-j*omdwo*Tt);

plot(real(G),imag(G),'b'); grid on;  
set(gca,'FontSize',fonts,...
    'Position',[.18 .2 .7 .7],...
    'DataAspectRatio',[1 1 1],...
    'NextPlot','add');
axis([-1.5 1.5 -1.5 1.5])
title('Ortskurve')
xlabel('Re\{G(j\omega)\} \rightarrow')
ylabel('Im\{G(j\omega)\} \rightarrow')

% Koordinatenachsen
re1=[-1.5 1.5]; re2=[0 0];
im1=[0 0]; im2=[-1.5 1.5];
plot(re1,re2,'k',im1,im2,'k');

% Parametrierung
omdwo=ompar;
G=Kp*exp(-j*omdwo*Tt);
plot(real(G),imag(G),'r.','MarkerSize',11); 
for i=1:size(omdwo,2)
    text(real(G(i)),imag(G(i)),...
        ['   ',num2str(omdwo(i))],...
        'HorizontalAlignment','left',...
        'Fonts',8)
end


% Bode-Diagramm
%---------------------------------------------
figure(4)
set(gcf,'Units','normal','Position',[.73 .23 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.59d');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

% Frequenzbereich:
om1=.01; logom1=log10(om1); 
om2=10; logom2=log10(om2); 

omdwo=logspace(logom1,logom2,200);  % omdwo ist omega/wo
Gdb=20*log10(Kp)*ones(size(omdwo));

subplot(2,1,1)
semilogx(omdwo,Gdb,'b'); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .57 .7 .3],...
    'NextPlot','add');
axis([om1 om2 -20 20])
title('Bode-Diagramm')
xlabel('\omega \rightarrow')
ylabel('| G(j\omega) |_{dB} \rightarrow')

omdwo=logspace(logom1,logom2,200);  % omdwo ist omega/wo
Phase=-Tt*omdwo*180/pi;

subplot(2,1,2)
semilogx(omdwo,Phase,'b'); grid on;

set(gca,'FontSize',fonts,...
    'Position',[.2 .15 .7 .3],...
    'XLim',[om1 om2],...    
    'YLim',[-180 0],...
    'YTick',[-180:45:0],...
    'YTickLabel',...
    [' -pi '; '     ';'-pi/2';'     ';'  0  '])
xlabel('\omega \rightarrow')
ylabel('/\_ G(j\omega) \rightarrow')
