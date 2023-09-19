%  m0435.m    (Für MATLAB/SIMULINK R2007b)
%
%  Dreipunkt-Regler mit verzögerter Rückführung 
%
%  Bild 4.35
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0435.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%    edach  Sprunghöhe der Regeldifferenz
%               im Bereich    -.2  < edach <  1.2 ,
%
%    ean und eab<ean    An- bzw. Abschaltschwelle 
%               im Bereich    .1  < ean, eab <  1.2 ,
%
%    Yh    Stellbereich (ymin=0, ymax=Yh)
%               im Bereich    .1  < Yh <  10 ,
%
%    Kpr   P-Beiwert der stetigen Rückführung
%               im Bereich  .1  < Kpr <  10 ,
%
%    Tr    Zeitkonstante der stetigen Rückführung
%               im Bereich    .1  < Tr <  3 ,
%
%    Ki    I-Beiwert des I-Glieds (z.B. E-Motor)
%               im Bereich    -.2 < Ki <  1.3 ,
%
%    te    Simulationsdauer
%
% ########################################################
clear

   edach=1.2;       % edach=1.2

   ean=.8;          % ean=.8
   eab=.3;          % eab=.3
   Yh=1;            % Yh=1
   Kpr=1.4;         % Kpr=1.4 
   Tr=.5;           % Tr=.5
   
   Ki=1;            % Ki=1
        
   te=3;            % te=3
    
% ########################################################

close all
fonts=8;


% Koordinatenachsen dimensionieren
Dxtick=1;
x_ampl=[-3 1.5];
y_ampl=[-.2 1.5];

t0A=-.5;      % Beginn der t-Achse in den Grafiken
teE=te;       % Ende der t-Achse in den Grafiken
te=te-t0A;    %  Simulationsintervallanpassung

figure(1)
set(gcf,'Units','normal','Position',[.6 .3 .3 .5], ...
    'NumberTitle','off','MenuBar','fig',...
    'Name',' Bild 4.35: Dreipunktregler mit verzögerter Rückführung und I-Glied');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)


% Simulationsparameter
opts=simset('Solver','ode45',...
    'InitialState',[],...
    'MaxStep',.01);


% Simulation:

[t,x,y]=sim('s0435',[0 te],opts);

t=t0A+t;   % Sprünge und -antworten in Diagrammen um 1 nach links

figure(1)
axes('Position',[.13 .12 .8 .8])
set(gca,...
    'FontSize',fonts,...
    'xlim',[t0A teE],...
    'xtick',[-10:Dxtick:teE],...
    'ylim',x_ampl,...
    'ytick',[-10:.5:10]);
xlabel('t \rightarrow');
ylabel('e, y \rightarrow')
grid off;
hold on
box on

tachs1=[t0A te]; tachs2=[ 0 0 ];
zachs1=[ 0 0]; zachs2=[-10 10];
plot(tachs1,tachs2,'k',zachs1,zachs2,'k')

if edach<0,
    Yh=-Yh;
    ean=-ean;
    eab=-eab;
end
yrmax=Kpr*Yh;


plot([0 te],[ean ean],'k-.',zachs1,zachs2,'k')
plot([0 te],[eab eab],'k-.',zachs1,zachs2,'k')

plot(t,y(:,1),'k','linewidth',1)  % edach

% Ohne Rückführung
plot(t,y(:,6),'k:','linewidth',1)  % yr (frei)
yrab=edach-y(:,6);
plot(t,yrab,'k:','linewidth',1)   % edach-yr


% Mit Rückführung
plot(t,y(:,5),'k','linewidth',2)  % eschlange
y(:,3)=.5*y(:,3)-1;   % yR
plot(t,y(:,3),'k','linewidth',2)

y(:,7)=y(:,7)-3;
plot(t,y(:,7),'k','linewidth',2)  % y 

T1auf=Tr;   % Mittlere Stellgrösse = PI
T1ab=Tr;
tEI=T1auf*log(yrmax/(yrmax-edach+eab));
tE=T1auf*log((yrmax-edach+ean)/(yrmax-edach+eab));
tA=T1ab*log((edach-eab)/(edach-ean));
Kpr=(tE/(tE+tA))*Yh*Ki*tA*((tEI/tE)-.5)/edach;
Tn=tA*((tEI/tE)-.5);
t=[0:.1:te];
yquer=Kpr*edach*(1+t/Tn);
yquer=yquer-3;
plot(t,yquer,'k','linewidth',1)  % y


