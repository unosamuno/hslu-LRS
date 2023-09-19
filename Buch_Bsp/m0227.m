%  m0227.m     (Matlab/Simulink R2007b)
%
%  Bild 2.27 und 2.28
%  Mann/Schiffelgen/Froriep,
%  Einführung in die Regelungstechnik, 
%  11.Aufl., Hanser-Verlag, München, 2009
%  ISBN 978-3-446-41765-6
%
%  Unterprogramme: s0227.mdl
%
%  (c) 5.7.09  R.Froriep
%
% ########################################################
%
%  Variations-Empfehlungen:
%
%  freqmark   Nummer eines im Bode-Diagramm dargestellten
%             Frequenzpunktes (von links gezählt)
%             im Bereich 6 < freqmark < 10
%
%   Bem.: Für Bild 2.27 ist freqmark=[7 8]  
%
% ########################################################
clear

    freqmark=[7];   % Voreinstellung freqmark=8

% ########################################################

menu='none';  % none oder fig
close all
fonts=8;

omzahl=12;  % Gesamtzahl Frequ.punkte
omess=logspace(-1,3,omzahl);  
fnr=size(freqmark,2);
for i=1:fnr
    omega(i)=omess(freqmark(i));
end

figure(1);
set(gcf,'Units','normal','Position',[.53 .53 .45 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Bild 2.27');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

var=size(omega,2); 
for i=1:var
    bild=i;
    ut='sin(omega(i)*t)';
    tend=1;
    
    opts=simset('Solver','ode45',...
        'InitialState',[],...
        'MaxStep',.005);
    [t,x,y]=sim('s0227',[0 tend],opts,ut);
    
    subplot(2,var,bild)
    tachs1=[0 1]; tachs2=[0 0]; 
    plot(tachs1,tachs2,'k'), hold on
    set(gca,'FontSize',fonts);
    title(['\omega = ', num2str(omega(i)),' rad/s'])
    xlabel('t/s \rightarrow')
    ylabel('u_e/ V \rightarrow')
    axis([0 1 -1 1])
    plot(t,y(:,2))
    
    %  Bezugslinie Phase einsetzen hinter tein
    tein=.6;
    it=1;
    while t(it)<tein,   it=it+1;  end
    while sign(y(it,2))==sign(y(it-1,2)) | ...
            y(it,2)-y(it-1,2)<0 
        it=it+1; end
    lin1=[t(it) t(it)]; lin2=[-1 1];
    plot(lin1,lin2,'r','LineW',2)
    
    if var==2 bild=bild+2; end
    if var==1 bild=bild+1; end
    subplot(2,var,bild)
    tachs1=[0 1]; tachs2=[0 0]; 
    plot(tachs1,tachs2,'k'), hold on
    set(gca,'FontSize',fonts); 
    xlabel('t/s \rightarrow')
    ylabel('u_c / V \rightarrow')
    axis([0 1 -1 1]); 
    plot(t,y(:,1))
    lin1=[t(it) t(it)]; lin2=[-1 1];
    plot(lin1,lin2,'r','LineW',2)
    
end

%  Frequenzgang-"Meßpunkte" ins Bode-Diagramm
figure(2)
set(gcf,'Units','normal','Position',[.53 .06 .45 .4], ...
    'NumberTitle','off','MenuBar',menu,...
    'Name',' Punkte im Bode-Diagramm Bild 2.28');
axes('Position',[0 0 .5 .04],'visible','off')
text(.01,.5,'(c) Mann/Schiffelgen/Froriep, Hanser-Verlag','fontsize',8)
axes

num=1; den=[.1 1]; 
[amp,phas]=bode(num,den,omess);
randn('seed',0);           % Zufällige Meßfehler
amp=amp+.03*randn(omzahl,1);
amp=abs(amp);  
phas=phas+2*randn(omzahl,1);
for ip=1:omzahl
    if phas(ip)>0,  phas(ip)=-phas(ip); end
end 
phas(1)=0;

subplot(2,1,1)
omachs1=[.1 1000]; omachs2=[0 0];
semilogx(omachs1,omachs2,'k')
hold on, grid on
set(gca,'FontSize',fonts);
axis([.1 1e3 -40 20]); 
semilogx(omess,20*log10(amp),'g.','MarkerSize',15)
xlabel('\omega/(rad/s) \rightarrow')
ylabel('| u_C / u_e|_{dB} \rightarrow')
ylabel('20 log |u_C / u_e| \rightarrow')

subplot(2,1,2)
omachs1=[.1 1000]; omachs2=[0 0];
semilogx(omachs1,omachs2,'k')
hold on, grid on
set(gca,'FontSize',fonts,'ylim',[-100 10],...
    'ytick',[-90 -45 0]); 
axis([.1 1e3 -100 20]); 
semilogx(omess,phas,'g.','MarkerSize',15)
xlabel('\omega/(rad/s) \rightarrow')
ylabel('\phi / Grad \rightarrow')


%  Betrachtete Werte im Bodediagramm hervorheben:
subplot(2,1,1)
ampmark=amp(freqmark);
semilogx(omega,20*log10(ampmark),'r.','MarkerSize',25)

subplot(2,1,2)
phasmark=phas(freqmark);
semilogx(omega,phasmark,'r.','MarkerSize',25)

