
clear all; close all; clc;
name = 'Vedika Harnathka';
id = 'A16871408';
hw = 'project';
format long;


%Task 1
%Calculating data for satellite 1
[TT,XX,YY,ZZ,UU,VV,WW] = satellite(6.79110225757073e+06, 4.75378788421192e+05, 9.50757576842384e+05, 1.18130306168964e+03,-3.36221359242321e+03,-6.72492718484640e+03,5000);

Re = 6.37e6;
load('earth_topo.mat'); 

%Graphing the trajectory of satellite 1
figure(1)
hold on;
[a,b,c] = sphere(50);
s = surf(Re*a/1e6,Re*b/1e6,Re*c/1e6); % create a sphere
s.CData = topo;                % set color data to topographic data
s.FaceColor = 'texturemap';    % use texture mapping
s.EdgeColor = 'none';          % remove edges
s.FaceLighting = 'gouraud';    % preferred lighting for curved surfaces
s.SpecularStrength = 0.4;      % change the strength of the reflected light
plot3(XX./1e6,YY./1e6,ZZ./1e6,'m', 'LineWidth', 4);
plot3(XX(:,end)/1e6,YY(:,end)/1e6,ZZ(:,end)/1e6,'mo', 'LineWidth', 5);
hold off;
grid on; box on; axis equal;
axis(7*[-1 1 -1 1 -1 1]);  % IMPORTANT: axis unit is in 10^6 m
xlabel('x (10^6 m)'); ylabel('y (10^6 m)'); zlabel('z (10^6 m)'); title('Sat 1');
set(gca,'LineWidth',1,'FontSize',14, ...
        'Xtick',[-6:4:6],'Ytick',[-6:4:6],'Ztick',[-6:4:6]);
view(3);

p1a = evalc('help satellite');
p1b = 'See figure 1';


%Task 2
%Calculating data for satellite 1-6
for i = 1:6
    [Xo,Yo,Zo,Uo,Vo,Wo] = read_input('satellite_data.txt', i);
    [T{i}, X{i}, Y{i}, Z{i}, U{i}, V{i}, W{i}] = satellite(Xo,Yo,Zo,Uo,Vo,Wo,12400);
    H{i} = sqrt((X{i}.^2)+(Y{i}.^2)+(Z{i}.^2));
    Vmag{i} = sqrt((U{i}.^2)+(V{i}.^2)+(W{i}.^2));
    localmax = T{i}(islocalmax(H{i}));
end

for i=1:6
    traveld{i} = sum(sqrt(diff(X{i}).^2+diff(Y{i}).^2+diff(Z{i}).^2));
end

C = {'r','g','b','c','m','y'};

%Graphing altitude vs time and speed vs time for satellite 1-6
figure(2)
subplot(2,1,1); hold on;
for i = 1:6
    plot(T{i}, H{i}./1e6, C{i}, 'LineWidth', 2);
end
grid on; box on;
legend('ID:0001','ID:0002','ID:0003','ID:0004','ID:0005','ID:0006');
xlabel('time (s)'); ylabel('altitude (10^6 m)'); title('Altitude vs Time of Satellites 1-6');
xlim([0 16000]);
set(gca,'LineWidth',1,'FontSize',10, 'Xtick', 0:2000:16000); hold off;

subplot(2,1,2); hold on;
for i=1:6
    plot(T{i}, Vmag{i}, C{i}, 'LineWidth', 2);
end
grid on; box on;
xlabel('time (s)'); ylabel('speed (m/s)'); title('Speed vs Time of Satellites 1-6');
xlim([0 16000]);
legend('ID:0001','ID:0002','ID:0003','ID:0004','ID:0005','ID:0006');
set(gca,'LineWidth',1,'FontSize',10, 'Xtick', 0:2000:16000); hold off;

%Data structure
for i = 1:6
    stat(i).sat_id = i;
    stat(i).final_position = [X{i}(:,end) Y{i}(:,end) Z{i}(:,end)];
    stat(i).final_velocity = [U{i}(:,end) V{i}(:,end) W{i}(:,end)];
    stat(i).time_lmax_altitude = T{i}(islocalmax(H{i}));
    LM = T{i}(islocalmax(H{i}));
    orbital = T{i}(LM(2)) - T{i}(LM(1));
    stat(i).orbital_period = orbital;
