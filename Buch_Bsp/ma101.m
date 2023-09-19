%  ma101.m      (Matlab/Simulink R2007b)
%
%  Bild A.1.1 (Anhang A.1)
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
%    Erzeugung eines LTI-Objektes und Anzeige in
%     LTI Viewer und
%     SISO Design Tool (Fenster liegt zu Beginn genau
%                        über dem LTI-Viewer)
%    
%    Ausführliche Informationen über die Anwendung der 
%    Programme ist unter "Help" in der Menüleiste 
%    verfügbar. 
%
% ########################################################

clear
close all

Kp=1.5;
zae=poly([-1+j*.8 -1-j*.8]);
zae=Kp*zae;
nen=poly([-.6+j*2.2 -.6-j*2.2  -.8]);
LZI_Bsp_=tf(zae,nen)

ltiview(LZI_Bsp_)
pause(2)
sisotool(LZI_Bsp_)


