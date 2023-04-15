% Topic: Capacitive Strain Gauges

% These are the necessary input parameters: The dielectric constant or permittivity (e0), the surface area (A) of the electrodes, the relative dielectric constant (in air and vacuum eR » 1) and the distance (x) between the electrodes of a structure. 

% In this Project we will create the Graphical visualization of the Capacitive Strain Gauges using above input parameters in MATLAB.
 
% --------------------------------References----------------------------------------------------------------------------------------------------------------------------------------------------------------
 
% [1] W. H. S. T. I.V. Tarasenko, "THE CAPACITIVE ABSOLUTE STRAIN GAUGE," Ukrainian Food Journal No. 3.
% [2] K. Bethe, "Sensoren mit Dunnfilm-Dehnungsmessstreifen aus Metalliscen und Halbleiter Materialen," NTG- Fachberichte, pp. 168-176, 1982. 
% [3] I. V. S. a. N. A. S. V S Ignakhin, "Capacitive sensors of mechanical strain". 
% [4] W. C. Heerens, "Application of capacitance techniques in senor designs," J. Phys. E: Sci. Instrum.

% -------------------------------------------------------------------------------------------------------------------------------------------


% define all the variables%
%e0 is dielectric constant of vaccum%
%eR is  relative dielectric constant and depend on material between the

clc
clear all
close all

fig = figure 
fig.WindowState = 'maximized' ;

% fig.InnerPosition = [  404.0000   76.5000  560.0000  733.5000 ] ;

%capacitor plates
% A = area of the capacitor plate
% x = distance between two plates of the capacitor 
% x = variable in this case
% all the values taken are in SI unit system

e0 = 8.85e-12;
eR = 1;
A = 0.000025;
x = 0.0001:0.000001:0.0002;

% all the required values are defined
%formula to find the capacitance of the system

c = (e0*eR*A)./x;
m = diff(c);
strain = -diff(c)./c(2:end);
%hold on
in = 1 ;
loop1 =  [2 : length(x)-1 length(x)-1:-1:2] ;
move = [ linspace(0,pi,99) linspace(pi,0,99) ] ;
zoom = 2 ;

% Graphical representation of variation of capacitance with respect to distance between 2 plates 
for i = loop1

subplot(2,2,1)

plot(x(2:end),c(2:end),'r','Markersize',2,'Linewidth',2) ;
hold on ;
plot(x(i),c(i),'k.','markersize',20);
grid on
xlabel('Distance between 2 plates','Fontsize',10)
ylabel('Capacitance','Fontsize',10)
title('Variation of capacitance with respect to distance','Fontsize',10)
hold off ;
axis tight;

% Graphical representation of variation of strain with respect to capacitance

pbaspect([ 3 1 1]) ;
subplot(2,2,3)
plot(c(2:end),strain,'b','Markersize',2,'Linewidth',2) ;
hold on ;
plot(c(i),strain(i),'k.','markersize',20);
grid on
xlabel('Capacitance','Fontsize',10)
ylabel('Strain','Fontsize',10)
title('Variation of strain with respect to capacitance','Fontsize',10)

hold off ;
axis tight ;



%Graphical representation of movements of capacitor fixed plate and movable plate
pbaspect([3 1 1]) ;

subplot(2,2,[2 4])

L = 20 ;
W = 10 ;
H = 1 ;

t = move(in) ;
 
plot3(0,0,0) ; hold on ; 

xx1 = -L/2 ; yy1 = -W/2 ; zz1 = -2+t ;
xx2 = -L/2 ; yy2 = -W/2 ; zz2 = -2-H ;

plate_points = [    0 0 0
                    L 0 0
                    L W 0
                    0 W 0
                    0 0 H
                    L 0 H
                    L W H
                    0 W H   ] ;
       
plate1 = transpose(plate_points' + [ xx1 yy1 zz1]') ;
plate2 = transpose(plate_points' + [ xx2 yy2 zz2]') ;

red_faces    = [ 5 6 7 8 5 
                 1 2 3 4 1 ] ;
       
yellow_faces = [ 1 4 8 5 1
                 1 2 6 5 1
                 2 3 7 6 2
                 4 8 7 3 4 ] ;

% plate1
patch('Faces',red_faces,'Vertices',plate1,'FaceColor','red');
patch('Faces',yellow_faces,'Vertices',plate1,'FaceColor','yellow');

% plate2
patch('Faces',red_faces,'Vertices',plate2,'FaceColor','red');
patch('Faces',yellow_faces,'Vertices',plate2,'FaceColor','yellow');

% wire1
wire1 = [ 0 0 zz1+H/2
          0 0 3
          W/2+8 0 3
          W/2+8 0 zz1+H/2] ;


% wire2
wire2 = [ 0 0 zz2+H/2
          0 0 -4
          W/2+8 0 -4
          W/2+8 0 zz2+H/2] ;

%wire1
plot3(wire1(:,1),wire1(:,2),wire1(:,3),'k-') ;
plot3(wire1(end,1),wire1(end,2),wire1(end,3),'k.','markersize',15);


%wire2
plot3(wire2(:,1),wire2(:,2),wire2(:,3),'k-') ;
plot3(wire2(end,1),wire2(end,2),wire2(end,3),'k.','markersize',15);


view([-45+180 15]);
axis([-3 3 -1 1 -1 1]*10/zoom) ; 
daspect([1 1 1]) ; grid on ; grid minor ;   
xlabel('x');
ylabel('y');
zlabel('z');
xticks([]);
yticks([]);
zticks([]);
title('Movements of capacitor fixed plate and movable plate','Fontsize',10);
axis on ;


hold off ;

drawnow ;


if ~isvalid(fig)
break ;
end

in = in+1 ;
end
fig.InnerPosition


function xxnew = linsin1(a,b,divide)

range = [ a b ] ;
x = linspace(range(1),range(2),divide) ;
m = mean(range) ;
d = range(2)-range(1);

y = linspace(0,180,divide)  ;

xx = m*cosd(y) + m ;
xx = flip(xx) ;

    function output = myrange(input,range1,range2)
        
        distance = ((input -range1(1))/(range1(2)-range1(1))) ;
        output = range2(1) + distance*(range2(2)-range2(1)) ;
        
    end

xxnew = myrange(xx,[xx(1) xx(end)],range) ;

end
