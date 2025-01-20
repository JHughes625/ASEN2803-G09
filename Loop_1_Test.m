clc
clear var
close all

%% Loop 1 
S1 = [5,125]; % start point
SpeedINIT = 0;

%% Segment [1] (arc)

% degrees from 0 to 70 for the arc
delta1 = 0:0.01:70;

% radius
r1 = 10; 

% paramatric equations for the arc
x1 = r1*sind(delta1) + S1(1);
y1 = r1*cosd(delta1) + S1(2) - r1;

% record end point of segment 1
S2 = [x1(end), y1(end)];

% record slope of the end of segment 1
DYDXend1 = (-r1*sind(delta1(end)))./(r1*cosd(delta1(end)));


%% Segment [2] = (line)

delta = 0:0.01:20;

x2 = delta + S2(1);
y2 = DYDXend1 * delta + S2(2);

S3 = [x2(end), y2(end)];

%% Segment [3] = (arc)

% degrees from 20 -> 90 for arc 2 (not from 0 because of the slope
% following the first arc)
delta = 20:0.01:90;

r3 = 25;

x3 = - r3*(cosd(delta) - cosd(20)) + S3(1);
y3 = - r3*(sind(delta) - sind(20)) + S3(2);

S3 = [x3(end), y3(end)];

DYDXend3 = 0;

%% Segment [4] (line)

delta = 0:0.01:35;

x4 = delta + S3(1);
y4 = 0 * delta + S3(2);

S4 = [x4(end), y4(end)];

DYDXend4 = 0;

%% Segment [5] (loop)

delta = 0:0.01:360;

r5 = 30;

x5 = r5*sind(delta) + S4(1);
y5 = - r5*cosd(delta) + r5 + S4(2);

S5 = [x5(end), y5(end)];

DYDXend5 = 0;

%% Segment [6] (line)

delta = 0:0.01:70;

x6 = delta + S5(1);
y6 = 0 * delta + S5(2);

S6 = [x6(end), y6(end)];

DYDXend6 = 0;

%% Plot

x = [x1, x2, x3, x4, x5, x6];
y = [y1, y2, y3, y4, y5, y6];

g = 9.81;
size = length(x);

speeds = (2*g*(S1(2)-y)).^0.5;

%c = linspace(1,50,size);

% plot with color representing speed (like the demo graph they had on the
% slide)
scatter(x, y, 1, speeds, "filled")
colorbar

%hold on
%plot(x1,y1 ,x2,y2, x3,y3, x4,y4, x5,y5, x6,y6)
axis equal
axis([0, 180, 0, 135])
xlabel("x (m)")
ylabel("y (m)")
title("Test Segments + Speed (m/s)")
%hold off

%Test Gs calculation for Segment [1]
speeds1 = speeds(1:length(x1));
G1 = cosd(delta1) - ((speeds1.^2)/(r1*g)); % see note I wrote for G vertical #1
D1 = r1 * delta1 / 180 * pi; % Distance along arc using theta * r = arclength

%Test Gs calculation for Segment [2]
G2 = ones(length(x2));
G2 = cos(atan(DYDXend1))*G2; % G vertical #2
D2 = ((x2- S2(1)).^2 + (y2- S2(2)).^2).^0.5; % distance along constant downward slope
D2 = D2 + D1(end); % "zeros" the starting distance for segment 2 (D2)


%Plot Gs vs D
figure(2)
plot(D1,G1,D2,G2)

xlabel("Distance (m)")
ylabel("Gs")
title("G-force (vertical) vs Distance Travel")