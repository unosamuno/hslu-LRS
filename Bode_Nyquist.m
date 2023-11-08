% Berechnung des Bodediagramms für eine gegebene Übertragungsfunktion G(s)

% Definition des Frequenzvektors w
w = logspace(-2, 2, 100); % rad/s

% Parameter des Systems
K = 3;
T1 = 0.5;

% Berechnung von Real- und Imaginäranteil
ReG = K./(1 + (T1 .* w).^2);
ImG = -K .* T1 .* w./(1 + (T1 .* w).^2);

% Berechnung von Betrag und Phase
absG = sqrt(ReG.^2 + ImG.^2);
phiG = atan2(ImG, ReG);

% Darstellung als Bodediagramm und Nyquist-Ortskurve
h = figure;

% Bode-Diagramm
subplot(2, 2, 1);
semilogx(w, 20*log10(absG)); 
grid on;
title('Bode-Diagramm');
ylabel('abs(G(jw)) [dB]');
xlabel('w [rad/s]');

% Phase-Gang
subplot(2, 2, 2);
semilogx(w, phiG * 180 / pi);
grid on;
ylabel('phi(G(jw)) [deg]');
xlabel('w [rad/s]');
title('Phase-Gang');

% Nyquist-Ortskurve
subplot(2, 2, 3);
plot(ReG, ImG);
grid on;
xlabel('Real\{G(jw)\}');
ylabel('Imag\{G(jw)\}');
title('Nyquist-Ortskurve');

% Nyquist-Ortskurve in Polardarstellung
subplot(2, 2, 4);
polarplot(phiG, absG);
grid on;
title('Nyquist-Ortskurve in Polardarstellung');
