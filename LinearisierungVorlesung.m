% Übung zur Linearisierung
% Thema: Visualisierung der Linearisierung einer Funktion

x=-2.0:0.1:2.0;
y=-2.0:0.1:2.0;

lx=length(x);
ly=length(y);

z=zeros(length(x),length(y));

% Berechnung der Funktion z=f(x,y)
for i=1:length(y);
    for j=1:length(x);
        z(i,j)=4*sin(x(j))^2+y(i)^2;
    end;
end;

% Visualisierung der Funktion z
figure(1);
surf(x,y,z); %oder 
%mesh(x,y,z);
xlabel('x');ylabel('y'),zlabel('z');


%