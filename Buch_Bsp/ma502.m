%  ma502.m     (Matlab/Simulink R2007b)
%
%  Bild A.5.2 a und b
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

% Linearer Faktor
%----------------
T1=1;

figure(1)
set(gcf,'Units','normal','Position',[.55 .52 .4 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild A.5.2a');
ha1=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes(ha1);

logwe=log10(1/T1);

% Betragskennlinie Näherungsgeraden
subplot(2,1,1)
wgeg0=logspace(logwe-2,logwe,100);   % unterer Bereich
betr=zeros(size(wgeg0));
logw=log10(wgeg0);
plot(logw,betr,'g'), grid on, hold on
omachs=[-2:2]; dBachs=[-5:5]*20; phachs=[-5:5]*90;
labvec=['0.01';' 0.1';'  1 ';' 10 ';' 100'];
set(gca,'FontSize',fonts,...
    'XLim',[-2 2],'YLim',[-40 10],...
    'XTick',omachs,'YTick',dBachs,...
    'XTicklabel',labvec);
title('Grün: Näherungsgeraden,  Blau: Exakt')
xlabel('\omega/(rad s^{-1})')
ylabel('| G(j\omega) |_{dB}')

wgeginf=logspace(logwe,logwe+2,100);   % oberer Bereich Nennerfaktor
betrn=zeros(size(wgeginf))-20*log10(wgeginf*T1);
logw=log10(wgeginf);
plot(logw,betrn,'g');

% Phasenkennlinie Näherungsgeraden
subplot(2,1,2)
wunt=logspace(logwe-2,logwe-1,100); % unterer Bereich
phas=zeros(size(wunt));
logw=log10(wunt);
plot(logw,phas,'g'), grid on, hold on
set(gca,'FontSize',fonts,...
    'XLim',[-2 2],'YLim',[-135 45],...
    'XTick',omachs,'YTick',phachs,...
    'XTicklabel',labvec);
xlabel('\omega/(rad s^{-1})')
ylabel('/\_G(j\omega) / Grad')

wmit=logspace(logwe-1,logwe+1,100); % mittlerer Bereich Nennerfaktor
logw=log10(wmit);
phas=-( (logw-logw(1))/(logw(size(wmit,2))-logw(1)) ) * 90;
plot(logw,phas,'g'); hold on;
wobn=logspace(logwe+1,logwe+2,100); % oberer Bereich Nennerfaktor
phas=ones(size(wobn))*(-90);
logw=log10(wobn);
plot(logw,phas,'g');

% Exakter Frequenzgang:
fak=[T1 1];

w=logspace(-2,2,100);

[betrn,phasn,w]=bode([1],fak,w);

logw=log10(w);

subplot(2,1,1)
betrn=20*log10(betrn);
plot(logw,betrn,'b')

subplot(2,1,2)
plot(logw,phasn,'b')


% Quadratischer Faktor
%---------------------
T1=1; T2=1;

figure(2)
set(gcf,'Units','normal','Position',[.55 .05 .4 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild A.5.2b');
ha2=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes(ha2);

logwe=log10(1/T2);

% Betragskennlinie Näherungsgeraden
subplot(2,1,1)
wgeg0=logspace(logwe-2,logwe);   % unterer Bereich
betr=zeros(size(wgeg0));
logw=log10(wgeg0);
plot(logw,betr,'g'); grid on; hold on;
set(gca,'FontSize',fonts,...
    'XLim',[-2 1],'YLim',[-20 20],...
    'XTick',omachs,'YTick',dBachs,...
    'XTicklabel',labvec);
title('Grün: Näherungsgeraden,  Blau: Exakt')
xlabel('\omega/(rad s^{-1})')
ylabel('| G(j\omega) |_{dB}')

wgeginf=logspace(logwe,logwe+1);   % oberer Bereich Nennerfaktor
betrn=zeros(size(wgeginf))-40*log10(wgeginf*T2);
logw=log10(wgeginf);
plot(logw,betrn,'g');

% Phasenkennlinie Näherungsgeraden: hier für d=0
subplot(2,1,2)
wunt=logspace(logwe-2,logwe);
phas=zeros(size(wunt));
logw=log10(wunt);
plot(logw,phas,'g'); grid on; hold on;

set(gca,'FontSize',fonts,...
    'XLim',[-2 1],'YLim',[-190 10],...
    'XTick',omachs,'YTick',phachs,...
    'XTicklabel',labvec);
xlabel('\omega/(rad s^{-1})')
ylabel('/\_G(j\omega) / Grad')

wobn=logspace(logwe,logwe+1); % oberer Bereich Nennerfaktor
phas=ones(size(wobn))*(-180);
logw=log10(wobn);
plot(logw,phas,'g'); hold on;


% Exakter Frequenzgang:
%-------------------------------------------------------------
for i=1:6 
    
    if i==1; d=1.; end
    if i==2; d=.7; end
    if i==3; d=.5; end
    if i==4; d=.2; end
    if i==5; d=.1; end
    if i==6; d=.05; end
    
    T1=2*T2*d;
    fak=[T2^2 T1 1];
    w=logspace(-2,1,350);
    
    [betrn,phasn,w]=bode([1],fak,w);
    
    logw=log10(w);
    
    subplot(2,1,1)
    betrn=20*log10(betrn);
    plot(logw,betrn,'b')
    
    subplot(2,1,2)
    plot(logw,phasn,'b')
    
end

