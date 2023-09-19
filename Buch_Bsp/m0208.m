%  m0208.m     (Matlab/Simulink R2007b)
%
%  Bild 2.8
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0208.mdl
%
%  (c) 5.7.09  R.Froriep
%
%
% ########################################################
%
%  Variations-Empfehlungen:
%       uP       0 < uP < 10  (V)
%                Vektor mit konstanten Werten der Pumpen-
%                spannung uP, die
%                der Reihe nach simuliert werden und in
%                das Kennliniendiagramm eingetragen werden. 
%                
%       Aab0     3 < Aab0 < 9  (mm^2)
%                Fester Wert der Abflußventilöffnung
%                (offene Querschnittsfläche)
%   
% ########################################################
clear all
%  Eingabefeld mit Angabe der Voreinstellungen  

      uP=[0:1:9];       % uP=[2 4 6 8];        

      Aab0=6;           % Aab0=9

 % ########################################################
 clc
 close all

 % Streckendaten:
 A0=30;        % cm^2, Tankquerschnittfläche
 cP=2;         % (g/s)/V, Pumpenkonstante
 hmax=16;       % cm, Überlauf

 % Umrechnung in SI-Einheiten
 A=1e-4*A0;   %  cm^2 in m^2
 cP=1e-3*cP;  %  (g/s)/V in (kg/s)/V
 hmax=hmax*1e-2;  % cm in m
 rho=1e3;     %  kg/m^3
 g=9.81;      %  m/s^2
 c1=sqrt(2*g)/A;
 c2=cP/(rho*A);

 Aab0=Aab0*1e-6;  % mm^2 in m^2

 te=300;


 % Plotfenster Zeitdiagramme
 figure(1)
 set(gcf,'Units','normal','Position',[.4 .55 .5 .2], ...
     'NumberTitle','off','MenuBar','none',...
     'Name',' Bild 2.8c');
 ha=gca;
 axes('Position',[0 0 .5 .04],'visible','off')
 text(.01,.6,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
 axes(ha)

 sp1=subplot(1,2,1);
 xachs1=[0 te]; xachs2=[0 0];
 plot(xachs1,xachs2,'k')
 set(gca,...
     'Position',[.13 .22 .35 .7],...
     'XLim',[0 te],'XTick',[0:300:te],...
     'YLim',[0 10],'YTick',[0:10:10],...
     'Box','on',...
     'NextPlot','add');
 xlabel('\itt \rightarrow')
 ylabel('\itu_{\rmP} \rm(V) \rightarrow')
 grid on

 sp2=subplot(1,2,2);
 xachs1=[0 te]; xachs2=[0 0];
 plot(xachs1,xachs2,'k')
 set(gca,...
     'Position',[.59 .22 .35 .7],...
     'XLim',[0 te],'XTick',[0:300:te],...
     'YLim',[0 20],'YTick',[0:20:20],...
     'Box','on',...
     'NextPlot','add');
 xlabel('\itt \rightarrow')
 ylabel('\ith \rm(cm) \rightarrow')
 grid on

 % Plotfenster Lineare Kennlinie:
 figure(2)
 set(gcf,'Units','normal','Position',[.55 .2 .25 .25], ...
     'NumberTitle','off','MenuBar','none',...
     'Name',' Bild 2.8d');
 ha=gca;
 axes('Position',[0 0 .5 .04],'visible','off')
 text(.01,.7,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
 axes(ha)

 xachs1=[-2 2]; xachs2=[0 0]; yachs1=[0 0]; yachs2=[-2 2];
 plot(xachs1,xachs2,'k',yachs1,yachs2,'k')
 set(gca,...
     'Position',[.2 .25 .7 .7],...
     'XLim',[0 10],'XTick',[0:10:10],...
     'YLim',[0 20],'YTick',[0:20:20],...
     'Box','on',...
     'NextPlot','add');
 grid on
 xlabel('\itu_{\rmPK} \rm(V) \rightarrow')
 ylabel('\ith_{\rmK} \rm(cm) \rightarrow')



 % Berechnen und eintragen
 Anzahl=size(uP,2);

 for i=1:Anzahl    % Sprungantworten

     uPdach=uP(i);

     pause(.5)

     opts=simset('Solver','ode45',...
         'InitialState',[],...
         'MaxStep',.1);
     [t,x,y]=sim('s0208',[0 te],opts);

     figure(1)
     axes(sp1)
     plot(t,y(:,1),'k','linewidth',1)
     axes(sp2)
     for j=1:size(y,1)           % Überlauf
         if y(j,2)>hmax
             y(j,2)=hmax;
         end
     end
     y(:,2)=y(:,2)*1e2;  % m  in cm
     plot(t,y(:,2),'k','linewidth',1)

     % Werte für statische Kennlinie
     uPK=y(size(y,1),1);
     hK=y(size(y,1),2);
     figure(2)
     plot(uPK,hK,'xk','linewidth',1.5)

 end





