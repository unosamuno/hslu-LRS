%  m1019.m     (Matlab/Simulink R2007b)
%
%  Bild 10.19 b und c
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  s1019a.mdl
%
%  (c)5.7.09  R.Froriep
%
% ........................................................
%
%  Hinweis:
%    
%     Dieses Programm ist nur zusammen mit der
%
%     Fuzzy Logic Toolbox  lauffähig.
%
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%     Die 3 Fuzzy-Regler von Bild 10.19b und c:
%
%       Nur Regler 1:    ii=1
%       Nur Regler 2:    ii=2
%       Nur Regler 3:    ii=3
%
%
%     Simulink-Programm (Bild 10.19a) zeigen:
%       ja:    schalt=1
%       nein:  schalt=0
%
% ########################################################
clear

      ii=2;           %  ii=2
      
      schalt=0;       %  schalt=0
  
% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

if schalt==1
    open_system('s1019a')
end

% Füllstandstrecke:
%-----------------------------------------------------
A=30*1e-4;        % m^2
rho=1e3;          % kg/m^3
cP=2e-3;          % (kg/s)/V
g=9.81;           % m/s^2
c1=sqrt(2*g)/A;
c2=cP/(rho*A);

% Arbeitspunkt:
hs=10;            % cm
Aab0=7;           % mm^2
hs=1e-2*hs;       % cm --> m
Aab0=1e-6*Aab0;   % mm^2 --> m^2
up0=(c1/c2)*Aab0*sqrt(hs);
%
% k=1/(2*sqrt(hs));
% a0=c1*Aab0*k;
% b01=c2;
% b02=-c1*sqrt(hs);

% KPS=b01/a0;   % m/V
% KPS=KPS*100;  % m/V --> cm/V
% T1=1/a0;      % s
% szae=[KPS];
% snen=[T1 1];
%
% KPSz=b02/a0;     % m/m^2
% KPSz=KPSz*1e-4;  % --> cm/mm^2
% szaez=[KPSz];
% snenz=[T1 1];

