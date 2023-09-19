%  m0203.m     (Matlab/Simulink R2007b)
%
%  Bild 2.3
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0203.mdl
%
%  (c) 5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%  tV       tV > 0         
%           Zeitspanne bis zu einer weiteren Messung an
%           der Schaltung. 
%
%           Ab welchem tV-Wert ändert sich das 
%           Übertragungsverhalten? (ab dann kann Zeit-
%           invarianz nicht mehr angenommen werden bzw.
%           das Verschiebungsprinzip ist nicht mehr erfüllt.)
%
% ########################################################
clear all
%  Eingabefeld mit Angabe der Voreinstellungen  

     tV =0.5;                    % tV=.5
     
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
t0=.2;
te=2;
uedach=1;


figure(1)
set(gcf,'Units','normal','Position',[.45 .65 .5 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.3');
ha=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.6,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes(ha)

sp1=subplot(1,2,1);
set(gca,...
    'Position',[.12 .2 .35 .7],...
    'XLim',[0 te],'XTick',[0:te:te],...
    'YLim',[-.5 1.5],'YTick',[],...
    'Box','on',...
    'NextPlot','add');
xachs1=[0 te]; xachs2=[0 0];
yachs1=[0 0]; yachs2=[-1 2];
plot(xachs1,xachs2,'k',yachs1,yachs2,'k')
xlabel('\itt \rightarrow')
ylabel('\itu_{\rme} \rightarrow')
grid on

sp2=subplot(1,2,2);
set(gca,...
    'Position',[.57 .2 .35 .7],...
    'XLim',[0 te],'XTick',[0:te:te],...
    'YLim',[-.5 1.5],'YTick',[],...
    'Box','on',...
    'NextPlot','add');
xachs1=[0 te]; xachs2=[0 0];
yachs1=[0 0]; yachs2=[-1 2];
plot(xachs1,xachs2,'k',yachs1,yachs2,'k')
xlabel('\itt \rightarrow')
ylabel('\itu_{\rmC} \rightarrow')
grid on


for i=1:2

    if i==1, tstep=t0;    line='k-';  end
    if i==2, tstep=t0+tV; line='k--';  end
   
    if (i==2)&(tV>1)
        T1=3*T1;
    end
    
    opts=simset('Solver','ode45',...
        'InitialState',[],...
        'MaxStep',0.05);

    [t,x,y]=sim('s0203',[0 te],opts);

    axes(sp1);  % axes zu current axes machen
    plot(t,y(:,1),line,'linewidth',1.5)
    axes(sp2);
    plot(t,y(:,2),line,'linewidth',1.5)

    pause(1)
end


