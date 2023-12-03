clf;
hold on;
grid on;

% Übertragungsfunktion aus der Toolbox
s = tf('s');

% PT1-Element Parameter
KP1 = 1;
T1 = 1;

% PT2-Element Parameter
KP2 = 1;
w0 = 0.5;
D = 1.25;

% Zeitvektor
t = 0:0.1:5;

% Impulsantwort für PT1-Element
g1 = impulse(G1, t);
% Zähler- und Nennerpolynom für PT1-Element
numG1 = KP1;
denG1 = [T1, 1];
G1 = tf(numG1, denG1);

% Impulsantwort für PT2-Element
g2 = impulse(G2, t);
% Zähler- und Nennerpolynom für PT2-Element
numG2 = [KP2 * w0^2];
denG2 = [1, 2 * D * w0, w0^2];
G2 = tf(numG2, denG2);


% Impulsantwort für I- und IT1-Element
G3 = KP1 / s;
G4 = KP1 / s^2;
G5 = KP1 / (s*(1+T1*s));
g3 = impulse(G3, t);
g4 = impulse(G4, t);
g5 = impulse(G5, t);


% Impulsantwort für DT1-Element
G6 = (KP1*s) / (1+s*T1);
g6 = impulse(G6, t);

% Plotten der Impulsantworten
%plot(t, g1, '-', 'LineWidth', 3);
%plot(t, g2, '-', 'LineWidth', 3);
%plot(t, g3, '-', 'LineWidth', 3);
%plot(t, g4, '-', 'LineWidth', 3);
plot(t, g5, '-', 'LineWidth', 3);
%plot(t, g6, '-', 'LineWidth', 3);

% Y-Achsen Limits
%ylim([-0.1, 0.5]);

% Titel und Achsenbeschriftungen
title('Einheits-Impulsantwort');
xlabel('Zeit t/s');
ylabel('g(t)');

% Legende
%legend('Impulsantwort');
