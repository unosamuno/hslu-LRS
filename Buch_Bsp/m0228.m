%  m0228.m     (Matlab/Simulink R2007b)
%
%  Bild 2.28
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: keine
%
%  (c) 5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%  Modellparameter:
%    Kp   P-Beiwert, im Bereich   0.01 <  Kp  <  10.
%
%    T1   Zeitkonstante, im Bereich   0.01 <  T1  <   1.
%
% ########################################################
clear
 
      Kp=1.;       % Voreinstellung Kp=1.
           
      T1= .1;      % Voreinstellung T1= .1

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

%  Frequenzgang-Meßwerte
omess=  1.0e+003 *  [ 0.0001
    0.0002
    0.0005
    0.0012
    0.0028
    0.0066
    0.0152
    0.0351
    0.0811
    0.1874
    0.4329
    1.0000 ];

amp=[1.0349
    1.0185
    1.0008
    1.0030
    0.9409
    0.8863
    0.5514
    0.3278
    0.1303
    0.0794
    0.0203
    0.0110];

phas=[  0
    -2.6013
    -1.9001
    -7.7483
    -16.1683
    -36.0409
    -59.1987
    -72.1337
    -83.0615
    -88.5431
    -90.2070
    -87.7036 ];

figure(1)
set(gcf,'Units','normal','Position',[.53 .45 .45 .45], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.28');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

sp211=subplot(2,1,1);
omachs1=[.1 1000]; omachs2=[0 0];
semilogx(omachs1,omachs2,'k')
hold on, grid on
set(gca,'FontSize',fonts);
axis([.1 1e3 -40 20]); 
title('Blau: Meßwerte,  Grün: Modellansatz')
xlabel('\omega/(rad/s)  \rightarrow')
ylabel('20 log |u_C / u_e|  \rightarrow');
semilogx(omess,20*log10(amp),'b.','MarkerSize',15)

sp212=subplot(2,1,2);
omachs1=[.1 1000]; omachs2=[0 0];
semilogx(omachs1,omachs2,'k')
hold on, grid on
set(gca,'FontSize',fonts,'ylim',[-100 10],...
    'ytick',[-90 -45 0]); 
hold on, grid on
axis([.1 1e3 -100 20]); 
xlabel('w (rad/s)'); ylabel('Phi (Grad)');
xlabel('\omega/(rad/s) \rightarrow')
ylabel('\phi / Grad \rightarrow');
semilogx(omess,phas,'b.','MarkerSize',15)

num=Kp; den=[T1 1];
om=logspace(-1,3,200);
[amp,phas,om]=bode(num,den,om);

axes(sp211)
semilogx(om,20*log10(amp),'g')
set(gca,'FontSize',fonts);

axes(sp212)
semilogx(om,phas,'g')
set(gca,'FontSize',fonts);
