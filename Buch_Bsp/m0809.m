%  m0809.m     (Matlab/Simulink R2007b)
%
%  Bild 8.9 
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  s0809.mdl
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%  
%
% ########################################################
clear


% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

open_system('s0809')  

a1=-0.76;
b1=1.16;   
T=20;      


te=300; 

opts=simset('Solver','FixedStepDiscrete',...
    'InitialState',[],...
    'FixedStep',T);
[tk,xk,yk]=sim('s0809',[0 te],opts);


figure(1)
set(gcf,'Units','normal','Position',[.01 .1 .45 .25], ...
    'NumberTitle','on','MenuBar',menu,...
    'Name',' Pumpenspannung (V)');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.4,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes     

plot(tk,yk(:,1),'x','LineW',2), grid on
set(gca,'FontSize',fonts);
axis([0 te 0 1.2]); 


figure(2)
set(gcf,'Units','normal','Position',[.49 .1 .45 .25], ...
    'NumberTitle','on','MenuBar',menu,...
    'Name',' Füllstand (cm)');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.4,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag',...
    'fontsize',8)
axes    

plot(tk,yk(:,2),'x','LineW',2), grid on
set(gca,'FontSize',fonts);
axis([0 te 0 5]); 
