%  m0218a.m     (Matlab/Simulink R2007b)
%
%  Bild 2.18a
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  (c) 5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%   phi0   Pendelausschlag im Arbeitspunkt in Grad
%          im Bereich  10 < phi0 < 80
%
% ########################################################
clear all


      phi0=45;    % Voreinstellung  phi0=45


% ########################################################
clc
close all
fonts=10;

% Streckendaten:
rP=.01;       % m
l=.1 ;        % m
m= .5;        % kg
cR=.05;       % Nm/(rad/s)
g=9.81;       % m/s^2

c1=cR/(2*m*l^2);  
c2=g/l;


% Kennlinie der Strecke phiK=f(omegaK)
phiKGrad=[.1:.1:89];   % Pendelwinkelbereich in Grad
phiK=(pi/180)*phiKGrad;
omegaK=sqrt( (2*g*sin(phiK))./(2*rP*cos(phiK)+l*sin(2*(phiK))) ); % AP-Gl.

figure(1)
set(gcf,'Units','normal','Position',[.53 .4 .45 .45], ...
    'NumberTitle','off','MenuBar','fig',...
    'Name',' Bild 2.18a');
ha=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes(ha)

% Nichtlineare Kennlinie einzeichnen
plot(omegaK,phiKGrad,'k'),grid on, hold on
set(gca,'FontSize',fonts,...
    'Position',[.15 .18 .75 .75],...
    'XLim',[0 5*2*pi],...
    'XTick',[0:6:5*2*pi],...
    'YLim',[0 90],...
    'YTick',[0:15:90]);   
xlabel('\omega_K / (rad/s) \rightarrow')
ylabel('\phi_K / Grad \rightarrow')

% Arbeitspunkt (omega0,phi0):
phi0Grad=phi0;
phi0=(pi/180)*phi0Grad;   % Umrechnung Grad in rad   
omega0=sqrt( (2*g*sin(phi0))./(2*rP*cos(phi0)+l*sin(2*phi0)) ); % AP-Gl.
plot(omega0,phi0Grad,'ko','Markersize',5),grid on, hold on

% Auf AP bezogenes Koordinatensystem einzeichnen:
DomBereich=[-1.:.1:1.]*2*pi;  % in U/s
Dom=DomBereich+omega0;   

sp=size(Dom,2);
Dyax=phi0Grad*ones(1,sp);
Dphi=[-20:.1:20]+phi0Grad;      % in Grad
sp=size(Dphi,2);
Dxax=omega0*ones(1,sp);
plot(Dom,Dyax,'k',Dxax,Dphi,'k','LineW',1.5);
text(Dom(size(Dom,2)),Dyax(size(Dyax,2)),'\Delta\omega',...
    'VerticalAlign','Top',...
    'HorizontalAlign','Right')
text(Dxax(size(Dxax,2)),Dphi(size(Dphi,2)),'\Delta\phi  ',...
    'VerticalAlign','Top',...
    'HorizontalAlign','Right')

% Lineare Kennlinie einzeichnen:
a0=omega0^2*((rP/l)*sin(phi0)-cos(2*phi0))+(g/l)*cos(phi0);
b0=omega0*((2*rP/l)*cos(phi0)+sin(2*phi0));

Dom=[-.5:.1:.5]*2*pi;  % in U/s
Dphilin=(b0/a0)*Dom;
DphilinGrad=Dphilin*(180/pi); % rad auf Grad

Dom=Dom+omega0;
DphilinGrad=DphilinGrad+phi0Grad;

plot(Dom,DphilinGrad,'k','LineW',1.5);