end

%Generating report.txt
fidw = fopen('report.txt','w');
fprintf(fidw, '%s\n%s\n', 'Vedika Harnathka', 'A16871408');
fprintf(fidw, 'sat_ID, travel_distance(m), orbital_period(s)');
for i = 1:6
    fprintf(fidw, '\n%d %15.9e %15.9e %15.9e\n', stat(i).sat_id, traveld{i}, stat(i).orbital_period);
end
fclose(fidw);

p2a = evalc('help read_input');
p2b = 'See figure 2';
p2c = stat(1); p2d = stat(2); p2e = stat(3);
p2f = stat(4); p2g = stat(5); p2h = stat(6);
p2i = evalc('type report.txt');

%Task 3

Re = 6.37e6;
load('earth_topo.mat'); 

%Graphing initial and final positions of every satellite
figure(3);
subplot(1,2,1); hold on;
[a2,b2,c2] = sphere(50);
f = surf(Re*a2/1e6,Re*b2/1e6,Re*c2/1e6); % create a sphere
f.CData = topo;                % set color data to topographic data
f.FaceColor = 'texturemap';    % use texture mapping
f.EdgeColor = 'none';          % remove edges
f.FaceLighting = 'gouraud';    % preferred lighting for curved surfaces
f.SpecularStrength = 0.4;      % change the strength of the reflected light
for n = 1:520
    [Xi, Yi, Zi, Ui, Vi, Wi] = read_input('satellite_data.txt', n);
    if sqrt((Xi-(-5.5e6))^2 + (Yi-(-3.9e6))^2+(Zi)^2) <= 2e6
        plot3(Xi/1e6, Yi/1e6, Zi/1e6, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 3);
    else
        plot3(Xi/1e6, Yi/1e6, Zi/1e6, 'mo', 'MarkerFaceColor', 'm', 'MarkerSize', 2);
    end
end
hold off;
grid on; box on; axis equal;
axis(7*[-1 1 -1 1 -1 1]);  % IMPORTANT: axis unit is in 10^6 m
xlabel('x (10^6 m)'); ylabel('y (10^6 m)'); zlabel('z (10^6 m)'); title('All Satellites at T=0s');
set(gca,'LineWidth',1,'FontSize',10, ...
        'Xtick',[-6:4:6],'Ytick',[-6:4:6],'Ztick',[-6:4:6]);
view(3);


subplot(1,2,2); hold on;
[a3,b3,c3] = sphere(50);
e = surf(Re*a3/1e6,Re*b3/1e6,Re*c3/1e6); % create a sphere
e.CData = topo;                % set color data to topographic data
e.FaceColor = 'texturemap';    % use texture mapping
e.EdgeColor = 'none';          % remove edges
e.FaceLighting = 'gouraud';    % preferred lighting for curved surfaces
e.SpecularStrength = 0.4;      % change the strength of the reflected light
for n = 1:520
    [Xi, Yi, Zi, Ui, Vi, Wi] = read_input('satellite_data.txt', n);
    [Ta{n}, Xa{n}, Ya{n}, Za{n}, Ua{n}, Va{n}, Wa{n}] = satellite(Xi, Yi, Zi, Ui, Vi, Wi,6000);
    Xf = Xa{n}(:,end);
    Yf = Ya{n}(:,end);
    Zf = Za{n}(:,end);
    if sqrt((Xi-(-5.5e6))^2 + (Yi-(-3.9e6))^2+(Zi)^2) <= 2e6
        plot3(Xf/1e6, Yf/1e6, Zf/1e6, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 3);
    else
        plot3(Xf/1e6, Yf/1e6, Zf/1e6, 'mo', 'MarkerFaceColor', 'm', 'MarkerSize', 2);
    end
end
hold off;
grid on; box on; axis equal;
axis(7*[-1 1 -1 1 -1 1]);  % IMPORTANT: axis unit is in 10^6 m
xlabel('x (10^6 m)'); ylabel('y (10^6 m)'); zlabel('z (10^6 m)'); title('All Satellites at T=6000s');
set(gca,'LineWidth',1,'FontSize',10, ...
        'Xtick',[-6:4:6],'Ytick',[-6:4:6],'Ztick',[-6:4:6]);
view(3);

p3a = 'See figure 3';
p3b = 'closest';
p3c = 'decreases';

