% Berechnung des Bodediagramms für eine gegebene Übertragungsfunktion G(s)

% Definieren des Frequenzvektors w
%w = 0.01:0.1:100; % rad/s
w=logspace(-2,2,500);

% Parameter des Systems
K = 0.1;
T1 = 1;
T2 = 3;
a = 4;
b = 2;
c = 3;
d = 0.01;
w_0 = 5;

% Berechnung in MATLAB
s = tf('s'); % Übertragungsfunktion aus der Toolbox

% ÜBERTRAGUNGSFUNKTION

%Nicht-Schwingend
%G = K/((1+s*T1)*(1+s*T2));

% Schwingend
G = (K*w_0^2)/(s^2+2*d*w_0*s+w_0^2);

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
title('Pole-Nullstellen-Plan');

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
