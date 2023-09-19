%  m0504.m     (Matlab/Simulink R2007b)
%
%  Zu Bild 5.4 und 5.5a
%  Mann/Schiffelgen/Froriep,
%  Einf�hrung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, M�nchen, 2009
%  ISBN 978-3-446-41765-6
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%  Versuchen Sie x(t)=xe(t) zu erzielen, indem Sie omega und
%  die Reglerverst�rkung Kpr ver�ndern. 
%  (In der Go-Ebene bedeutet das, den roten Punkt
%  an die Stelle Go=-1 zu bringen, Bild 5.5)
%
%  omega  Frequenzwerte im Bereich von  0.4 <  omega  <  2 
%
%  Kpr    Reglerverst�rkung im Bereich von 1  <  Kpr  <  5 
%
%  L�sung: omega=.725 und Kpr=2.9
%
% ########################################################
clear

       omega=.5;           %  omega=.5

       Kpr=2;              %  Kpr=2
       
% ########################################################

fonts=8; 
close all

% Strecke:
Kps=1; Ts1=1; Ts2=1; Ts3=1; Ts4=1; Ts5=1;
s=tf('s');
Gs=Kps/(Ts1*s+1)^5;
szae=Gs.num{1};
snen=Gs.den{1};

% P-Regler:
Gr=tf([Kpr],[1]);
rzae=Gr.num{1};
rnen=Gr.den{1};

% Offener Kreis:
Go=Gr*Gs;



% Sinusantwort:
figure(1)
set(gcf,'Units','normal','Position',[.55 .55 .43 .35], ...
    'NumberTitle','off','MenuBar','None',...
    'Name',' Zu Bild 5.4'); 
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

te=20;
XNullX=[0 te]; XNullY=[0 0];
YNullX=[0 0];  YNullY=[-1.5 1.5];
plot(XNullX,XNullY,'k',YNullX,YNullY,'k');

set(gca,'FontSize',fonts,...
    'Position',[.1 .15 .8 .7],...
    'XLim',[0 te],'YLim',[-1.5 1.5],...
    'XTick',[0:5:te],'YTick',[-1.5:.5:1.5]);

grid on, hold on
xlabel('\rm t');
title('\rm Sinusanregung und Sinusantwort am aufgetrennten Regelkreis'); 

% Sinusanregung und -antwort
[betrag,phase,omega]=bode(Go,omega);
phase=phase*pi/180;
Dt=te/100; 
t=0:Dt:te;
xe=1*sin(omega*t);
if phase<0
    x=-betrag*sin(omega*t+phase);
else
    x=-betrag*sin(omega*t-phase);
end
SinusantwHandle=plot(t,xe,'b',t,x,'r');

% Legende
GrafObjMitLegende=[SinusantwHandle];
LegendHandle=legend(GrafObjMitLegende,...
    'x_e(t) Sinussignal vom Sinusgenerator',...
    'x(t)   Sinusantwort',3);
set(LegendHandle,'Fontsize',8)



% Ortskurvenpunkt:
figure(2)
set(gcf,'Units','normal','Position',[.55 .07 .3 .4], ...
    'NumberTitle','off','MenuBar','None',...
    'Name',' Zu Bild 5.5a'); 
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes

reX=[-2 1]; reY=[ 0 0];
imX=[0 0]; imY=[ -2 1];
plot(reX,reY,'k',imX,imY,'k');

set(gca,'FontSize',fonts,...
    'Position',[.15 .15 .75 .75],...
    'XLim',[-2 1],...
    'XTick',[-2:2],...
    'YLim',[-2 1],...
    'YTick',[-2:2]);

title('\rm G_O-Ebene');
xlabel('\rm Re\{G_O\}');
ylabel('\rm Im\{G_O\}');
grid on, hold on

% Kritischer Punkt (-1)
KritPunktHandle=plot(-1,0,'rx','MarkerSize',12);
text(-1,0,['\rm G_O=-1'],...
    'VerticalAlign','bottom',...
    'HorizontalAlignment','right',...
    'fonts',8)

% Frequenzpunkt
[re3,im3,w]=nyquist(Go,omega);
re=squeeze(re3);  
im=squeeze(im3);
OmegaHandle=plot(re(:,1),im(:,1),'r.','MarkerSize',8);
omegastring=num2str(omega);
Kprstring=num2str(Kpr);
text(re,im,['G_O(j ',omegastring,'), K_{PR}=',Kprstring],...
    'VerticalAlign','top',...
    'HorizontalAlignment','left',...
    'fonts',8)

% Legende
GrafObjMitLegende=[OmegaHandle, KritPunktHandle];
LegendHandle=legend(GrafObjMitLegende,...
    'G_O(j\omega) f�r ausgew. Frequenzwert',...
    'Kritischer Punkt G_O=-1',3);
set(LegendHandle,'Fontsize',8)








