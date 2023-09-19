%  m0512.m      (Matlab/Simulink R2007b)
%
%  Bild 5.12
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  keine
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%  Kpr   P-Beiwert des Reglers im Bereich  1 < Kpr < 5
%
%
% ########################################################
clear

       Kpr=5.;       % Kpr=5

% ########################################################

menu='none';  % none oder fig
close all
fonts=8; 

% Gs  Strecke
Kps=1;
T2=sqrt(2);
T1=3;
s=tf('s');
Gs=Kps/(T2^2*s^2+T1*s+1)
szae=Gs.num{1};
snen=Gs.den{1};
%d=T1/(2*T2);

% Gr  Regler
Tn=0.4;
Gr=Kpr*(1+1/(Tn*s));
rzae=Gr.num{1};
rnen=Gr.den{1};

%  Go  offener Kreis
Go=Gr*Gs;
ozae=Go.num{1};
onen=Go.den{1};



% Bode-Diagramm:
figure(1)
set(gcf,'Units','normal','Position',[.5 .2 .5 .5], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 5.12');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.4,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes  

w=logspace(-1,2,200);
[sbetr,sphas,w]=bode(szae,snen,w);
[rbetr,rphas,w]=bode(rzae,rnen,w);
[obetr,ophas,w]=bode(ozae,onen,w);

subplot(2,1,1)
sbetr=20*log10(sbetr);
rbetr=20*log10(rbetr);
obetr=20*log10(obetr);
semilogx(w,sbetr,'g',w,rbetr,'m',w,obetr,'b');
grid on; hold on
dBachs=[-5:1:5]*20;
phachs=[-5:1:5]*90;
set(gca,'FontSize',fonts,'YTick',dBachs);
axis([0.1 100 -40 50])
title('Bode-Diagramm: G_O blau, G_S grün, G_R magenta')
xlabel('\omega (rad/s) \rightarrow')
ylabel('| G |_{dB} \rightarrow')
db1=[.1 100]; db2=[ 0 0 ];
plot(db1,db2,'k')

subplot(2,1,2)
semilogx(w,sphas,'g',w,rphas,'m',w,ophas,'b')
grid on, hold on
set(gca,'FontSize',fonts,'YTick',phachs);
axis([0.1 100 -200 10])
grd1=[.1 100]; grd2=[ -180 -180 ];
plot(grd1,grd2,'k')
grd1=[.1 100]; grd2=[ 0 0 ];
plot(grd1,grd2,'k')
xlabel('\omega (rad/s) \rightarrow')
ylabel('/\_G \rightarrow')
