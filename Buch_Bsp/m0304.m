%  m0304.m     (Matlab/Simulink R2007b)
%
%  Bild 3.4 
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0304.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
% ########################################################
clear




% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

s=tf('s');


% Integrationsschleife:
tspr=0.01;

te=5;

figure(1)
set(gcf,'Units','normal','Position',[.65 .7 .3 .2], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 3.4a  Sprungfunktion');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.7,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes


set(gca,'FontSize',fonts,...
    'XLim',[0 te],...
    'XTick',[0:1:60],...
    'YLim',[-.5 1.5],...
    'YTick',[-60:1:140],...
    'NextPlot','add',...
    'Box','on');
tachs1=[0 te]; tachs2=[0 0];
yachs1=[tspr tspr]; yachs2=[0 2];
plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
tGGx=[-1 0]; tGGy=[0 0];
plot(tGGx,tGGy,'k','linewidth',1.5)
grid off
xlabel('t  \rightarrow')
ylabel('y  \rightarrow')

figure(2)
set(gcf,'Units','normal','Position',[.65 .4 .3 .2], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 3.4b  Strecken mit Ausgleich');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.7,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes


set(gca,'FontSize',fonts,...
    'XLim',[0 te],...
    'XTick',[0:1:60],...
    'YLim',[-2 2],...
    'YTick',[-10:1:10],...
    'NextPlot','add',...
    'Box','on');
tachs1=[-.1 te]; tachs2=[0 0];
yachs1=[tspr tspr]; yachs2=[-2 2];
plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
tGGx=[-1 0]; tGGy=[0 0];
plot(tGGx,tGGy,'k','linewidth',1.5)
grid off
xlabel('t  \rightarrow')
ylabel('x  \rightarrow')


figure(3)
set(gcf,'Units','normal','Position',[.65 .1 .3 .2], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 3.4c  Strecken ohne Ausgleich');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.7,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

set(gca,'FontSize',fonts,...
    'XLim',[0 te],...
    'XTick',[0:1:60],...
    'YLim',[0 6],...
    'YTick',[-10:2:10],...
    'NextPlot','add',...
    'Box','on');
tachs1=[-.1 te]; tachs2=[0 0];
yachs1=[tspr tspr]; yachs2=[-6 6];
plot(tachs1,tachs2,'k',yachs1,yachs2,'k')
tGGx=[-1 0]; tGGy=[0 0];
plot(tGGx,tGGy,'k','linewidth',1.5)
grid off
xlabel('t  \rightarrow')
ylabel('x  \rightarrow')


% Strecken mit Ausgleich
for i=1:4
    if i==1, G=1.3/(.5*s+1); end
    if i==2, G=1/(.4*s+1)^4; end
    if i==3, G=-1/(.5*s+1)/(.5*s+1); end
    T=.8;
    om=2*pi/T;
    d=.15;
    if i==4, G=.7/((1/om^2)*s^2+(2*d/om)*s+1); end

    zae=G.num{1};
    nen=G.den{1};

    opts=simset('Solver','ode45',...
        'InitialState',[],...
        'MaxStep',.1);
    [t,x,y]=sim('s0304',[0 te],opts);

    if i==1
        figure(1)
        ysprungx=[.03 .03]; ysprungy=[0 1];
        plot(ysprungx,ysprungy,'k','linewidth',1.5)
        plot(t,y(:,1),'k-','linewidth',1.5)    %  y
    end

    figure(2)
    plot(t,y(:,2),'k-','linewidth',1.5)    %  x
    hold on
end



% Strecken ohne Ausgleich
for i=1:3

    if i==1, G=2/s; end
    T=1;
    om=2*pi/T;
    d=.04;
    if i==2, G=2/s/(.2*s+1)^2/((1/om^2)*s^2+(2*d/om)*s+1); end
    if i==3, G=2/s/(.5*s+1)^4; end

    zae=G.num{1};
    nen=G.den{1};

    opts=simset('Solver','ode45',...
        'InitialState',[],...
        'MaxStep',.1);
    [t,x,y]=sim('s0304',[0 te],opts);

    figure(3)
    plot(t,y(:,2),'k-','linewidth',1.5)    %  x
end









