%  m0204.m     (Matlab/Simulink R2007b)
%
%  Bild 2.4
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0204.mdl
%
%  (c) 5.7.09  R.Froriep
%
%
% ########################################################
%
%  Variations-Empfehlungen:
%       ue       -5 < ue < 5  (V)
%                Vektor mit konstanten Werten der 
%                Eingangsspannung ue, für die die Schaltung
%                der Reihe nach simuliert wird 
%
%       umax     in V
%                Überhitzungsgrenze (Leitung unterbrochen)
%
% ########################################################
clear all
%  Eingabefeld mit Angabe der Voreinstellungen  

     ue=[1:1:4 -1:-1:-3];     %   ue=[1:1:4 -1:-1:-3];        
     
     umax=3.5;                %   umax=3.5

% ########################################################
clc
menu='none';  % none oder fig
close all

% RC-Netzwerk Daten:
R=1 ;         % KOhm
C=100;        % uF

% Umrechnung auf SI-Einheiten
R=R*1e3;
C=C*1e-6;

T1=R*C;

te=.8;


figure(1)
set(gcf,'Units','normal','Position',[.4 .55 .5 .2], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.4');
ha=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.7,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes(ha)

sp1=subplot(1,2,1);
xachs1=[0 te]; xachs2=[0 0];
plot(xachs1,xachs2,'k')
set(gca,...
    'Position',[.13 .22 .35 .7],...
    'XLim',[0 te],'XTick',[],...
    'YLim',[-5 5],'YTick',[-5:5:5],...
    'Box','on',...
    'NextPlot','add');
xlabel('\itt  \rightarrow')
ylabel('\itu_{\rme} \rightarrow')
grid on

sp2=subplot(1,2,2);
xachs1=[0 te]; xachs2=[0 0];
plot(xachs1,xachs2,'k')
set(gca,...
    'Position',[.59 .22 .35 .7],...
    'XLim',[0 te],'XTick',[],...
    'YLim',[-5 5],'YTick',[-5:5:5],...
    'Box','on',...
    'NextPlot','add');
xlabel('\itt \rightarrow')
ylabel('\itu_{\rmC} \rightarrow')
grid on

% Startwerte für die for-Schleife
pause(.8)

Anzahl=size(ue,2);
for i=1:Anzahl    % Sprungantworten

    uedach=ue(i);

    opts=simset('Solver','ode45',...
        'InitialState',[],...
        'MaxStep',.01);
    [t,x,y]=sim('s0204',[0 te],opts);

    if i==1
        axes(sp1)
        plot(t,y(:,1),'k','linewidth',2)
        axes(sp2)
        plot(t,y(:,2),'k','linewidth',2)
    end


    axes(sp1)
    plot(t,y(:,1),'k','linewidth',1)

    axes(sp2)
    for j=1:size(y,1)           % Überlauf
        if abs(y(j,2))>umax
            y(j,2)=0;
        end
    end
    plot(t,y(:,2),'k','linewidth',1)

    pause(1)

end





