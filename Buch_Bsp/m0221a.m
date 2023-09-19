%  m0221a.m     (Matlab/Simulink R2007b)
%
%  Bild 2.21a
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
%   hap  Arbeitspunkt des Füllstandes in cm
%        im Bereich  5 < hap < 15
%
%   Aap  Arbeitspunkt der Abflußfläche in mm^2
%        im Bereich  3 < Aap < 9
%
%   cP   Pumpenkonstante cP in (g/s)/V
%        im Bereich  1  < cP <  2.5
%
%   Betrachtungswinkel der Kennfläche:
%    Winkel az (Azimuth) um die Hochachse in Grad 
%    Winkel el (Elevation) über der upK-AabK-Ebene in Grad 
%
% ########################################################
clear all

      hap=10;      % Voreinstellung  hap=10.

      Aap=6;       % Voreinstellung  Aap=6.

      cP=2.;       % Voreinstellung  cP=2.

      az=-40;      % Voreinstellung -40.

      el=20;       % Voreinstellung  20.

% ########################################################

clc
close all
fonts=8;

%Streckendaten:
A=30*1e-4;   % m^2
rho=1e3;     % kg/m^3
cP=1e-3*cP;  % (kg/s)/V
g=9.81;      % m/s^2

c1=sqrt(2*g)/A;  c2=cP/(rho*A);


%  Arbeitspunkt (hap, Aap, uap) berechnen:

hap=1e-2*hap;                % in m
Aap=1e-6*Aap;                % in m^2
uap=(c1/c2)*Aap*sqrt(hap)   % in V

AP=[hap Aap uap];
format short e

% Kennlinienfeld der Strecke h=f(Aab,up), Aab als Parameter
Apar=[3e-6 6e-6 9e-6];
uax=[0:.1:10];

figure(1)
set(gcf,'Units','normal','Position',[.53 .55 .45 .38],...
    'NumberTitle','off','MenuBar','None',...
    'Name',' Bild 2.21a');
ha=gca;
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes(ha)

axes   % Creation command
set(gca,'FontSize',fonts,...
    'Position',[.15 .18 .75 .7],...    
    'NextPlot','add',...
    'Box','on');
axis([0 7 0 20]); 
xlabel('u_{PK} / V \rightarrow')
ylabel('h_K / cm \rightarrow'); 
grid on

for i=1:size(Apar,2)
    h0=(c2/(c1*Apar(i)))^2*uax.^2;  % Kennlinie h0=f(uax) für Aab=Apar(i)
    h0=1e2*h0;   % Umrechnung von m in cm
    plot(uax,h0)
end

% Auf AP bezogenes Dup/Dh-System einzeichnen:
Dup=[-1.2:.1:1.2]+uap;
sp=size(Dup,2);
hapcm=1e2*hap;
Dyax=hapcm*ones(1,sp);
Dh=[-5:.1:5]+hapcm;
sp=size(Dh,2);
Dxax=uap*ones(1,sp);
plot(Dup,Dyax,'k',Dxax,Dh,'k','LineW', 1.5);
text(Dup(size(Dup,2)), Dyax(size(Dyax,2)),'\Deltau_P',...
    'VerticalAlign','Top',...
    'HorizontalAlign','Right')
text(Dxax(size(Dxax,2)),Dh(size(Dh,2)),'\Deltah ',...
    'VerticalAlign','Top',...
    'HorizontalAlign','Right')

% AP einzeichnen:
plot(uap,hapcm,'b.','Markersize',20),grid on, hold on


% Lineare Kennlinie einzeichnen:
a0=c1*Aap/(2*sqrt(hap));
b01=c2;
steig=(b01/a0)*100;  % cm/V
Dxrel=[-.8:.1:.8];
Dkenn=steig*Dxrel; 
hap=hap*100;   % m in cm
Dkenn=Dkenn+hap;
Dxabs=Dxrel+uap;    
plot(Dxabs,Dkenn,'r','LineW',1.5);



% Kennfläche f2=Aab*f1 in 3D
figure(2)
set(gcf,'Units','normal','Position',[.53 .06 .45 .38],...
    'NumberTitle','off', 'Name',' Bild 2.21a in 3D');
axes('Position',[0 .95 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

uax=[0:.2:7];
Aax=[3e-6: .4e-6: 9e-6];
[uVek,AVek]=meshgrid(uax,Aax);
Flaeche=((c2/c1)*(uVek./AVek)).^2;
AVek=1e6*AVek;   % Umrechnung von m^2 in mm^2
Flaeche=1e2*Flaeche;  % Umrechnung von m in cm
surfl(uVek,AVek,Flaeche),grid on
set(gca,'FontSize',fonts);
axis([0 7 0 9 0 20]);  hold on
xlabel('u_{PK} / V \rightarrow')
ylabel('\leftarrow A_{abK} / mm^2 ')
zlabel('h_K / cm \rightarrow');
title('Rot: Arbeitspunkt')
view(az,el);
colormap(hsv);   

% AP einzeichnen:  
plot3(uap,1e6*Aap,hapcm,'r.','Markersize',30)

legend('Nutzen Sie das Icon "Rotate 3D"',4)
