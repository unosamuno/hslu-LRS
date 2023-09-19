%  m0803.m     (Matlab/Simulink R2007b)
%
%  Bild 8.3 b
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
%  Sprunghöhe udach im Bereich  0.5 < udach < 2.
%
%   --->  s.u. im Programmfragment aus Beispiel 8.1
%
% ########################################################
clear



% ########################################################

menu='none';  % none oder fig
close all
fonts=8; 

%  Programmfragment aus Beispiel 8.1:
T1=0.1;   
T=0.05;   
a1=-exp(-T/T1); b1= 1+a1;  
ke=10;    
udach=2;                       % hier udach ändern
uek=udach*ones(1,ke+1);
uck(1)=0; 
for k=1:ke
    uck(k+1)= -a1*uck(k) + b1*uek(k);  % Ohne Strichpunkt:
                          %  Tabelle Bild 8.3, Spalte uc,k
end
k=0:ke;
% plot(k,uck,'x')

% Ende Programmfragment -----------------

% Der folgende Programmteil bereitet die grafische Darstellung
% der Ergebnisse so auf, wie sie Bild 8.3b zeigt:

figure(1)
set(gcf,'Units','normal','Position',[.5 .5 .5 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 8.3b');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.4,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes     

subplot(2,1,1)
kachs1=[-2 ke]; kachs2=[0 0];
fachs1=[0 0]; fachs2=[-.5 2.5];
plot(kachs1,kachs2,'k',fachs1,fachs2,'k')
grid on, hold on
set(gca,'FontSize',fonts,...
        'XLim',[-2 ke],'YLim',[-0.5 2.5],...
    'XTick',[-2:10],'YTick',[-.5:.5:2.5]);
plot(k,uek,'x','Linew',2)
kneg1=[-2 -1]; kneg2=[ 0 0];
plot(kneg1,kneg2,'x','LineW',2)
xlabel('k')
ylabel('u_{e,k}')

subplot(2,1,2)
kachs1=[-2 ke]; kachs2=[0 0];
fachs1=[0 0]; fachs2=[-.5 2.5];
plot(kachs1,kachs2,'k',fachs1,fachs2,'k')
grid on, hold on
set(gca,'FontSize',fonts,...
        'XLim',[-2 ke],'YLim',[-0.5 2.5],...    
'XTick',[-2:10],'YTick',[-.5:.5:2.5]);
plot(k,uck,'x','Linew',2)
kneg1=[-2 -1]; kneg2=[ 0 0];
plot(kneg1,kneg2,'x','LineW',2)
xlabel('k')
ylabel('u_{c,k}')
