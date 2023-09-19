%  m0258.m     (Matlab/Simulink R2007b)
%
%  Bild 2.58 a bis d
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
%    Kp  P-Beiwert im Bereich 0.1 < Kp < 1 
%    wo  Kennkreisfrequenz im Bereich 0.5 < wo < 1.5
%
%  Bildteil c:
%    Parametrierung der Ortskurve mit omega-Werten 
%                                  mittels Vektor ompar.  
%
%  (Dämpfungsgrad d siehe for-Schleife)
%
% ########################################################
clear

    Kp=1.;    % Voreinstellung: Kp=1

    wo=1.;    % Voreinstellung: wo=1

    ompar=[.7*wo 1*wo 1.5*wo ]; % ompar=[.7*wo 1*wo 1.5*wo ]
                  

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

tend=20;
tt=0:.02:tend;

figure(1)
set(gcf,'Units','normal','Position',[.47 .55 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.58a');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)

handleaxesf1=axes('Parent',gcf);
grid on;
set(gca,'FontSize',fonts,...
    'Position',[.18 .2 .7 .7],...
    'DataAspectRatio',[1 1 1],...
    'NextPlot','add',...
    'Box','on');
axis([-2.7 .3 -1.5 1.5])
title('P-N-Plan')
xlabel('Re\{s\} \rightarrow')
ylabel('Im\{s\} \rightarrow')

figure(2)
set(gcf,'Units','normal','Position',[.73 .55 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.58b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
%axes

handleaxesf2=axes('Parent',gcf);
set(gca,'FontSize',fonts,...
    'Position',[.15 .25 .75 .6],...
    'NextPlot','add',...
    'XTick',[0:4:24],...
    'Box','on');
axis([0 tend 0 1.6])
title('Übergangsfunktion')
xlabel('t \rightarrow')
ylabel('h \rightarrow')

figure(3)
set(gcf,'Units','normal','Position',[.47 .23 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.58c');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)

handleaxesf3=axes('Parent',gcf);
set(gca,'FontSize',fonts,...
    'Position',[.18 .2 .7 .7],...
    'DataAspectRatio',[1 1 1],...
    'NextPlot','add',...
    'Box','on');
axis([-1.5 2 -3 0.5])
title('Ortskurve')
xlabel('Re\{G(j\omega)\} \rightarrow')
ylabel('Im\{G(j\omega)\} \rightarrow')

figure(4)
set(gcf,'Units','normal','Position',[.73 .23 .25 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.58d');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

handleaxesf4sp211=subplot(2,1,1);
set(gca,'FontSize',fonts,...
    'Position',[.2 .57 .7 .3],...
    'Box','on');

handleaxesf4sp212=subplot(2,1,2);
set(gca,'FontSize',fonts,...
    'Position',[.2 .12 .7 .3])

s=tf('s');

for i=1:4
    if i==1, d=0.2; end   % Voreinstellung: 0.2
    if i==2, d=0.7; end   % Voreinstellung: 0.7
    if i==3, d=1.0; end   % Voreinstellung: 1.0 
    if i==4, d=1.5; end   % Voreinstellung: 1.5
    
    
    % P-T2-Glied
    %---------------------------------------------
    T1=2*d/wo;  
    T2=1/wo;
    Gs=Kp/(T2^2*s^2+T1*s+1)
    zae=Gs.num{1};
    nen=Gs.den{1};

        
    figure(1)
    axes(handleaxesf1)
    
    % P-N-Plan
    %---------------------------------------------
    s12=roots(nen);
    plot(real(s12),imag(s12),'x','LineW',2); 
    
    % Koordinatenachse
    re1=[-2.7 .3]; re2=[0 0];
    im1=[0 0]; im2=[-1.5 1.5];
    plot(re1,re2,'k',im1,im2,'k');
    
    % Wurzelortskurve für 0<d<oo
    dd=0:.01:1;
    ddr=-wo*dd; ddi=wo*sqrt(1-dd.^2);
    plot(ddr,ddi);
    ddi=-wo*sqrt(1-dd.^2);
    plot(ddr,ddi);
    ddr=[-2.7 0]; ddi=[0 0];
    plot(ddr,ddi);
    
    
    % Übergangsfunktion
    %---------------------------------------------
    figure(2)
    axes(handleaxesf2)
    
    % Analytische Lösung
    if d<1
        phi=-atan(d/sqrt(1-d^2));
        h=Kp*(1-exp(-d*wo*tt)*sqrt(1/(1-d^2)).*cos(sqrt(1-d^2)*wo*tt+phi));
        
    elseif d==1
        h=Kp*(1-exp(-d*wo*tt)-wo*tt.*exp(-d*wo*tt));
        
    else 
        ds=sqrt(d^2-1);
        h=Kp*(1+ 1/(2*ds)*((d-ds)*exp(-(d+ds)*wo*tt)-(d+ds)*exp(-(d-ds)*wo*tt)));
        
    end
    
    plot(tt,h,'b'); grid on;
    
    
    % Ortskurve
    %---------------------------------------------
    figure(3)
    axes(handleaxesf3)
    
    omdwo=0:.02:20;  %  omega durch wo
    G=Kp*ones(size(omdwo))./((j*omdwo).^2 + 2*d*(j*omdwo) + ones(size(omdwo)));
    
    plot(real(G),imag(G),'b'); grid on;
    
    % Koordinatenachsen
    nulin=-1.5:.1:2;
    plot(nulin,zeros(size(nulin)),'k');
    nulin=-3:.1:.5;
    plot(zeros(size(nulin)),nulin,'k');
    
    % Parametrierung
    omdwo=ompar;
    G=Kp*ones(size(omdwo))./((j*omdwo).^2 + 2*d*(j*omdwo) + ones(size(omdwo)));
    plot(real(G),imag(G),'r.','MarkerSize',11); 
    
    
    
    % Bode-Diagramm
    %---------------------------------------------
    figure(4)
    % Frequenzbereich:
    om1=.1; logom1=log10(om1); 
    om2=10; logom2=log10(om2); 
    
    omdwo=logspace(logom1,logom2,200);  % omdwo ist omega/wo
    Gdb=20*log10(Kp)*ones(size(omdwo))...
        -20*log10(sqrt( (1-(omdwo).^2).^2 + (2*d*omdwo).^2 ));
    
    axes(handleaxesf4sp211)
    semilogx(omdwo*wo,Gdb,'b')
    hold on
    grid on
    axis([om1 om2 -20 20])
    title('Bode-Diagramm (rot: Näherungsgeraden)')
    xlabel('\omega \rightarrow')
    ylabel('| G(j\omega) |_{dB} \rightarrow')
    
    % Näherungsgeraden
    omdwo=logspace(logom1,0,100);
    ngfkt=20*log10(Kp)*ones(size(omdwo));
    semilogx(omdwo*wo,ngfkt,'r--');
    omdwo=logspace(0,logom2,100);
    ngfkt=20*log10(Kp)*ones(size(omdwo))-40*log10(omdwo);
    semilogx(omdwo*wo,ngfkt,'r--');
    
    omdwo=logspace(logom1,logom2,200)+log10(wo);  % omdwo ist omega/wo
    Phase=-atan2(2*d*omdwo, 1-omdwo.^2)*180/pi;
    
    axes(handleaxesf4sp212)
    semilogx(omdwo*wo,Phase,'b')
    grid on
    hold on
    axis([om1 om2 -180 0])
    set(gca,...
        'YTick',[-180 -90 0],...
        'YTickLabel',[' -pi ';'-pi/2';'   0 '])
    xlabel('\omega  \rightarrow')
    ylabel('/\_ G(j\omega)  \rightarrow')
    
    
end   % for mit d
