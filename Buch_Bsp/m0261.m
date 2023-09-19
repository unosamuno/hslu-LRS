%  m0261.m     (Matlab/Simulink R2007b)
%
%  Bild 2.61 a bis d
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
%    I-Beiwert     Ki im Bereich  0.1 < Ki < 1.
%    Zeitkonstante T1 im Bereich  0.7 < T1 < 10. 
%
%  Bildteil c:
%    Parametrierung der Ortskurve mit omega-Werten.
%                                  mittels Vektor ompar.  
%
% ########################################################
clear

    Ki=3.162;    % Voreinstellung:  Ki=3.162  

    T1=1.;        % Voreinstellung:  T1=1.

    ompar=[.5/T1 1/T1 2/T1];  % ompar=[.5/T1 1/T1 2/T1]


% ########################################################

menu='none';  % none oder fig
close all
fonts=8;


% I- und I-T1-Glied
%---------------------------------------------
s=tf('s');
Gsi=Ki/s
zaei=Gsi.num{1};
neni=Gsi.den{1};

Gst=Ki/s/(T1*s+1)
zaet=Gst.num{1};
nent=Gst.den{1};



% P-N-Plan
%---------------------------------------------
figure(1)
set(gcf,'Units','normal','Position',[.47 .55 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.61a');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

s12=roots(nent);
plot(real(s12),imag(s12),'x','LineW',2); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.18 .2 .7 .7],...
    'DataAspectRatio',[1 1 1],...
    'NextPlot','add');
axis([-1.5 .5 -1. 1.])
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
    'Name',' Bild 2.61b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

% Analytische Lösung:
tend=5*T1;   
t=0:.02:tend;
hi=Ki*t;
ht=Ki*(t-T1*(ones(size(t))-exp(-t/T1)));

plot(t,hi,'b'); grid on;     % I-Glied 
set(gca,'FontSize',fonts,...
    'Position',[.15 .25 .75 .6],...
    'NextPlot','add',...
    'XTick',[0:10],'YTick',[0:2:20]);
axis([0 tend 0 14])
title('Übergangsfunktion')
xlabel('t \rightarrow')
ylabel('h \rightarrow')
plot(t,ht,'b');   % IT1-Glied

% Asymptote bei IT1
asfkt=Ki*(t-T1*ones(size(t)));
plot(t,asfkt,'r--');


% Ortskurve
%---------------------------------------------
figure(3)
set(gcf,'Units','normal','Position',[.47 .23 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.61c');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

omdwo=0.1/T1:.01:10/T1;  %  omega 
Gi=Ki*ones(size(omdwo))./(j*omdwo);    
Gt=Ki*ones(size(omdwo))./( (T1*(j*omdwo) + ...
    ones(size(omdwo))).*(j*omdwo) );

plot(real(Gt),imag(Gt),'b');  % IT1-Glied
set(gca,'FontSize',fonts,...
    'Position',[.18 .2 .7 .7],...
    'DataAspectRatio',[1 1 1],...
    'NextPlot','add',...
    'XTick',[-7:1],'YTick',[-7:1]);
axis([-2.5 .5 -2.5 .5])
title('Ortskurve')
xlabel('Re\{G(j\omega)\} \rightarrow')
ylabel('Im\{G(j\omega)\} \rightarrow')

% Koordinatenachsen
re1=[-6.5 1]; re2=[0 0];
im1=[0 0]; im2=[-6.5 .5];
plot(re1,re2,'k',im1,im2,'k');

plot(real(Gi),imag(Gi),'b'); grid on;  % I-Glied


% Parametrierung
omdwo=ompar;
Gi=Ki*ones(size(omdwo))./(j*omdwo);
Gt=Ki*ones(size(omdwo))./( (T1*(j*omdwo) + ...
    ones(size(omdwo))).*(j*omdwo) );
plot(real(Gi),imag(Gi),'r.','MarkerSize',11); 
set(gca,'FontSize',fonts);
plot(real(Gt),imag(Gt),'r.','MarkerSize',11); 
for i=1:size(omdwo,2)
    text(real(Gi(i)),imag(Gi(i)),...
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
    'Name',' Bild 2.61d');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

% Frequenzbereich:
om1=.1/T1; logom1=log10(om1); 
om2=10/T1; logom2=log10(om2); 

omdwo=logspace(logom1,logom2,200);  % omdwo ist omega/wo
Gidb=20*log10(Ki)*ones(size(omdwo))...          % I-Glied
    -20*log10(omdwo);
Gpt1db=20*log10(1)*ones(size(omdwo))...         % PT1-Glied
    -20*log10(sqrt(ones(size(omdwo))+(omdwo*T1).^2));
Gtdb=Gidb + Gpt1db;                             % IT1-Glied

subplot(2,1,1)
semilogx(omdwo,Gidb,'b'); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .57 .7 .3],...
    'NextPlot','add');
axis([om1 om2 -10 40])
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

% Näherungsgeraden IT1
omdwo=logspace(logom1,log10(1/T1),100);
ngfkt=20*log10(Ki)*ones(size(omdwo))...          % I-Glied
    -20*log10(omdwo);
semilogx(omdwo,ngfkt,'r--');
omdwo=logspace(log10(1/T1),logom2,100);
ngfkt=20*log10(Ki)*ones(size(omdwo))...          % I-Glied
    -20*log10(omdwo)-20*log10(omdwo*T1);
semilogx(omdwo,ngfkt,'r--');

omdwo=logspace(logom1,logom2,200);  % omdwo ist omega/wo
Phasi=-pi/2*ones(size(omdwo))*180/pi;
Phaspt1=-atan2(omdwo,1/T1)*180/pi;
Phast=Phasi + Phaspt1;

subplot(2,1,2)
semilogx(omdwo,Phasi,'b'); grid on;
axis([om1 om2 -180 0])
set(gca,'FontSize',fonts,...
    'Position',[.2 .15 .7 .3],...
    'NextPlot','add',...
    'YTick',[-180:45:0], ...
    'YTickLabel', [' -pi ';'     ';'-pi/2';'     '; '  0  '])
xlabel('\omega \rightarrow')
ylabel('/\_ G(j\omega) \rightarrow')
semilogx(omdwo,Phaspt1,'b');
semilogx(omdwo,Phast,'b');

