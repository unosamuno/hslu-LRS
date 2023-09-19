%  m0207.m     (Matlab/Simulink R2007b)
%
%  Bild 2.7
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0207.mdl
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
%       kenn     = 1 Kennlinie aus LZI-Modell einzeichnen 
%                = 0 keine Kennlinie
%                
% ########################################################
clear all
%  Eingabefeld mit Angabe der Voreinstellungen  
 
   ue=[0:1:4 -1:-1:-3];      %  ue=[0:1:4 -1:-1:-3]   
   
   umax=3.5;                 %  umax=3.5 

   kenn=0;                   %  kenn=0
   
% ########################################################
clc
close all
%clf(2)

% RC-Netzwerk Daten:
R=1 ;         % KOhm
C=100;        % uF

% Umrechnung auf SI-Einheiten
R=R*1e3;
C=C*1e-6;

T1=R*C;


te=.8;


% Plotfenster Zeitdiagramme
figure(1)
set(gcf,'Units','normal','Position',[.4 .55 .5 .2], ...
    'NumberTitle','off','MenuBar','none',...
    'Name',' Bild 2.7a');
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
xlabel('\itt \rightarrow')
ylabel('\itu_{\rme} \rm(V) \rightarrow')
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
ylabel('\itu_{\rmC} \rm(V) \rightarrow')
grid on


% Plotfenster Lineare Kennlinie:
figure(2)
set(gcf,'Units','normal','Position',[.55 .2 .25 .25], ...
    'NumberTitle','off','MenuBar','none',...
    'Name',' Bild 2.7b');
ha=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.7,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes(ha)

xachs1=[-5 5]; xachs2=[0 0]; yachs1=[0 0]; yachs2=[-5 5];
plot(xachs1,xachs2,'k',yachs1,yachs2,'k')
set(gca,...
    'Position',[.2 .25 .7 .7],...
    'XLim',[-5 5],'XTick',[-5:5:5],...
    'YLim',[-5 5],'YTick',[-5:5:5],...
    'Box','on',...
    'NextPlot','add');
xlabel('\itu_{\rmeK} \rm(V) \rightarrow')
ylabel('\itu_{\rmCK} \rm(V) \rightarrow')
grid on



% Berechnen und eintragen
pause(1)

Anzahl=size(ue,2);

for i=1:Anzahl    % Sprungantworten

    uedach=ue(i);

    assignin('base','uedach',uedach)
    opts=simset('Solver','ode45',...
        'InitialState',[],...
        'MaxStep',.01);
    [t,x,y]=sim('s0207',[0 te],opts);

    figure(1)
    axes(sp1)
    plot(t,y(:,1),'k','linewidth',1)
    axes(sp2)
    for j=1:size(y,1)           % Überlauf
        if abs(y(j,2))>umax
            y(j,2)=0;
        end
    end
    plot(t,y(:,2),'k','linewidth',1)


    % Werte für statische Kennlinie
    ueK=y(size(y,1),1);
    uCK=y(size(y,1),2);
    figure(2)
    plot(ueK,uCK,'xk','linewidth',1.5)
    pause(.8)

end

%  Kennlinie berechnen und eintragen
if kenn==1
ueK=[-5:.1:5];
uCK=ueK;
plot(ueK,uCK,'k','linewidth',1)
end


