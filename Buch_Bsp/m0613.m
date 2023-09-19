%  m0613.m     (Matlab/Simulink R2007b)
%
%  Bilder 6.13 und 6.14
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  s0613.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%    Abtastperiode   T  im Bereich 0.2 < T  <  1.
%
%    T=0.5    Bild 6.13b
%    T=0.25   Bild 6.14b
%
% ########################################################
clear

     T=.25;       %  Voreinstellung T=0.5

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

% figure-windows definieren
figure(1)
set(gcf,'Units','normal','Position',[.6 .66 .35 .23], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 6.13b bzw. 6.14a');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.7,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

figure(2)
set(gcf,'Units','normal','Position',[.6 .33 .35 .23], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 6.13b bzw. 6.14b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.7,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes



% Analoger Regler:
Kpr=10; Tn=4; Tv=.5;

for i=1:2

    if i==1,         % Rückwärts-Rechteckregel
        b0=Kpr*(1 + T/Tn + Tv/T);
        b1=-Kpr*(1 + 2*Tv/T);
        b2=Kpr*Tv/T;
        stil='g';
    end

    if i==2,         % Trapezregel
        b0=Kpr*(1 + T/(2*Tn) + Tv/T);
        b1=-Kpr*(1 - T/(2*Tn) + 2*Tv/T);
        b2=Kpr*Tv/T;
        stil='r';
    end

    te=4;

    opts=simset('Solver','ode45',...
        'InitialState',[],...
        'MaxStep',.01);
    [t,x,y]=sim('s0613',[0 te],opts);


    figure(1)
    tachs1=[-.5 4]; tachs2=[0 0];
    yachs1=[ 0 0]; yachs2=[-.5 2];
    plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
    grid on, hold on
    plot(t,y(:,1))
    set(gca,'FontSize',fonts,...
        'Position',[.18 .22 .7 .65]);
    axis([-.5 te -.5 2]);
    title('Regeldifferenz')
    ylabel('e \rightarrow')
    xlabel('t \rightarrow')

    tm=[-.5 0 0]; fm=[0 0 y(1,1)];
    plot(tm,fm)


    figure(2)
    tachs1=[-.5 4]; tachs2=[0 0];
    yachs1=[ 0 0]; yachs2=[-1 35];
    plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
    grid on, hold on
    plot(t,y(:,2),'b',t,y(:,3),stil)

    tma=[-.5 0 0]; fma=[0 0 y(1,2)];
    tmd=[-.5 0 0]; fmd=[0 0 y(1,3)];
    plot(tmd,fmd,stil,tma,fma,'b')

    set(gca,'FontSize',fonts,...
        'Position',[.18 .22 .7 .65]);
    axis([-0.5 te -1 35]);

    title(['Blau: Analog,',...
        ' Rot: Trapez-Regel, Grün: Rechteck-Regel'])
    ylabel('y \rightarrow')
    xlabel('t \rightarrow')

end

