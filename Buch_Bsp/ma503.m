%  ma503.m     (Matlab/Simulink R2007b)
%
%  Bild A.5.3
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
% 
%
% ########################################################
clear



% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

K=12.5;
T1z=0.4;
T1n=3;
T2=sqrt(2);
%d=T1n/(2*T2)
s=tf('s');
Go=K*(T1z*s+1)/s/(T2^2*s^2+T1n*s+1);
zae=Go.num{1};
nen=Go.den{1};


figure(1)
set(gcf,'Units','normal','Position',[.55 .4 .4 .5], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild A.5.3');
ha1=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes(ha1);

w=logspace(-2,2,100);

[betr,phas,w]=bode(zae,nen,w);

subplot(2,1,1)
betr=20*log10(betr);
semilogx(w,betr,'b'), grid on, hold on
dBachs=[-5:5]*20; phachs=[-5:5]*90;
set(gca,'FontSize',fonts,...
    'XLim',[0.01 100],'YLim',[-40 60],...
    'YTick',dBachs);
om1=[0.01 100]; om2=[ 0 0]; plot(om1,om2,'k')
xlabel('\omega/(rad s^{-1})')
ylabel('|G(j\omega)|_{dB} / dB')

subplot(2,1,2)
semilogx(w,phas,'b'), grid on, hold on
set(gca,'FontSize',fonts,...
    'XLim',[0.01 100],'YLim',[-225 90],...
    'YTick',phachs);
om1=[0.01 100]; om2=[ 0 0]; plot(om1,om2,'k')
xlabel('\omega/(rad s^{-1})')
ylabel('/\_G(j\omega) / Grad')

