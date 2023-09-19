%  m0232.m     (Matlab/Simulink R2007b)
%
%  Bild 2.32
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0232.mdl
%
%  (c) 5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   T1    Zeitkonstante der nichtschwingenden
%         Sprungantwort im Bereich  1 < T1 <  3
%
%   d     Dämpfungsgrad der schwingenden
%         Sprungantwort im Bereich  0 < d <  1
%
% ########################################################
clear

   T1 = 2;        % T1=2       
   d  = .5;       % d=.5      

% ########################################################

menu='none';  % none oder fig
close all
fonts=9; 

% Nichtschwingende Sprungantwort (P-Tn-Glied)
%---------------------------------------------
s=tf('s');
Gs1=3/(T1*s+1)^3;
zae1=Gs1.num{1};
nen1=Gs1.den{1};

% Schwingende Sprungantwort (P-T2-Glied)
%---------------------------------------------
Kp=4; wo=.8; %d=0.5;
T1=2*d*wo;  T2=1/wo;
Gs2=Kp/(T2^2*s^2+T1*s+1);
zae2=Gs2.num{1}
nen2=Gs2.den{1}


figure(1)
set(gcf,'Units','normal','Position',[.55 .5 .42 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.32');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

tauend=4*2*pi; 

opts=simset('Solver','ode45',...
      'InitialState',[],...
      'MaxStep',.1);
[t,x,y]=sim('s0232',[0 tauend],opts);

t1=[-1 tauend]; t2=[0 0]; plot(t1,t2,'k'), hold on;
plot(t,y(:,1),'b',t,y(:,2),'b',t,y(:,3),'b');
set(gca,'FontSize',fonts,...
    'Position',[.15 .17 .75 .7]);
set(gca,'XTickLabel',[],'YTickLabel',[]);
axis([-1 tauend 0 6])
title('Sprungantworten schwingend / nichtschwingend')
xlabel('t \rightarrow')
ylabel('u, v \rightarrow')

