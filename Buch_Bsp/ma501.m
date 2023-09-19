%  ma501.m     (Matlab/Simulink R2007b)
%
%  Bild A.5.1 a bis e
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

%  a)  Konstante K
K=2;

figure(1) 
set(gcf,'Units','normal','Position',[.45 .67 .26 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild A.5.1a');
ha1=gca;
axes('Position',[0 .95 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes(ha1);

w=logspace(-2,2);
betr=K*ones(size(w));
phas=zeros(size(w)); phas=phas*180/pi;
logw=log10(w);

subplot(2,1,1)
betr=20*log10(betr);
plot(logw,betr,'b'); grid on;
omachs=[-2:2]; dBachs=[-5:5]*20; phachs=[-5:5]*90;
labvec=['0.01';' 0.1';'  1 ';' 10 ';' 100'];
set(gca,'FontSize',fonts,...
    'Position',[.2 .54 .7 .3],...
    'XLim',[-2 2],'YLim',[-20 20],...
    'XTick',omachs,'YTick',dBachs,...
    'XTickLabel',labvec);
xlabel('\omega / (rad/s)')
ylabel('| F_1 |_{dB} / dB')

subplot(2,1,2)
plot(logw,phas,'b'); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .12 .7 .3],...
    'XLim',[-2 2],'YLim',[-90 90],...
    'XTick',omachs,'YTick',phachs,...
    'XTickLabel',labvec);
xlabel('\omega / (rad/s)')
ylabel('/\_F_1 / Grad')


% b) Faktor s
fak=[1 0];

figure(2)
set(gcf,'Units','normal','Position',[.72 .67 .26 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild A.5.1b');
ha2=gca;
axes('Position',[0 .95 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes(ha2);

w=logspace(-2,2);
[betrz,phasz,w]=bode(fak,[1],w);
[betrn,phasn,w]=bode([1],fak,w);
logw=log10(w);

subplot(2,1,1)
betrz=20*log10(betrz);
betrn=20*log10(betrn);
plot(logw,betrn,'b',logw,betrz,'g-'); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .54 .7 .3],...
    'XLim',[-2 2],'YLim',[-40 40],...
    'XTick',omachs,'YTick',dBachs,...
    'XTickLabel',labvec);
title('Grün: G=F_2,  Blau: G=1/ F_2')
xlabel('\omega / (rad/s)')
ylabel('| G |_{dB} / dB')

subplot(2,1,2)
plot(logw,phasn,'b',logw,phasz,'g-'); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .12 .7 .3],...
    'XLim',[-2 2],'YLim',[-135 135],...
    'XTick',omachs,'YTick',phachs,...
    'XTickLabel',labvec);
xlabel('\omega / (rad/s)')
ylabel('/\_G / Grad')


% c) Linearer Faktor (Näherungsgeraden)
T1=1;

figure(3)
set(gcf,'Units','normal','Position',[.45 .36 .26 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild A.5.1c');
ha3=gca;
axes('Position',[0 .95 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes(ha3);

logwe=log10(1/T1);

% Betragskennlinie Näherungsgeraden
subplot(2,1,1)
wgeg0=logspace(logwe-2,logwe);   % unterer Bereich
betr=zeros(size(wgeg0));
logw=log10(wgeg0);
plot(logw,betr,'b'); grid on; hold on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .54 .7 .3],...
    'XLim',[-2 2],'YLim',[-40 40],...
    'XTick',omachs,'YTick',dBachs,...
    'XTickLabel',labvec);
title('Grün: G=F_3,  Blau: G=1/ F_3')
xlabel('\omega / (rad/s)')
ylabel('| G |_{dB} / dB')

wgeginf=logspace(logwe,logwe+2);   % oberer Bereich Nennerfaktor
betrn=zeros(size(wgeginf))-20*log10(wgeginf*T1);
logw=log10(wgeginf);
plot(logw,betrn,'b');

wgeginf=logspace(logwe,logwe+2);   % oberer Bereich Zählerfaktor
betrn=zeros(size(wgeginf))+20*log10(wgeginf*T1);
logw=log10(wgeginf);
plot(logw,betrn,'g-');

% Phasenkennlinie Näherungsgeraden
subplot(2,1,2)
wunt=logspace(logwe-2,logwe-1); % unterer Bereich
phas=zeros(size(wunt));
logw=log10(wunt);
plot(logw,phas,'b'); grid on; hold on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .12 .7 .3],...
    'XLim',[-2 2],'YLim',[-135 135],...
    'XTick',omachs,'YTick',phachs,...
    'XTickLabel',labvec);
