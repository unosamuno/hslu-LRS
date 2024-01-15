% Berechnungen und Plots für eine gegebene Übertragungsfunktion G(s)
% Bodediagramm, Nyquist-Ortskurve, Pol-Nullstellen-Plan, Sprungantwort,
% Impulsantwort und Phasen-/Amplitudenreserve

% Definieren des Frequenzvektors w
%w = 0.01:0.1:100; % rad/s
w=logspace(-2,2,100);

% Parameter des Systems
K = 0.1;
T1 = 1;
T2 = 3;
a = 1.525;
b = 1.02;
c = 1;
d = 0.5;
w_0 = 5;
Kpr=2;
Kps=1;
Ki=3;
%T=exp(-3*s);

% Berechnung in MATLAB
s = tf('s'); % Übertragungsfunktion aus der Toolbox

% ÜBERTRAGUNGSFUNKTION
G = (1+0.5*s)/((1+0.05*s)^2);
%G = (K*w_0^2)/(s^2+2*d*w_0*s+w_0^2)

% Bode-Befehl in MATLAB
h = figure;
subplot(2, 3, 1);
bode(G, w);
grid on;
title('Bode-Diagramm');

% Nyquist-Befehl in MATLAB
subplot(2, 3, 2);
nyquist(G, w);
grid on;
title('Nyquist-Diagramm');

% Pole-Nullstellen-Plan Befehl in MATLAB
subplot(2, 3, 3);
pzmap(G,'r');
grid on;
title('Pol-Nullstellen-Plan');

% Sprungantwort Befehl in MATLAB
subplot(2, 3, 4);
step(G);
grid on;
title('Sprungantwort');

% Impulsantwort Befehl in MATLAB
subplot(2, 3, 5);
impulse(G);
grid on;
title('Impulsantwort')

% Amplituden- & Phasenreserve in MATLAB
subplot(2, 3, 6);
margin(G);
grid on;
title('Amplituden- & Phasenreserve')
