% Berechnung des Bodediagramms für eine gegeben Übertragungsfunktion G(s)

% Parameter vom System PT1
T1=1;
k=4;

% Definition von omega (w) in [rad/s]
w=0.01:0.01:100;
w=logspace(-2,2,500);

% Berechnung von Real- und Imaginäranteil
ReG=k./(1 + (T1.*w).^2);
ImG=-k.*T1.*w./(1 + (T1.*w).^2);

% Berechnung von Betrag und Phase
absG=sqrt(ReG.^2+ImG.^2);
phiG=atan2(ImG,ReG);

figure(1);
subplot(211);
semilogx(w,20*log10(absG)); grid on; zoom on;
ylabel('abs\{G(jw)\} [dB]');
title('Bode-Diagramm')
subplot(212);
semilogx(w,phiG*180/pi); grid on; zoom on;
ylabel('phi\{G(jw)\} [deg]')
xlabel('w [rad/s]')

% Alternative Berechnung
s=tf('s')
G=k/(T1*s+1)

figure(2);
bode(G); grid on; zoom on;

figure(3);
plot(ReG,ImG); grid on; zoom on;
axis([-4 4 -4 4]);
xlabel('Re\{G(jw)\}')
ylabel('Im\{G(jw)\}')
title('Nyquist-Ortskurve')