xlabel('\omega / (rad/s)')
ylabel('/\_G / Grad')

wmit=logspace(logwe-1,logwe+1); % mittlerer Bereich Nennerfaktor
logw=log10(wmit);
phas=-( (logw-logw(1))/(logw(size(wmit,2))-logw(1)) ) * 90;
plot(logw,phas,'b'); hold on;
wobn=logspace(logwe+1,logwe+2); % oberer Bereich Nennerfaktor
phas=ones(size(wobn))*(-90);
logw=log10(wobn);
plot(logw,phas,'b');

wmit=logspace(logwe-1,logwe+1); % mittlerer Bereich Zählerfaktor
logw=log10(wmit);
phas=( (logw-logw(1))/(logw(size(wmit,2))-logw(1)) ) * 90;
plot(logw,phas,'g-'); hold on;
wobn=logspace(logwe+1,logwe+2); % oberer Bereich Zählerfaktor
phas=ones(size(wobn))*(+90);
logw=log10(wobn);
plot(logw,phas,'g-');


% d) Quadratischer Faktor (Näherungsgeraden)
T1=1; T2=1;

figure(4)
set(gcf,'Units','normal','Position',[.72 .36 .26 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild A.5.1d');
ha4=gca;
axes('Position',[0 .95 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes(ha4);

logwe=log10(1/T2);

% Betragskennlinie Näherungsgeraden
subplot(2,1,1)
wgeg0=logspace(logwe-2,logwe);   % unterer Bereich
betr=zeros(size(wgeg0));
logw=log10(wgeg0);
plot(logw,betr,'b'); grid on; hold on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .54 .7 .3],...
    'XLim',[-2 2],'YLim',[-40 40],...
    'XTick',omachs,'YTick',dBachs,...
    'XTickLabel',labvec);
title('Grün: G=F_4,  Blau: G=1/ F_4')
xlabel('\omega / (rad/s)')
ylabel('| G |_{dB} / dB')

wgeginf=logspace(logwe,logwe+2);   % oberer Bereich Nennerfaktor
betrn=zeros(size(wgeginf))-40*log10(wgeginf*T2);
logw=log10(wgeginf);
plot(logw,betrn,'b');

wgeginf=logspace(logwe,logwe+2);   % oberer Bereich Zählerfaktor
betrn=zeros(size(wgeginf))+40*log10(wgeginf*T2);
logw=log10(wgeginf);
plot(logw,betrn,'g-');

% Phasenkennlinie Näherungsgeraden: hier für d=0
subplot(2,1,2)
wunt=logspace(logwe-2,logwe);
phas=zeros(size(wunt));
logw=log10(wunt);
plot(logw,phas,'b'); grid on; hold on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .12 .7 .3],...
    'XLim',[-2 2],'YLim',[-225 225],...
    'XTick',omachs,'YTick',phachs,...
    'XTickLabel',labvec);
xlabel('\omega / (rad/s)')
ylabel('/\_G / Grad')

wobn=logspace(logwe,logwe+2); % oberer Bereich Nennerfaktor
phas=ones(size(wobn))*(-180);
logw=log10(wobn);
plot(logw,phas,'b'); hold on;

wobn=logspace(logwe,logwe+2); % oberer Bereich Zählerfaktor
phas=ones(size(wobn))*(+180);
logw=log10(wobn);
plot(logw,phas,'g-'); hold on;


% Totzeit-Faktor
Tt=.1;

figure(5)
set(gcf,'Units','normal','Position',[.45 .05 .26 .25], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild A.5.1e');
ha5=gca;
axes('Position',[0 .95 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes(ha5);

w=logspace(-2,2);
betr=ones(size(w));
phas=-w*Tt; phas=phas*180/pi;
logw=log10(w);

subplot(2,1,1)
betr=20*log10(betr);
plot(logw,betr,'b'); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .54 .7 .3],...
    'XLim',[-2 2],'YLim',[-20 20],...
    'XTick',omachs,'YTick',dBachs,...
    'XTickLabel',labvec);
xlabel('\omega / (rad/s)')
ylabel('| F_5 |_{dB} / dB')

subplot(2,1,2)
plot(logw,phas,'b'); grid on;
set(gca,'FontSize',fonts,...
    'Position',[.2 .12 .7 .3],...
    'XLim',[-2 2],'YLim',[-180 45],...
    'XTick',omachs,'YTick',phachs,...
    'XTickLabel',labvec);
xlabel('\omega / (rad/s)')
ylabel('/\_F_5 / Grad')

