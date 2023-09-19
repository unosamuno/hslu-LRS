%  ma103.m     (Matlab/Simulink R2007b)
%
%  Bild A.1.3
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: sa103.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Erläuterungen:
%  
%    Dieses m-file (ein script-file) hat gegenüber dem
%    Buchtext einige zusätzliche Befehle, die aus
%    Platzgründen im Buch nicht enthalten sind, jedoch 
%    entbehrlich sind:
%
%    z.B. 
%    Zeile 29: Öffnen des model-files sa103.mdl zu 
%              Bild A.1.3a 
%    Zeilen 53 und 54: title für Bildüberschriften
%    Zeilen 50 und 61: set zum Konfigurieren der figures
%  
% ########################################################

clear
close all

menu='none';  % none oder fig
close all
open_system('sa103')

% RC-Netzwerk Daten:
R=1 ;         % KOhm
C=100;        % uF

% Umrechnung auf SI-Einheiten
R=R*1e3;
C=C*1e-6;

% Simulationsdauer
te=1;

% Ausgabefenster anlegen
figure(1)
set(gcf,'Units','normal','Position',[.5 .6 .5 .3], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild A.1.3b');
axis([0 1 0 1.2])
title('Eingangsspannung')
xlabel('t  \rightarrow')
ylabel('u_e  \rightarrow')
grid on
hold on
ha1=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes(ha1)

figure(2)
set(gcf,'Units','normal','Position',[.5 .2 .5 .3], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild A.1.3b');
axis([0 1 0 1.2])
title('Kondensatorspannung')
xlabel('t  \rightarrow')
ylabel('u_C  \rightarrow')
grid on
hold on
ha2=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes(ha2);


% Parametervariationsschleife
for i=1:3

    if i==2, R=2*R; end
    if i==3, R=3*R; end

    opts=simset('Solver','ode45',...
        'InitialState',[],...
        'MaxStep',.01);
    [t,x,y]=sim('sa103',[0 te],opts);

    figure(1)
    plot(t,y(:,1),'k','linewidth',1.5)

    figure(2)
    plot(t,y(:,2),'k','linewidth',1.5)

end

