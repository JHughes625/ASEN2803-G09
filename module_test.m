clc
clear
close all

function [x,y,DYDXend,PTend,G,S,Endspeed] = line1(DYDX,PTstart,length, Startspeed) 
    x = 0:0.01:(length^2 / (1 + DYDX^2))^0.5;
    y = x * DYDX + PTstart(2);
    x = x + PTstart(1);
    DYDXend = DYDX;
    PTend = [x(end), y(end)];
    G = 9.81*cosd(atand(DYDX))*ones(size(x));
    S = ((x-PTstart(1)).^2 + (y-PTstart(2)).^2).^0.5;
    Endspeed = (2*((Startspeed^2)/2 + (y(1)-y(end))*9.81))^0.5;
end

function [x,y,DYDXend,PTend,G,S,Endspeed] = loop1(PTstart,radius,Startspeed)
    delta = 0:0.01:360;
    x = radius*sind(delta) + PTstart(1);
    y = - radius*cosd(delta) + radius + PTstart(2);

    PTend = [x(end), y(end)];
    DYDXend = 0;

    Endspeed = Startspeed;
    speeds = (2*((Startspeed^2/2) - 9.81*(y - PTstart(2)))).^0.5;
  
    deltaQ1 = 0:0.01:90;
    Q1l = length(deltaQ1);
    GQ1 = (speeds(Q1l).^2)/radius + cosd(deltaQ1)*9.81;
    deltaQ2 = 90:0.01:180;
    GQ2 = (speeds(Q1l:(2*Q1l-1)).^2)/radius - cosd(deltaQ2)*9.81;
    deltaQ3 = 180:0.01:270;
    GQ3 = (speeds((2*Q1l-1):(3*Q1l-2)).^2)/radius - cosd(deltaQ3)*9.81;
    deltaQ4 = 270:0.01:360;
    GQ4 = (speeds((3*Q1l-2):(4*Q1l-3)).^2)/radius - cosd(deltaQ4)*9.81;

    G = [GQ1, GQ2, GQ3, GQ4]./9.81;
    leng = pi*radius^2;
    S = linspace(0, leng, length(G));

end

%{
function [x,y,DYDXend,PTend,G,S,Endspeed] = arc1(DYDX,PTstart,radius,concave,degree,Startspeed)
    
    if concave == 1 % concave = 1: concave up
        
    end

end
%}
[x1, y1, DYDX1, PT1, G1, S1, Endspeed1] = loop1([5, 50], 5, 15);

figure(1)
plot(x1, y1)
axis equal

figure(2)
plot(S1, G1)


%{

[x1, y1, DYDX1, PT1, G1, S1, Endspeed1] = line1(-5, [5, 50], 30, 0);
[x2, y2, DYDX2, PT2, G2, S2, Endpseed2] = line1(DYDX1+2, PT1, 80, Endspeed1);

x = [x1, x2];
y = [y1, y2];

G = [G1, G2];
S2 = S2 + S1(end);
S = [S1, S2];

figure(1)
plot(x, y)

figure(2)
plot(S, G)

%}