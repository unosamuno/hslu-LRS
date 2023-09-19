%  m0256.m     (Matlab/Simulink R2007b)
%
%  Bild 2.56 a bis d 
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
%    P-Beiwert     Kp im Bereich  0.1 < Kp < 1.
%    Zeitkonstante T1 im Bereich  0.7 < T1 < 10. 
%
%  Bildteil c:
%    Parametrierung der Ortskurve mit omega-Werten.
%
% ########################################################
clear

     Kp=1;       % Voreinstellung: Kp=1

     T1=1;       % Voreinstellung: T1=1

     ompar=[.5/T1 1/T1 2/T1];  % ompar=[.5/T1 1/T1 2/T1];
     

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;     

% P-T1-Glied
%---------------------------------------------
s=tf('s');
Gs=Kp/(T1*s+1)
zae=Gs.num{1};
nen=Gs.den{1};



% P-N-Plan
%---------------------------------------------
figure(1)
set(gcf,'Units','normal','Position',[.47 .55 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.56a');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

s12=roots(nen);
plot(real(s12),imag(s12),'x','LineW',2)
grid on;
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
    'Name',' Bild 2.56b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes


% Analytische Lösung

tauend=5;   % Vielfaches von T1
tau=0:.02:tauend;
h=Kp*(1-exp(-tau/T1));

plot(tau,h,'b'); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.15 .25 .75 .6],...
    'NextPlot','add');
axis([0 tauend 0 1.2])
title('Übergangsfunktion')
xlabel('t \rightarrow')
ylabel('h \rightarrow')


% Ortskurve
%---------------------------------------------
figure(3)
set(gcf,'Units','normal','Position',[.47 .23 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.56c');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

omdwo=0:.02:50;  %  omega durch wo
G=Kp*ones(size(omdwo))./(T1*(j*omdwo) + ones(size(omdwo)));

plot(real(G),imag(G),'b'); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.18 .2 .7 .7],...
    'DataAspectRatio',[1 1 1],...
    'NextPlot','add');
axis([-.2 1.3 -1.2 0.3])
title('Ortskurve')
xlabel('Re\{G(j\omega)\} \rightarrow')
ylabel('Im\{G(j\omega)\} \rightarrow')

% Koordinatenachsen
nulin=-.5:.1:1.5;
plot(nulin,zeros(size(nulin)),'k');
nulin=-2:.1:.5;
plot(zeros(size(nulin)),nulin,'k');

% Parametrierung
omdwo=ompar;
G=Kp*ones(size(omdwo))./(T1*(j*omdwo) + ones(size(omdwo)));
plot(real(G),imag(G),'r.','MarkerSize',11); 
set(gca,'FontSize',fonts);
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
    'Name',' Bild 2.56d');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

% Frequenzbereich:
om1=.01; logom1=log10(om1); 
om2=100; logom2=log10(om2); 

omdwo=logspace(logom1,logom2,200);  % omdwo ist omega/wo
Gdb=20*log10(Kp)*ones(size(omdwo))...
    -20*log10(sqrt(ones(size(omdwo))+(omdwo*T1).^2));

subplot(2,1,1)
semilogx(omdwo,Gdb,'b'); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .57 .7 .3],...
    'NextPlot','add');
axis([om1 om2 -30 10])
set(gca,'YTick',[-30:10:20])
title('Bode-Diagramm (rot: Näherungsgeraden)')
xlabel('\omega \rightarrow')
ylabel('| G(j\omega) |_{dB} \rightarrow')

% Näherungsgeraden
omdwo=logspace(logom1,log10(1/T1),100);
ngfkt=20*log10(Kp)*ones(size(omdwo));
semilogx(omdwo,ngfkt,'r--');
omdwo=logspace(log10(1/T1),logom2,100);
ngfkt=20*log10(Kp)*ones(size(omdwo))-20*log10(omdwo*T1);
semilogx(omdwo,ngfkt,'r--');

omdwo=logspace(logom1,logom2,200);  % omdwo ist omega/omE
Phase=-atan2(omdwo, 1/T1)*180/pi;

subplot(2,1,2)
semilogx(omdwo,Phase,'b'); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .12 .7 .3],...
    'YTick',[-90 -45 0],...
    'YTickLabel',['-pi/2';'-pi/4';'   0 '])
axis([om1 om2 -90 0])
xlabel('\omega \rightarrow')
ylabel('/\_ G(j\omega) \rightarrow')
