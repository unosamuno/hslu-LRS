% Berechnung des Bodediagramms für eine gegebene Übertragungsfunktion G(s)

% Definieren des Frequenzvektors w
w = 0.01:0.01:100; % rad/s

% Parameter des Systems
K = 1;
T1 = 1;
T2 = 3;
a = 1;
b = 1;
c = 1;

% Berechnung in MATLAB
s = tf('s'); % Übertragungsfunktion aus der Toolbox

% ÜBERTRAGUNGSFUNKTION
G = K/((1+T1*s)*(1+T2*s));

% Bode-Befehl in MATLAB
h = figure;
subplot(2, 2, 1);
bode(G, w);
grid on;
title('Bode-Diagramm');

% Nyquist-Befehl in MATLAB
subplot(2, 2, 2);
nyquist(G, w);
grid on;
title('Nyquist-Diagramm');

% Pole-Nullstellen-Plan Befehl in MATLAB
subplot(2, 2, 3);
pzmap(G,'r');
grid on;
title('Pole-Nullstellen-Plan');

% Sprungantwort Befehl in MATLAB
subplot(2, 2, 4);
step(G);
grid on;
title('Sprungantwort');
