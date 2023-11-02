% Berechnung des Bode-Diagramms für eine gegebene Übertragungsfunktion G(s)

% Systemparameter
K=3;
T1=2;
% Übertragungsfunktion G(s)=K/(T1*s+1)

% (Kreis-)Frequenzachse w
w=0.01:0.01:100; % nicht ideal, da lineare Skalierung, d.h. hohe Frequenzen haben zu viele Messpunkte

% besser
w=logspace(-2,2,200); % alle Frequenzen werden gleich berücksichtigt

% Berechnung von Real- und Imaginäranteil
ReG=K./(1+(T1.*w).^2);
ImG=-K.*T1.*w./(1+(T1.*w).^2);

% Berechnung von Betrag und Phase
absG=sqrt(ReG.^2+ImG.^2);
phiG=atan2(ImG,ReG);

% Darstellung als Bodediagramm
figure(1);
subplot(211);
semilogx(w,20*log10(absG)); grid on; zoom on;
xlabel('w [rad/s]');
ylabel('abs(G) [dB]