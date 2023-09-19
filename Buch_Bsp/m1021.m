%  m1021.m     (Matlab/Simulink R2007b)
%
%  Bild 10.21 b, d und e
%  Mann/Schiffelgen/Froriep,
%  Einf�hrung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, M�nchen, 2009
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
%     Fuzzy Logic Toolbox lauff�hig.
%
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%    �berlappung der drei Zugeh�rigkeitsfunktionen der
%    Regeldifferenz:
%
%           100% �berlappung:  ii=1 
%            50% �berlappung:  ii=2 
%             0% �berlappung:  ii=3 
%
% ########################################################
clear

         ii=1;     %  ii=1

% ########################################################

close all
fonts=8;

%for ii=1:2

% Fuzzy-Regler

fuell=newfis('fuell');  % Neues FIS

% Def. Eingangsgr��en
emax=1;  % Max.Betrag
fuell=addvar(fuell,'input','Regeldifferenz',[-emax emax]);

% Zugeh�rigkeitsfunktionen ("Werte der Kenngr��e e")
if ii==1 
    % Volle �berlappung
    fuell=addmf(fuell,'input',1,'N','trapmf',[-2*emax -2*emax -emax/2 0]); 
    fuell=addmf(fuell,'input',1,'NU','trimf',[-emax/2 0 emax/2]); 
    fuell=addmf(fuell,'input',1,'P','trapmf',[0 emax/2 2*emax 2*emax]); 
end

if ii==2 
    % 50% �berlappung
    fuell=addmf(fuell,'input',1,'N','trapmf',[-2*emax -2*emax -3*emax/4 -emax/4]); 
    fuell=addmf(fuell,'input',1,'NU','trimf',[-emax/2 0 emax/2]); 
    fuell=addmf(fuell,'input',1,'P','trapmf',[ emax/4 3*emax/4 2*emax 2*emax]); 
end

if ii==3
    % Keine �berlappung
    fuell=addmf(fuell,'input',1,'N','trapmf',[-2*emax -2*emax -emax -emax/2]); 
    fuell=addmf(fuell,'input',1,'NU','trimf',[-emax/2 0 emax/2]); 
    fuell=addmf(fuell,'input',1,'P','trapmf',[ emax/2 emax 2*emax 2*emax]); 
end

emax=1;  % Max.Betrag
fuell=addvar(fuell,'input','ePunkt',[-emax emax]);

% Zugeh�rigkeitsfunktionen 
if ii==1 
    % Volle �berlappung
    fuell=addmf(fuell,'input',2,'N','trapmf',[-2*emax -2*emax -emax/2 0]); 
    fuell=addmf(fuell,'input',2,'NU','trimf',[-emax/2 0 emax/2]); 
    fuell=addmf(fuell,'input',2,'P','trapmf',[0 emax/2 2*emax 2*emax]); 
end

if ii==2 
    % 50% �berlappung
    fuell=addmf(fuell,'input',2,'N','trapmf',[-2*emax -2*emax -3*emax/4 -emax/4]); 
    fuell=addmf(fuell,'input',2,'NU','trimf',[-emax/2 0 emax/2]); 
    fuell=addmf(fuell,'input',2,'P','trapmf',[ emax/4 3*emax/4 2*emax 2*emax]); 
end

if ii==3
    % Keine �berlappung
    fuell=addmf(fuell,'input',2,'N','trapmf',[-2*emax -2*emax -emax -emax/2]); 
    fuell=addmf(fuell,'input',2,'NU','trimf',[-emax/2 0 emax/2]); 
    fuell=addmf(fuell,'input',2,'P','trapmf',[ emax/2 emax 2*emax 2*emax]); 
end

% Def. Ausgangsgr��en
fuell=addvar(fuell,'output','Stellgr��e',[-1.5  1.5]);

% Zugeh�rigkeitsfunktionen
fuell=addmf(fuell,'output',1,'NB','trimf',[-1.5 -1 -.5]); 
fuell=addmf(fuell,'output',1,'NS','trimf',[-1  -0.5  0]); 
fuell=addmf(fuell,'output',1,'NU','trimf',[-0.5  0  .5]); 
fuell=addmf(fuell,'output',1,'PS','trimf',[ 0   .5   1]); 
fuell=addmf(fuell,'output',1,'PB','trimf',[ .5   1 1.5]); 

% Regeln
Regelliste=[
    1 1  1  1 1  
    1 2  2  1 1
    1 3  3  1 1  
    2 1  2  1 1
    2 2  3  1 1  
    2 3  4  1 1
    3 1  3  1 1  
    3 2  4  1 1  
    3 3  5  1 1];
