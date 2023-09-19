%  m0224.m     (Matlab/Simulink R2007b)
%
%  Bild 2.24 
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0224.mdl
%
%  (c) 5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%    DudachVec   -2 < DudachVec(i) < 2  (V)
%                Vektor mit Sprunghöhen der Pumpenspannung,
%                bezogen auf den Arbeitspunktwert uP0, als
%                Testsignale. Für die verschiedenen Sprung- 
%                höhen wird die Veränderung des Füllstands
%                h (bezogen auf hs) simuliert. 
%
%
% ########################################################
clear

DudachVec=[-2 :.5: 2 ];      % DudachVec=[-2 : .5 : 2 ]          

Kp=3.3;                      % Kp=3.3
T1=20;                       % T1=20;

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

% Streckendaten:
A=30*1e-4;   % m^2
rho=1e3;     % kg/m^3
cP=2e-3;     % (kg/s)/V
g=9.81;      % m/s^2

c1=sqrt(2*g)/A;  c2=cP/(rho*A);

% Linearisiertes Modell:
hmax=20;            % in cm,  Überlauf
hs=10;              % in cm
Dhmax=hmax-hs;      % in cm,  auf AP bez. Überlauf
Dhmin=-hs;          % in cm,  Tank leer, auf AP bez.
Aab0=6;             % in mm^2
hs=1e-2*hs;         % Umrechnung in m
Aab0=1e-6*Aab0;     % Umrechnung in m^2
up0=(c1/c2)*Aab0*sqrt(hs);
for j=1:size(DudachVec,2)  % abs. Pumpenspannung positiv
    if DudachVec(j)<-up0
        DudachVec(j)=-up0;
    end
end

k=1/(2*sqrt(hs));
a0=c1*Aab0*k;
b01=c2;
b02=-c1*sqrt(hs);

% Integrationsschleife:
te=500;
Dudach=0;
DAdach=0;

figure(1)
set(gcf,'Units','normal','Position',[.45 .6 .5 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.24a');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.7,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

figure(2)
set(gcf,'Units','normal','Position',[.1 .2 .3 .3], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.24b');
axes('Position',[0 0.95 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

figure(3)
set(gcf,'Units','normal','Position',[.45 .2 .5 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.24c');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.7,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

figure(1)
sp121=subplot(1,2,1);
set(gca,'FontSize',fonts,...
    'PlotBoxAspectRatio',[1 .5 1],...
    'XLim',[-50 te],...
    'XTick',[0:100:1000],...
    'YLim',[-3 3],...
    'YTick',[-4:4],...
    'NextPlot','add',...
    'Box','on');
tachsx=[-50 te]; tachsy=[0 0];
yachsx=[0 0]; yachsy=[-10 10];
plot(tachsx,tachsy,'k',yachsx,yachsy,'k')
grid off
title(['uP0=' num2str(up0) 'V'])
xlabel('t (s) \rightarrow')
ylabel('\Deltau_P (V) \rightarrow')

sp122=subplot(1,2,2);
set(gca,'FontSize',fonts,...
    'PlotBoxAspectRatio',[1 .5 1],...
    'XLim',[-50 te],...
    'XTick',[0:100:1000],...
    'YLim',[-12 12],...
    'YTick',[-40:4:40],...
    'NextPlot','add','Box','on');
tachsx=[-50 te]; tachsy=[0 0];
yachsx=[0 0]; yachsy=[-15 15];
plot(tachsx,tachsy,'k',yachsx,yachsy,'k')
grid off
title(['hs=' num2str(100*hs) 'cm'])
xlabel('t (s) \rightarrow')
ylabel('\Deltah (cm) \rightarrow')

figure(2)
set(gca,'FontSize',fonts,...
    'PlotBoxAspectRatio',[1 1 1],...
    'XLim',[-3 3],...
    'XTick',[-4:1:4],...
    'YLim',[-12 12],...
    'YTick',[-50:10:50],...
    'NextPlot','add','Box','on');
xachsx=[-4 4]; xachsy=[0 0];
plot(xachsx,xachsy,'k')
yachsx=[0 0]; yachsy=[-100 100];
plot(yachsx,yachsy,'k')
grid off
xlabel('\Deltau_P (V) \rightarrow')
ylabel('\Deltah (cm) \rightarrow')

figure(3)
set(gca,'FontSize',fonts,...
    'Units','norm',...
    'Position',[.3 .3 .4 .45],...
    'XLim',[-50 te],...
    'XTick',[0:100:1000],...
    'YLim',[-4 8],...
    'YTick',[-10:2:10],...
    'NextPlot','add','Box','on');
xachsx=[-50 te]; xachsy=[0 0];
yachsx=[0 0]; yachsy=[-10 10];
plot(xachsx,xachsy,'k',yachsx,yachsy,'k')
grid off
xlabel('t (s) \rightarrow')
ylabel('\Deltah/\Deltau_{P} (cm/V) \rightarrow')

Anzahl=size(DudachVec,2);
jj=1;  % Zählindex abgespeicherter bezogener Antw.funktionen
for i=1:Anzahl

    Dudach=DudachVec(i);
    
    opts=simset('Solver','ode45',...
        'InitialState',[],...
        'MaxStep',1.0);
    [t,x,y]=sim('s0224',[0 te],opts);

    figure(1)
    axes(sp121)
    plot(t,y(:,1),'k','linewidth',1.5)

    axes(sp122)
    y(:,2)=1e2*y(:,2);        % Dh in cm
    for j=1:size(y,1)           % Überlauf
        if y(j,2)>Dhmax
            y(j,2)=Dhmax;
        end
        if y(j,2)<Dhmin
            y(j,2)=Dhmin;
        end
    end
    plot(t,y(:,2),'k','linewidth',1)

    % Werte für statische Kennlinie
    uPK=y(size(y,1),1);
    DhK=y(size(y,1),2);
    figure(2)
    plot(uPK,DhK,'ok','linewidth',1.5)

    % Normierte Antwortfunktionen
    if ((i>=3)&(i<=7))
        if uPK~=0
            Dhnorm(:,jj)=y(:,2)/uPK;        % Dh/udach in cm/V

            figure(3)
            plot(t,Dhnorm(:,jj),'k','linewidth',1)
            jj=jj+1;
        end
    end

end

% Messdaten=[t Dhnorm];                 % Messdaten für Bild 2.25







