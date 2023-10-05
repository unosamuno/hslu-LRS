%Parameter
l=0.1; rp=0.01;
m=0.5;
cr=0.05;
g=9.81;
phi=0:0.1:90;

%statische Kennlinie
w=sqrt(2*9.81*sind(phi)./(2*rp*cosd(phi)+l*sind(2*phi)));
figure(1), plot(w/(2*pi),phi,'linewidth',1.5)
axis([0 5 0 90])
xlabel('w-AP/(2*pi),[Hz]')
ylabel('phi-AP [°]')
title('statische Kennline des nichtlinearen Systems')
grid

%Koeffizientenen a0,a1 und b0 sowie c=b0/a0 in Funktion von w resp phi 
a00=(w.^2).*(-(rp/l).*sind(phi)+cosd(2*phi))-(9.81/l)*cosd(phi);
a0=-a00;
a10=cr/(m*l^2);
a1=a10*ones(1,length(phi));
b0=w.*((2*rp/l).*cosd(phi)+sind(2*phi));
b0./a0;
c=b0./a0;

figure(2), plot(w/(2*pi),c,'linewidth',1.5)
grid
axis([0 5 0 0.5]);
xlabel('w-AP/(2*pi)')
ylabel('b0/a0')
title('statische Verstärkung des linearisierten Systems in Funktion von w-AP [Hz]')

figure(3), plot(w/(2*pi),sqrt(a0),'linewidth',1.5);
grid
axis([0 5 0 40]);
xlabel('w/(2*pi)')
ylabel('Wurzel von a0')
title('Eigenfrequenz w0=sqrt(a0) [rad/s] des linearisierten Systems in Funktion von w-AP[Hz]')

figure(4), plot(w/(2*pi),b0,'linewidth',1.5);
grid
axis([0 5 0 40]);
xlabel('w/(2*pi)')
ylabel('b0')
title('Verstärkungsfaktor b0 des linearisierten Systems in Funktion von w-AP [Hz]')

%konjugiert komplexe Pole des linearisierten Systems in Funktion von w-AP 
for i=1:length(phi)-1
x(:,i)=roots([1 a10 a0(i)']);
end;
figure(5), plot(real(x(:,1)),imag(x(:,:)),'.');
axis([-6 1 -250 250])
grid
xlabel('Realteil')
ylabel('Imaginärteil')
title('Pollagen des linearisierten Systems in Funktion von W-AP[Hz]')

w_AP=1.75*2*pi
phi_AP=45*pi/180