figure(1)
set(gcf,'Units','normal','Position',[.55 .4 .45 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Zugehörigkeitsfunktionen zu Bild 10.19');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

figure(2)
set(gcf,'Units','normal','Position',[.53 .55 .45 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 10.19b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

figure(3)
set(gcf,'Units','normal','Position',[.53 .1 .45 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 10.19c');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

% Fuzzy-Regler:

%for ii=1:3    % Vergleich verschiedener Fuzzy-Regler

    fuell=newfis('fuell');  % Neues FIS

    % Def. Eingangsgrößen
    emax=2.5;  % Max.Betrag
    fuell=addvar(fuell,'input','Regeldifferenz',[-emax emax]);

    % Zugehörigkeitsfunktionen ("Werte der Kenngröße e")
    if ii==1
        % Volle Überlappung
        fuell=addmf(fuell,'input',1,'NU','trimf',[-emax/2 0 emax/2]);
        fuell=addmf(fuell,'input',1,'N','trapmf',[-2*emax -2*emax -emax/2 0]);
        fuell=addmf(fuell,'input',1,'P','trapmf',[0 emax/2 2*emax 2*emax]);
    end

    if ii==2
        % 50% Überlappung
        fuell=addmf(fuell,'input',1,'NU','trimf',[-emax/2 0 emax/2]);
        fuell=addmf(fuell,'input',1,'N','trapmf',[-2*emax -2*emax -3*emax/4 -emax/4]);
        fuell=addmf(fuell,'input',1,'P','trapmf',[ emax/4 3*emax/4 2*emax 2*emax]);
    end

    if ii==3
        % Keine Überlappung
        fuell=addmf(fuell,'input',1,'NU','trimf',[-emax/2 0 emax/2]);
        fuell=addmf(fuell,'input',1,'N','trapmf',[-2*emax -2*emax -emax -emax/2]);
        fuell=addmf(fuell,'input',1,'P','trapmf',[ emax/2 emax 2*emax 2*emax]);
    end

    % Def. Ausgangsgrößen
    Dup=min(10-up0,up0);
    Dupmax=Dup; Dupmin=-Dup;
    fuell=addvar(fuell,'output','Pumpenspannung',[2*Dupmin 2*Dupmax]);

    % Zugehörigkeitsfunktionen
    fuell=addmf(fuell,'output',1,'NU','trimf',[Dupmin/2 0 Dupmax/2]);
    fuell=addmf(fuell,'output',1,'N','trimf',[2*Dupmin Dupmin 0]);
    fuell=addmf(fuell,'output',1,'P','trimf',[ 0 Dupmax 2*Dupmax]);

    % Regeln
    %  Regel1='if Regeldifferenz is negativ then Pumpenspannung is niedrig';
    %  Regel2='if Regeldifferenz is OK then Pumpenspannung is mittel';
    %  Regel3='if Regeldifferenz is positiv then Pumpenspannung is hoch';
    %  regel=parsrule(dd,ruleTxt,'verbose');

    Regelliste=[
        1 1 1 1
        2 2 1 1
        3 3 1 1];
    fuell=addrule(fuell,Regelliste);

    figure(1)
    subplot(2,1,1)
    plotmf(fuell,'input',1)
    hold on, grid on
    eachs=[-10:10]*.5; uPachs=[-10:10]*1; zfachs=[0:10]*.2;
    set(gca,'FontSize',fonts,...
        'Position',[.12 .63 .8 .3],...
        'XLim',[-emax emax],...
        'YLim',[-.1 1.1],...
        'XTick',eachs,...
        'YTick',zfachs);
    xlabel('e \rightarrow')
    ylabel('\mu \rightarrow')

    subplot(2,1,2)
    plotmf(fuell,'output',1)
    hold on, grid on
    set(gca,'FontSize',fonts,...
        'Position',[.12 .15 .8 .3],...
        'XLim',[Dupmin Dupmax],...
        'YLim',[-.1 1.1],...
        'XTick',uPachs,...
        'YTick',zfachs);
    xlabel('y \rightarrow')
    ylabel('\mu \rightarrow')


    figure(2)
    null=[0 0]; xnull=[-emax emax]; ynull=[Dupmin Dupmax];
    plot(xnull,null,'k-',null,ynull,'k-')
    hold on, grid on
    [x,y,z]=gensurf(fuell,1,1,100);
    plot(x,z)
    set(gca,'FontSize',fonts,...
        'Position',[.2 .15 .8 .8],...
        'XLim',[-emax emax],...
        'YLim',[Dupmin Dupmax],...
        'XTick',eachs,...
        'YTick',uPachs,...
        'DataAspectRatio',[.5 1 1]);
    xlabel('e \rightarrow')
    ylabel('y \rightarrow')


    % Störsprungantwort
    if ii==1, linie='b-'; end
    if ii==2, linie='b-'; end
    if ii==3, linie='b-'; end

    zdach=3;  % Delta Aab in mm^2
    zdach=zdach*1e-6;  % Umrechnung in m^2
    wdach=hs;  % Führungsgröße im AP

    figure(3)
    te=21;   %150;
    tachs=[-10:10]*5;

    steptime=1;

    opts=simset('Solver','ode45',...
        'InitialState',[hs],...
        'MaxStep',te/600);
    [t,x,y]=sim('s1019a',[0 te],opts);

    t=t-steptime;   t0=-steptime;   te=te-steptime;
    tynull=[-steptime te]; ynull=[0 0]; %Null-Linie
    tnull=[0 0];

    subplot(3,1,1)
    ytnull=[-.5 4];
    plot(tynull,ynull,'k',tnull,ytnull,'k')
    grid on, hold on
    y(:,4)=y(:,4)*1e6; % Umrechnung m^2 -> mm^2
    plot(t,y(:,4),linie)
    set(gca,'FontSize',fonts,'XTick',tachs);
    axis([t0 te -.5 4]);
    xlabel('t \rightarrow')
    ylabel('\Delta Aab \rightarrow')

    subplot(3,1,2)
    ytnull=[-1.5 .2];
    plot(tynull,ynull,'k',tnull,ytnull,'k')
    grid on, hold on
    y(:,2)=-y(:,2);
    plot(t,y(:,2),linie)
    set(gca,'FontSize',fonts,'XTick',tachs);
    axis([t0 te -1.5 .2]);
    xlabel('t \rightarrow')
    ylabel('h-h_S \rightarrow')

    subplot(3,1,3)
    ytnull=[-.5 5.2];
    plot(tynull,ynull,'k',tnull,ytnull,'k')
    grid on, hold on
    plot(t,y(:,3),linie)
    set(gca,'FontSize',fonts,'XTick',tachs);
    axis([t0 te -.5 5.2]);
    xlabel('t \rightarrow')
    ylabel('y \rightarrow')

%end   % Versch. Fuzzy-Regler

