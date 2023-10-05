% Visualisierung einer Linearisierung einer Funktion welche abhängi ist von
% zwei Parametern(Eingangsgrössen)

x=-2:0.1:2;
y=-2:0.1:2;

z=zeros(length(x), length(y));
;


for i=1:length(y)
    for j=1:length(x)
        z(i,j)=4*sin(x(j))^2+y(i)^2;
    end;
end;

%Visualisierung der Funktion z(x,y)
figure(1);
mesh(x,y,z);
xlabel('x'); ylabel('y'); zlabel('z');

%Festlegung des Arbeitspunktes
x0=-1.2;
y0=0.8;
z0=4*sin(x0)^2+y0^2;

figure(1);
hold on;
plot3(x0,y0,z0,'k*');


% Linearisierung
dx=-0.5:0.01:0.5;
dy=-0.5:0.01:0.5;

for i=1:length(dy)
    for j=1:length(dx)
        dz(i,j)=8*sin(x0)*cos(x0)*dx(j)+2*y0*dy(i);
    end;
end;

% Visualisierung der Funktion dz
figure(2);
mesh(dx,dy,dz);
xlabel('\Delta x'); ylabel('\Delta y'); zlabel('\Delta z');
hold on;
plot3(0,0,0,'k*');


figure(1);
hold on;
mesh(x0+dx,y0+dy,z0+dz);