fuell=addrule(fuell,Regelliste);


figure(1)
set(gcf,'Units','normal','Position',[.53 .53 .45 .42], ...
    'NumberTitle','off','MenuBar','none',...
    'Name',' Zugeh�rigkeitsfunktionen zu Bild 10.21b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

subplot(3,1,1)
plotmf(fuell,'input',1), grid
eachs=[-10:10]*.5; uPachs=[-10:10]*.5; zfachs=[0:10]*.5;
set(gca,'FontSize',fonts,...
    'Position',[.15 .77 .7 .2],...
    'XLim',[-emax emax],...
    'YLim',[-.1 1.2],...
    'XTick',eachs,...
    'YTick',zfachs);
xlabel('e \rightarrow')
ylabel('\mu \rightarrow')

subplot(3,1,2)
plotmf(fuell,'input',1), grid
set(gca,'FontSize',fonts,...
    'Position',[.15 .45 .7 .2],...
    'XLim',[-emax emax],...
    'YLim',[-.1 1.2],...
    'XTick',eachs,...
    'YTick',zfachs);
xlabel('ePunkt \rightarrow')
ylabel('\mu \rightarrow')

subplot(3,1,3)
plotmf(fuell,'output',1), grid
set(gca,'FontSize',fonts,...
    'Position',[.15 .13 .7 .2],...
    'XLim',[-1 1],...
    'YLim',[-.1 1.2],...
    'XTick',uPachs,...
    'YTick',zfachs);
xlabel('y \rightarrow')
ylabel('\mu \rightarrow')


% Kennfl�che Fuzzy-Regler
figure(2) 
set(gcf,'Units','normal','Position',[.53 .05 .45 .4], ...
    'NumberTitle','off','MenuBar','fig',...
    'Name',' Zugeh�rigkeitsfunktionen zu Bild 10.21d');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

az=10; el=15;

[X,Y,Z]=gensurf(fuell,[1 2],1,21);

mesh(X,Y,Z), hold on
D=.5; eachs=[-10:10]*D; ePachs=[-10:10]*D; yachs=[-10:10]*D; 
set(gca,'FontSize',fonts,...
    'Position',[.17 .2 .7 .7],...
    'XTick',eachs,...
    'YTick',ePachs,...
    'ZTick',yachs);
xlabel('e \rightarrow')
ylabel('eP \rightarrow')
zlabel('y \rightarrow');

view(az,el)
legend('Drehen Sie die Grafik mittels Icon "Rotate 3D"',...
    'Location','SouthOutside')

% Null-Linien
xx=[-1 1]; xy=[0 0]; xz=[0 0];
yx=[0 0]; yy=[0 -1]; yz=[0 0];
zx=[0 0]; zy=[0 0]; zz=[-1 1];
plot3(yx,yy,yz,'k',zx,zy,zz,'k') 

% Box-Umrandung x-Richtung
% bei Eins:
x1=[-1 1]; y1=[1 1]; z1=[1 1];
x2=[-1 1]; y2=[-1 -1]; z2=[1 1];
x3=[-1 1]; y3=[1 1]; z3=[-1 -1];
x4=[-1 1]; y4=[-1 -1]; z4=[-1 -1];
plot3(x1,y1,z1,'k',x2,y2,z2,'k',x3,y3,z3,'k',x4,y4,z4,'k') 

% Box-Umrandung y-Richtung
x1=[1 1]; y1=[-1 1]; z1=[1 1];
x2=[-1 -1]; y2=[-1 1]; z2=[1 1];
x3=[1 1]; y3=[-1 1]; z3=[-1 -1];
x4=[-1 -1]; y4=[-1 1]; z4=[-1 -1];
plot3(x1,y1,z1,'k',x2,y2,z2,'k',x3,y3,z3,'k',x4,y4,z4,'k') 

% Box-Umrandung z-Richtung
x1=[1 1]; y1=[1 1];   z1=[-1 1];
x2=[-1 -1]; y2=[1 1]; z2=[-1 1];
x3=[1 1]; y3=[-1 -1];   z3=[-1 1];
x4=[-1 -1]; y4=[-1 -1]; z4=[-1 1];
plot3(x1,y1,z1,'k',x2,y2,z2,'k',x3,y3,z3,'k',x4,y4,z4,'k') 

% bei Null:
% Vorderseite:
x1=[-1 1]; y1=[-1 -1]; z1=[0 0];
x2=[0 0]; y2=[-1 -1]; z2=[-1 1];
plot3(x1,y1,z1,'k',x2,y2,z2,'k') 

% R�ckseite:
x1=[-1 1]; y1=[1 1]; z1=[0 0];
x2=[0 0]; y2=[1 1]; z2=[-1 1];
plot3(x1,y1,z1,'k',x2,y2,z2,'k') 

% Rechte Seite:
x2=[1 1]; y2=[-1 1]; z2=[0 0];
plot3(x2,y2,z2,'k') 

% Linke Seite:
x2=[-1 -1]; y2=[-1 1]; z2=[0 0];
plot3(x2,y2,z2,'k') 

% Untere Seite:
x1=[0 0]; y1=[-1 1]; z1=[-1 -1];
plot3(x1,y1,z1,'k') 

% Obere Seite:
x1=[0 0]; y1=[-1 1]; z1=[1 1];
plot3(x1,y1,z1,'k') 

%end

% Kennfl�che linearer PD-Regler
figure(3)  
set(gcf,'Units','normal','Position',[.05 .05 .45 .4], ...
    'NumberTitle','off','MenuBar','fig',...
    'Name',' Zugeh�rigkeitsfunktionen zu Bild 10.21e');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

e=-1:.1:1; eP=-1:.1:1;
[E EP]=meshgrid(e,eP);
Y=0.5*(E+EP);

mesh(E,EP,Y), hold on
D=.5; eachs=[-10:10]*D; ePachs=[-10:10]*D; 
yachs=[-10:10]*D; 
set(gca,'FontSize',fonts,...
    'Position',[.17 .2 .7 .7],...
    'XTick',eachs,...
    'YTick',ePachs,...
    'ZTick',yachs);
xlabel('e \rightarrow')
ylabel('eP \rightarrow')
zlabel('y \rightarrow');

view(az,el)

% Null-Linien
xx=[-1 1]; xy=[0 0]; xz=[0 0];
yx=[0 0]; yy=[0 -1]; yz=[0 0];
zx=[0 0]; zy=[0 0]; zz=[-1 1];
%plot3(xx,xy,xz,'k',yx,yy,yz,'k',zx,zy,zz,'k') 
plot3(yx,yy,yz,'k',zx,zy,zz,'k') 

% Box-Umrandung x-Richtung
% bei Eins:
x1=[-1 1]; y1=[1 1]; z1=[1 1];
x2=[-1 1]; y2=[-1 -1]; z2=[1 1];
x3=[-1 1]; y3=[1 1]; z3=[-1 -1];
x4=[-1 1]; y4=[-1 -1]; z4=[-1 -1];
plot3(x1,y1,z1,'k',x2,y2,z2,'k',x3,y3,z3,'k',x4,y4,z4,'k') 


% Box-Umrandung y-Richtung
x1=[1 1]; y1=[-1 1]; z1=[1 1];
x2=[-1 -1]; y2=[-1 1]; z2=[1 1];
x3=[1 1]; y3=[-1 1]; z3=[-1 -1];
x4=[-1 -1]; y4=[-1 1]; z4=[-1 -1];
plot3(x1,y1,z1,'k',x2,y2,z2,'k',x3,y3,z3,'k',x4,y4,z4,'k') 

% Box-Umrandung z-Richtung
x1=[1 1]; y1=[1 1];   z1=[-1 1];
x2=[-1 -1]; y2=[1 1]; z2=[-1 1];
x3=[1 1]; y3=[-1 -1];   z3=[-1 1];
x4=[-1 -1]; y4=[-1 -1]; z4=[-1 1];
plot3(x1,y1,z1,'k',x2,y2,z2,'k',x3,y3,z3,'k',x4,y4,z4,'k') 


% bei Null:
% Vorderseite:
x1=[-1 1]; y1=[-1 -1]; z1=[0 0];
x2=[0 0]; y2=[-1 -1]; z2=[-1 1];
plot3(x1,y1,z1,'k',x2,y2,z2,'k') 

% R�ckseite:
x1=[-1 1]; y1=[1 1]; z1=[0 0];
x2=[0 0]; y2=[1 1]; z2=[-1 1];
plot3(x1,y1,z1,'k',x2,y2,z2,'k') 

% Rechte Seite:
x2=[1 1]; y2=[-1 1]; z2=[0 0];
plot3(x2,y2,z2,'k') 

% Linke Seite:
x2=[-1 -1]; y2=[-1 1]; z2=[0 0];
plot3(x2,y2,z2,'k') 

% Untere Seite:
x1=[0 0]; y1=[-1 1]; z1=[-1 -1];
plot3(x1,y1,z1,'k') 

% Obere Seite:
x1=[0 0]; y1=[-1 1]; z1=[1 1];
plot3(x1,y1,z1,'k') 

