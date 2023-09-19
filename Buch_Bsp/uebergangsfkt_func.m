function [h,t]=uebergangsfkt_func(Kp,T1)
%  uebergangsfunktion_func.m     (Matlab/Simulink R2007b)
%
%  Beispiel A.1.1
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
%    Im Command Window z.B. eingeben:
%    >> [h,t]=uebergangsfkt_func(1,1); plot(t,h)
%
%
% ########################################################

t=[0:.1:10]; 
h=Kp*(1-exp(-t/T1)); 
