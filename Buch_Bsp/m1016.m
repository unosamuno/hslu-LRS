%  m1016.m     (Matlab/Simulink R2007b)
%
%  Bild 10.16 a bis c
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  keine
%
%  (c)5.7.09  R.Froriep
%
% ........................................................
%
%  Hinweis:
%    
%     Dieses Programm ist nur zusammen mit der
%
%     Fuzzy Logic Toolbox  lauffähig
%
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   
%
%
% ########################################################
clear




% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

% Fuzzy-Regler
fuell=newfis('fuell');  % Neues FIS


% Def. Eingangsgrößen
emax=1;  % Max.Betrag
fuell=addvar(fuell,'input','Regeldifferenz',[-emax emax]);

% Zugehörigkeitsfunktionen ("Werte der Kenngröße e")
% Volle Überlappung
fuell=addmf(fuell,'input',1,'N','trapmf',[-emax -emax -emax/2 0]); 
fuell=addmf(fuell,'input',1,'NU','trimf',[-emax/2 0 emax/2]); 
fuell=addmf(fuell,'input',1,'P','trapmf',[0 emax/2 emax emax]); 

% 50% Überlappung
%  fuell=addmf(fuell,'input',1,'N','trapmf',[-emax -emax -3*emax/4 -emax/4]); 
%  fuell=addmf(fuell,'input',1,'NU','trimf',[-emax/2 0 emax/2]); 
%  fuell=addmf(fuell,'input',1,'P','trapmf',[ emax/4 3*emax/4 emax emax]); 

% Keine Überlappung
%  fuell=addmf(fuell,'input',1,'N','trapmf',[-emax -emax -emax -emax/2]); 
%  fuell=addmf(fuell,'input',1,'NU','trimf',[-emax/2 0 emax/2]); 
%  fuell=addmf(fuell,'input',1,'P','trapmf',[ emax/2 emax emax emax]); 


% Def. Stellgröße
Dupmax=1; Dupmin=-Dupmax;
fuell=addvar(fuell,'output','Stellgröße',[2*Dupmin 2*Dupmax]);

% Zugehörigkeitsfunktionen

% Ohne Randerweiterung
fuell=addmf(fuell,'output',1,'N','trimf',[Dupmin Dupmin/2 0]); 
fuell=addmf(fuell,'output',1,'NU','trimf',[Dupmin/2 0 Dupmax/2]); 
fuell=addmf(fuell,'output',1,'P','trimf',[0 Dupmax/2 Dupmax]); 

% Regeln
%  Regel1='if Regeldifferenz is negativ then Pumpenspannung is niedrig';
%  Regel2='if Regeldifferenz is OK then Pumpenspannung is mittel';
%  Regel3='if Regeldifferenz is positiv then Pumpenspannung is hoch';
%  regel=parsrule(dd,ruleTxt,'verbose');

Regelliste=[
    1 1 1 1  
    2 2 1 1
    3 3 1 1];
fuell=addrule(fuell,Regelliste);


figure(1)
eachs=[-10:10]*.2; uPachs=[-10:10]*.2; zfachs=[0:10]*.2;
set(gcf,'Units','normal','Position',[.53 .52 .45 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 10.16a und b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

subplot(2,1,1)
plotmf(fuell,'input',1), grid
set(gca,'FontSize',fonts,...
    'Position',[.12 .63 .8 .3],...
    'XLim',[-emax emax],...
    'YLim',[-.1 1.1],...
    'XTick',eachs,...
    'YTick',zfachs);
xlabel('e \rightarrow')
ylabel('\mu \rightarrow')

subplot(2,1,2)
plotmf(fuell,'output',1), grid
set(gca,'FontSize',fonts,...
    'Position',[.12 .15 .8 .3],...
    'XLim',[Dupmin Dupmax],...
    'YLim',[-.1 1.1],...
    'XTick',uPachs,...
    'YTick',zfachs);
xlabel('y \rightarrow')
ylabel('\mu \rightarrow')


figure(2)
set(gcf,'Units','normal','Position',[.53 .06 .45 .38], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 10.16c');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

null=[0 0]; xnull=[-emax emax]; ynull=[Dupmin Dupmax];
plot(xnull,null,'k-',null,ynull,'k-'), hold on, grid on
[x,y,z]=gensurf(fuell,1,1,100);
plot(x,z)
set(gca,'FontSize',fonts,...
    'Position',[.2 .15 .8 .8],...
    'XLim',[-emax emax],...
    'YLim',[Dupmin Dupmax],...
    'XTick',eachs,...
    'YTick',uPachs,...    
    'DataAspectRatio',[1 1 1]);
xlabel('e \rightarrow')
ylabel('y \rightarrow')

