%  m0802.m     (Matlab/Simulink R2007b)
%
%  Bild 8.2 a bis d
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
%  Bild 8.2a:
%  Sprunghöhe uehat im Bereich  -0.5 < uehat  < 1.5
%
%  Bild 8.2b:
%  Impulshöhe beta  im Bereich  -0.5 <  beta  < 1.5
% 
%  Bild 8.2c:
%  Steigung   a     im Bereich   0.5 <    a   < 2.
%
%  Bild 8.2d:
%  Amplitude uedach  im Bereich  0.5 < uedach < 1.2
%  Kreisfrequenz omD im Bereich  0.5 < uedach < 2
%
% ########################################################
clear

     uehat=1.;         % uehat=1      

     beta=1.;          % beta=1      

     a=1.;             % a=1      

     uedach=1.;        % uedach=1
     omD=.7;           % omD=0.7

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;        % Schriftgröße auf Grafiken

T=1;
tachs=[-10:20]*T;
k0=2;  
t0=-k0*T; te=10*T;
k=(-k0):floor(te/T);
tk=k*T;

% Digitale Sprungfunktion
uek1=uehat*ones(size(tk)); 
uek1(1,1:k0)=zeros(1,k0);

% Digitale Impulsfunktion
uek2=zeros(size(tk)); 
uek2(1,1+k0)=beta;

% Digitale Anstiegsfunktion
uek3=a*tk; 
uek3(1,1:k0)=zeros(1,k0);

% Digitale Sinusfunktion
uek4=uedach*sin(omD*tk); 
uek4(1,1:k0)=zeros(1,k0);


figure(1)
set(gcf,'Units','normal','Position',[.5 .5 .5 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 8.2');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.4,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes     

txnull=[t0 te]; xnull=zeros(1,2);
tynull=zeros(1,2);

subplot(2,2,1)
ynull=[-0.5 1.5];
plot(txnull,xnull,'k',tynull,ynull,'k'), hold on
plot(tk,uek1,'x','Linew',2), grid on
set(gca,'FontSize',fonts,'XTick',tachs,...
    'XLim',[t0 te],'YLim',[-0.5 1.5]);
title('a)');
ylabel('u_k')

subplot(2,2,2)
ynull=[-0.5 10];
plot(txnull,xnull,'k',tynull,ynull,'k'), hold on
plot(tk,uek3,'x','Linew',2), grid on
set(gca,'FontSize',fonts,'XTick',tachs,...
    'XLim',[t0 te],'YLim',[-2 10]);
title('c)');
ylabel('u_k')

subplot(2,2,3)
ynull=[-0.5 1.5];
plot(txnull,xnull,'k',tynull,ynull,'k'), hold on
plot(tk,uek2,'x','Linew',2), grid on
set(gca,'FontSize',fonts,'XTick',tachs,...
    'XLim',[t0 te],'YLim',[-0.5 1.5]);
title('b)');
xlabel('k')
ylabel('u_k')

subplot(2,2,4)
ynull=[-1.5 1.5];
plot(txnull,xnull,'k',tynull,ynull,'k'), hold on
plot(tk,uek4,'x','Linew',2), grid on
set(gca,'FontSize',fonts,'XTick',tachs,...
    'XLim',[t0 te],'YLim',[-1.5 1.5]);
title('d)');
xlabel('k')
ylabel('u_k')


