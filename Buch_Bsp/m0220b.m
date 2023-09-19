%  m0220b.m     (Matlab/Simulink R2007b)
%
%  Bild 2.20b
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0220a.mdl
%
%  (c) 5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   Tankquerschittsfläche A0 in cm^2
%                            im Bereich  20 < A0 < 100
%
%   Pumpenkonstante cP in (g/s)/V
%                            im Bereich  1  < cP <  2.5
%
%   Zeitpunkt Aspt der (sprunghaften) Änderung von Aab
%                            im Bereich  200  < Aspt < 600
%
%   Wert von Aab vor dem Zeitpunkt Aspt in mm^2
%                            im Bereich  0  < Aabv < 15
%
%   Wert von Aab nach dem Zeitpunkt Aspt in mm^2
%                            im Bereich  0  < Aabv < 15
%
% ########################################################
clear all

      A0=30.;       % Voreinstellung  A0=30.
      
      cP=2.;        % Voreinstellung  cP=2.

      Aspt=500.;    % Voreinstellung  Aspt=500.

      Aabv=6.;      % Voreinstellung  Aabv=6.

      Aabn=9.;      % Voreinstellung  Aabn=9.


% ########################################################

clc
close all
fonts=8;

% Streckendaten:
rho=1e3;     %  kg/m^3
g=9.81;      %  m/s^2

% Umrechnung in SI-Einheiten
A=1e-4*A0;   %  cm^2 in m^2
cP=1e-3*cP;  %  (g/s)/V in (kg/s)/V
Aabv=1e-6*Aabv;  % mm^2 in m^2
Aabn=1e-6*Aabn;  % mm^2 in m^2

c1=sqrt(2*g)/A;  
c2=cP/(rho*A);

te=900;


opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',1.0);
[t,x,y]=sim('s0220a',[0 te],opts);


figure(1)
set(gcf,'Units','normal','Position',[.53 .1 .45 .8], ...
    'NumberTitle','off','MenuBar','none',...
    'Name',' Bild 2.20b');
ha=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.2,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes(ha)

subplot(3,1,1)
plot(t,y(:,1),'k','LineW',2)
grid on
set(gca,'FontSize',fonts,...
    'Position',[.15 .75 .75 .2],...
    'XTick',[0:100:1000],'YTick',[0:2:4] );
axis([0 900 0 5]);
title('Füllstandstrecke')
xlabel('t/s \rightarrow'); 
ylabel('u_P / V \rightarrow');

subplot(3,1,2)
y(:,3)=1e6*y(:,3);  % m^2 in mm^2
plot(t,y(:,3),'k','LineW',2)
grid on
set(gca,'FontSize',fonts,...
    'Position',[.15 .43 .75 .2],...
    'XTick',[0:100:1000]);
axis([0 900 0 15]);
xlabel('t/s \rightarrow'); 
ylabel('A_{ab} / mm^2 \rightarrow');

subplot(3,1,3)
y(:,2)=1e2*y(:,2);  % m in cm
plot(t,y(:,2),'k','LineW',2)
grid on
set(gca,'FontSize',fonts,...
    'Position',[.15 .11 .75 .2],...
    'XTick',[0:100:1000]);
axis([0 900 0 15]);
xlabel('t/s \rightarrow'); 
ylabel('h / cm \rightarrow');


