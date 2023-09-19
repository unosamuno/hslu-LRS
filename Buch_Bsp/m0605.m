%  m0605.m     (Matlab/Simulink R2007b)
%
%  Bild 6.5 b und c
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
%    wB   Bandbreite im Bereich 0.1 < wB  <  1.
%
% ########################################################
clear

     wB=1;       % wB=1;

% ########################################################

menu='none';  % none oder fig
close all
fonts=8; 

% PT1-Filter:  
fzae1=1; fnen1=[1/wB 1];

% PT2-Filter:
d=0.7;
fzae2=1; fnen2=[1/wB^2 2*d/wB 1];

% Bode-Diagramm::
figure(1)
set(gcf,'Units','normal','Position',[.5 .2 .5 .5], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 6.5 b und c');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes
      
w=logspace(-2,1,200);
logw=log10(w);
wnull=[logw(1) logw(size(logw,2))]; 
null=[0 0]; ph180=[-180 -180];
 
[fbetr1,fphas1,w]=bode(fzae1,fnen1,w);
[fbetr2,fphas2,w]=bode(fzae2,fnen2,w);

subplot(2,1,1)
fbetr1=20*log10(fbetr1);
fbetr2=20*log10(fbetr2);
plot(wnull,null,'k',logw,fbetr1,'b',logw,fbetr2,'c'); grid on;

omachs=[-5:1:5]; dBachs=[-5:1:5]*20; phachs=[-5:1:5]*90;
set(gca,'FontSize',fonts,...
    'XTick',omachs,'YTick',dBachs);
axis([logw(1) logw(size(logw,2)) -40 10])
title('Anti-Alias-Filter (Blau: 1.Ordnung, Cyan: 2.Ordnung)')
xlabel('log(\omega) \rightarrow')
ylabel('| G(j\omega) |_{dB} \rightarrow')

subplot(2,1,2)
plot(wnull,null,'k',logw,fphas1,'b',logw,fphas2,'c'); grid on;
set(gca,'FontSize',fonts,...
    'XTick',omachs,'YTick',phachs);
axis([logw(1) logw(size(logw,2)) -200 10])
xlabel('log(\omega) \rightarrow')
ylabel('/\_G(j\omega) \rightarrow')

