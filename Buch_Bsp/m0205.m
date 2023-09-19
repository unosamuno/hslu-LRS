%  m0205.m     (Matlab/Simulink R2007b)
%
%  Bild 2.5
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0205.mdl
%
%  (c) 5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%  ue1amp   Amplitude von Eingangsspannung ue1
%  ue2amp   Amplitude von Eingangsspannung ue2
%  ue2par   Zeitparameter von ue2
%
% ########################################################
clear all
%  Eingabefeld mit Angabe der Voreinstellungen  

     ue1amp=1.;                  % ue1amp=1
     ue2amp=-.5;                 % ue2amp=-.5
     ue2par = .3;                % ue2par=.3
     
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
te=1.2;


figure(1)
set(gcf,'Units','normal','Position',[.45 .65 .5 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.5a');
ha=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes(ha)


sp1=subplot(1,2,1);
set(gca,...
    'Position',[.12 .2 .35 .7],...
    'XLim',[0 te],'XTick',[],...
    'YLim',[-1 2],'YTick',[-1:3:2],...
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
    'XLim',[0 te],'XTick',[],...
    'YLim',[-1 2],'YTick',[-1:3:2],...
    'Box','on',...
    'NextPlot','add');
xachs1=[0 te]; xachs2=[0 0];
yachs1=[0 0]; yachs2=[-1 2];
plot(xachs1,xachs2,'k',yachs1,yachs2,'k')
xlabel('\itt \rightarrow')
ylabel('\itu_{\rmC} \rightarrow')
grid on


figure(2)
set(gcf,'Units','normal','Position',[.45 .3 .5 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.5b');
ha=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes(ha)

sp21=subplot(1,2,1);
xachs1=[0 te]; xachs2=[0 0];
yachs1=[0 0]; yachs2=[-1 2];
plot(xachs1,xachs2,'k',yachs1,yachs2,'k')
grid on, hold on
set(gca,...
    'Position',[.12 .2 .35 .7],...
    'XLim',[0 te],'XTick',[],...
    'YLim',[-1 2],'YTick',[-1:3:2])
xlabel('\itt \rightarrow')
ylabel('\itu_{\rme} \rightarrow')

sp22=subplot(1,2,2);
xachs1=[0 te]; xachs2=[0 0];
yachs1=[0 0]; yachs2=[-1 2];
plot(xachs1,xachs2,'k',yachs1,yachs2,'k')
grid on, hold on
set(gca,...
    'Position',[.57 .2 .35 .7],...
    'XLim',[0 te],'XTick',[],...
    'YLim',[-1 2],'YTick',[-1:3:2])
xlabel('\itt \rightarrow')
ylabel('\itu_{\rmC} \rightarrow')



for i=1:2

    if i==1, ue1=ue1amp; ue2=0;      line='k-';  end
    if i==2, ue1=0;      ue2=ue2amp; line='k--';  end

    opts=simset('Solver','ode45',...
        'InitialState',[],...
        'MaxStep',0.005);

    [t,x,y]=sim('s0205',[0 te],opts);

    axes(sp1);  % axes zu current axes machen
    plot(t,y(:,1),line,'linewidth',1)

    axes(sp2);
    plot(t,y(:,2),line,'linewidth',1)

    pause(.5)
end



% Überlagerung
ue1=ue1amp; ue2=ue2amp;

[t,x,y]=sim('s0205',[0 te],opts);

figure(2)
axes(sp21);
plot(t,y(:,1),'k','linewidth',1)
axes(sp22);
plot(t,y(:,2),'k','linewidth',1)


