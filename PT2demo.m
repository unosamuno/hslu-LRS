% PT2 allgemein

D=0.7; % 5% Überschwingen
w0=1;
K = 10;
sim('PT2allg');



%Variieren von w0
for i = 0 : 10
    w0 = i/4; 
    sim('PT2allg');   
    figure(10);
    plot(tout,yout);  
    hold on;
end; 
grid on; zoom on;


%Variieren von D
D=1;
w0=1;
figure(11);
for i = 0 : 10
    D = i/4 + 0.1; % bei D = 0 Grenzstabilität
    sim('PT2allg');  