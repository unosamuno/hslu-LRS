%  m0262.m     (Matlab/Simulink R2007b)
%
%  Bild 2.62 a bis d
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
%    D-Beiwert     Kd im Bereich  1.  < Kd < 10.
%    Zeitkonstante T1 im Bereich  0.7 < T1 <  5.
%
%  Bildteil c:
%    Parametrierung der Ortskurve mit omega-Werten:
%                                  mittels Vektor ompar.  
%
% ########################################################
clear

    Kd=10;                       % Kd=10

    T1=1;                        % T1=2

    ompar=[.5/T1 1/T1 2/T1];     % ompar=[.5/T1 1/T1 2/T1]
                 

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

% D- und D-T1-Glied
%---------------------------------------------
s=tf('s');
Gsd=Kd*s
zaed=Gsd.num{1};
nend=Gsd.den{1};

Gst=Kd*s/(T1*s+1)
zaet=Gst.num{1};
nent=Gst.den{1};


% P-N-Plan
%---------------------------------------------
figure(1)
set(gcf,'Units','normal','Position',[.47 .55 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.62a');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

nulst=roots(zaed);
pole=roots(nent);
plot(real(pole),imag(pole),'x','LineW',2)
grid on
set(gca,'FontSize',fonts,...
    'Position',[.18 .2 .7 .7],...
    'DataAspectRatio',[1 1 1],...
    'NextPlot','add');
axis([-2.5 .5 -1.5 1.5])
title('P-N-Plan')
xlabel('Re\{s\} \rightarrow')
ylabel('Im\{s\} \rightarrow')
plot(real(nulst),imag(nulst),'o','LineW',2);

% Koordinatenachse
re1=[-2.5 .5]; re2=[0 0];
im1=[0 0]; im2=[-1.5 1.5];
plot(re1,re2,'k',im1,im2,'k');


% Übergangsfunktion
%---------------------------------------------
figure(2)
set(gcf,'Units','normal','Position',[.73 .55 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.62b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

% Analytische Lösung
tend=5*T1;   
t=0:.02:tend;
ht=(Kd/T1)*exp(-t/T1);

plot(t,ht,'b'); grid on;     % DT1-Glied 
set(gca,'FontSize',fonts,...
    'Position',[.15 .25 .75 .6],...
    'NextPlot','add',...
    'XTick',[0:10],'YTick',[0:2:20]);
axis([0 tend 0 10])
title('Übergangsfunktion')
xlabel('t \rightarrow')
ylabel('h \rightarrow')

% Asymptote bzgl.T1
asfkt=(Kd/T1)*(-(t./T1)+ones(size(t)));
plot(t,asfkt,'r--');


% Ortskurve
%---------------------------------------------
figure(3)
set(gcf,'Units','normal','Position',[.47 .23 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.62c');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

omdwo=0/T1:.02:100/T1;  %  omega 
Gd=Kd*j*omdwo; 
Gt=Kd*(j*omdwo)./( (T1*(j*omdwo) + ones(size(omdwo))) );

plot(real(Gt),imag(Gt),'b');  % IT1-Glied
set(gca,'FontSize',fonts,...
    'Position',[.18 .2 .7 .7],...
    'DataAspectRatio',[1 1 1],...
    'NextPlot','add',...
    'XTick',[-5:5:22],'YTick',[-5:5:22]);
axis([-5 25 -5 25])
title('Ortskurve')
xlabel('Re\{G(j\omega)\} \rightarrow')
ylabel('Im\{G(j\omega)\} \rightarrow')

% Koordinatenachsen
re1=[-5 25]; re2=[0 0];
im1=[0 0]; im2=[-5 25];
plot(re1,re2,'k',im1,im2,'k');

plot(real(Gd),imag(Gd),'b'); grid on;  % I-Glied

% Parametrierung
omdwo=ompar;
Gd=Kd*j*omdwo;
Gt=Kd*(j*omdwo)./( (T1*(j*omdwo) + ones(size(omdwo))) );
plot(real(Gd),imag(Gd),'r.','MarkerSize',11); 
set(gca,'FontSize',fonts);
plot(real(Gt),imag(Gt),'r.','MarkerSize',11); 
for i=1:size(omdwo,2)
    text(real(Gd(i)),imag(Gd(i)),...
        ['   ',num2str(omdwo(i))],...
        'HorizontalAlignment','left',...
        'Fonts',8)
    text(real(Gt(i)),imag(Gt(i)),...
        ['   ',num2str(omdwo(i))],...
        'HorizontalAlignment','left',...
        'Fonts',8)
end


% Bode-Diagramm
%---------------------------------------------
figure(4)
set(gcf,'Units','normal','Position',[.73 .23 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.62d');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

% Frequenzbereich:
om1=.1/T1; logom1=log10(om1); 
om2=10/T1; logom2=log10(om2); 

omdwo=logspace(logom1,logom2,200);  % omdwo ist omega/wo
Gddb=20*log10(Kd)*ones(size(omdwo))...          % D-Glied
    +20*log10(omdwo);
Gpt1db=20*log10(1)*ones(size(omdwo))...         % PT1-Glied
    -20*log10(sqrt(ones(size(omdwo))+(omdwo*T1).^2));
Gtdb=Gddb + Gpt1db;                             % IT1-Glied

subplot(2,1,1)
semilogx(omdwo,Gddb,'b'); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .57 .7 .3],...
    'NextPlot','add');
axis([om1 om2 -10 30])
title('Bode-Diagramm (rot: Näherungsgeraden)')
xlabel('\omega \rightarrow ')
ylabel('| G(j\omega) |_{dB} \rightarrow')
semilogx(omdwo,Gpt1db,'b');
semilogx(omdwo,Gtdb,'b');
nu1=[om1 om2]; nu2=[0 0];
semilogx(nu1,nu2,'k');

% Näherungsgeraden PT1
omdwo=logspace(logom1,log10(1/T1),100);
ngfkt=20*log10(1)*ones(size(omdwo));
semilogx(omdwo,ngfkt,'r--');
omdwo=logspace(log10(1/T1),logom2,100);
ngfkt=20*log10(1)*ones(size(omdwo))-20*log10(omdwo*T1);
semilogx(omdwo,ngfkt,'r--');

% Näherungsgeraden DT1
omdwo=logspace(logom1,log10(1/T1),100);
ngfkt=20*log10(Kd)*ones(size(omdwo))...          % I-Glied
    +20*log10(omdwo);
semilogx(omdwo,ngfkt,'r--');
omdwo=logspace(log10(1/T1),logom2,100);
ngfkt=20*log10(Kd)*ones(size(omdwo))...          % I-Glied
    +20*log10(omdwo)-20*log10(omdwo*T1);
semilogx(omdwo,ngfkt,'r--');


omdwo=logspace(logom1,logom2,200);  
Phasd=+pi/2*ones(size(omdwo))*180/pi;
Phaspt1=-atan2(omdwo,1/T1)*180/pi;
Phast=Phasd + Phaspt1;

subplot(2,1,2)
semilogx(omdwo,Phasd,'b'); grid on;
axis([om1 om2 -90 90])
set(gca,'FontSize',fonts,...
    'Position',[.2 .15 .7 .3],...
    'NextPlot','add',...
    'YTick',[-90:45:90], ...
    'YTickLabel',['-pi/2';'     ';'  0  ';'     ';' pi/2'])
xlabel('\omega \rightarrow')
ylabel('/\_ G(j\omega) \rightarrow')

semilogx(omdwo,Phaspt1,'b');
semilogx(omdwo,Phast,'b');
nu1=[om1 om2]; nu2=[0 0];  % Nulllinie
semilogx(nu1,nu2,'k');

