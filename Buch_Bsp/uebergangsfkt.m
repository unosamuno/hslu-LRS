%  uebergangsfkt.m     (Matlab/Simulink R2007b)
%
%  Zu Anhang 1
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme:  keine
%
%  (c)5.7.09  R.Froriep
%
% ########################################################
%
%  Erläuterungen:
%
%    Beispiel für ein script-file
%
%
% ########################################################

t=[0:.1:10]; 
Kp=1; 
T1=1; 
h=Kp*(1-exp(-t/T1)); 
plot(t,h) 


