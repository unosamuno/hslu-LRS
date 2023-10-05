%Berechnung des Bodediagramms für eine gegebene Übertragungsfunktion G(s)

%Def des Frequenzvektors w
w=0.01:0.01:100; %rad/s

%besser, log Frequenzachse:
w=logspace(-2,2,100);

%Parameter ses Systems
K=3;
T1=0.5;

%Berechnung von Real- und Imaginäranteil
ReG=K./(1+(T1.*w).^2);
ImG=-K.*T1.*w./(1+(T1.*w).^2);

%Berechnung von Betrag und Phase
absG=sqrt(ReG.^2+ImG.^2);
phiG=atan2(ImG,ReG);

%Darstllung als Bodediagramm
figure(1);
subplot(211);
semilogx(w,20*log10(absG)); grid on; zoom on;
title('Bode-Diagramm')
ylabel('abs(G(jw))[dB]');
xlabel('w[rad/s]');
subplot(212);
semilogx(w,phiG*180/pi); grid on; zoom on;
ylabel('phi(G(jw))[deg]');
xlabel('w[rad/s]');

%Darstellung als Nyquist-Ortskurve
figure(2);
plot(ReG,ImG);
grid on; zoom on;
xlabel('Real\{G(jw)\}');
ylabel('Imag\{G(jw)\}');
title('Nyquist-Ortskurve');

figure(3);
polar(phiG,absG);
grid on; zoom on;
title('Nyquist-Ortskurve');

%Berechnung in Matlab
s=tf('s'); %transfer function aus Toolbox
G=K/(T1*s+1)


%Bode-Befehl in Matlab
figure(4);
bode(G,w);
grid on; zoom on;

%Nyquist-Befehl in Matlab
figure(5);
nyquist(G,w);grid on; zoom on;