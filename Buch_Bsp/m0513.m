%  m0513.m     (Matlab/Simulink R2007b)
%
%  Bild 5.13
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
%  Tt  Totzeit im Bereich  .5 < Tt < 5
%        (Bei Tt=3.9 ist die Phasenreserve Null) 
%
% ########################################################
clear


     Tt=1;     %  Tt=1


% ########################################################

menu='none';  % none oder fig
close all
fonts=8;        % Schriftgröße auf Grafiken


%  Gs
Kps=.8;
T1=10;
s=tf('s');
Gs=Kps/(T1*s+1)*exp(-Tt*s);
Gs=pade(Gs,3);   
szae=Gs.num{1};
snen=Gs.den{1};

% Gr
Kpr=5;
Tn=10;
Gr=Kpr*(1+1/(Tn*s));
rzae=Gr.num{1};
rnen=Gr.den{1};

% Go
Go=Gr*Gs;
ozae=Go.num{1};
onen=Go.den{1};


% Bode-Diagramm:
figure(1)
set(gcf,'Units','normal','Position',[.5 .2 .5 .5], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 5.13');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes 

wmin=0.001; wmax=100;
w=logspace(log10(wmin),log10(wmax),200);

[sbetr,sphas,w]=bode(szae,snen,w);
[rbetr,rphas,w]=bode(rzae,rnen,w);
[obetr,ophas,w]=bode(ozae,onen,w);

[tzae,tnen]=pade(Tt,6);   % nur die Totzeit  
[tbetr,tphas,w]=bode(tzae,tnen,w);


dBachs=[-5:5]*20;
phachs=[-5:5]*90;

subplot(2,1,1)
sbetr=20*log10(sbetr);
tbetr=20*log10(tbetr);
rbetr=20*log10(rbetr);
obetr=20*log10(obetr);
semilogx(w,sbetr,'g',w,rbetr,'m',w,obetr,'b')
grid on, hold on
set(gca,'FontSize',fonts,'YTick',dBachs);
axis([wmin wmax -40 60])
title('Bode-Diagramm: G_O blau, G_{S1} grün, G_{S2} cyan, G_R magenta')
xlabel('\omega (rad/s) \rightarrow')
ylabel('| G |_{dB} \rightarrow')
db1=[.1 100]; db2=[ 0 0 ];
plot(db1,db2,'k')
semilogx(w,tbetr,'c--')

subplot(2,1,2)
semilogx(w,sphas,'g',w,tphas,'c--',w,rphas,'m',w,ophas,'b')
grid on, hold on
set(gca,'FontSize',fonts,'YTick',phachs);
axis([wmin wmax -200 10])
semilogx(w,tphas,'c--')
grd1=[.001 100]; grd2=[ -180 -180 ];
plot(grd1,grd2,'w')
grd1=[.001 100]; grd2=[ 0 0 ];
plot(grd1,grd2,'k')
xlabel('\omega (rad/s) \rightarrow')
ylabel('/\_G \rightarrow')
