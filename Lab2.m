%% Problem 1:
clc; clf;clear all;

d=30;
m=30;

% www.mah.se/pages/.../Tabeller%20o%20formler%20energio%20klimat.d...‎
% Concrete

lambda=1.2; %(lambda/Wm^-1K^-1);
c=920; %(Jkg^-1K^-1)
densi=2000; %(kg/m^3)

k=(lambda)/(c*densi);

T1=zeros(m,1);
T1(1)=22;
T2=zeros(m,1);
T2(1)=22;

% Steplengths

K=0.5;
dx = (d/100)/(m-1);
dt = K*((dx^2)/k);
Z=[30,1];

% Stepfunction

for j=1:1400
    T2=T1;
    for i=1:30
        Z(i,j) = T2(i);
    end
    for i=2:29
        T2(i)=T1(i)+K*(T1(i+1)-2*T1(i)+T1(i-1));
    end
    T1=T2;
    j=j+1;
end

Z1=[];
x=linspace(0,1400,1400);
y=linspace(0,30,30);
[X,Y] = meshgrid(x,y);

for j=1:200;
    i=1:30;
Z1(i,j)=Z(i,j);
end

surf(Y,X,Z);
title('Temperature distribution with Dirichlet boundary condition')
xlabel('Position inside the wall (cm)')
ylabel('Number of steps (\Delta t=82s)') 
zlabel('Temperature (Celsius)')
set(gca,'FontSize',20)
set(findall(gcf,'type','text'),'FontSize',20)
shading flat
colormap jet


a=zeros(30);
a(1)=22;
a(30)=0;
for i=1:30
    a(i)=22-22*(i-1)/29;
end

%% 2D
hold on
plot(y,a)
o=plot(y,T1)
title('Temperature distribution with Dirichlet boundary condition')
xlabel('Position inside the wall (cm)') 
ylabel('Temperature (Celsius)') 
set(gca,'FontSize',20)
set(o,'Color','magenta')
set(findall(gcf,'type','text'),'FontSize',20)    
%% Problem 2:
clc; clf; clear all;

d=30;
m=30;

% www.mah.se/pages/.../Tabeller%20o%20formler%20energio%20klimat.d...‎
% Concrete

lambda=1.2; %(lambda/Wm^-1K^-1);
c=920; %(c/Jkg^-1K^-1)
densi=2000; %(kg/m^3)
k=(lambda)/(c*densi);
T0 = 100;
K=0.5;
dx = (d/100)/(m-1);
dt = K*((dx^2)/k);
Z=[30,1];

T1=zeros(m,1);

for I=2:29
T1(I)=T0*((I*(d-I))/d^2);
end
    T1(1)=T1(2);
    T1(30)=T1(29);
T2=zeros(m,1);

% Step function
for j=1:1000
    T2=T1;
    for i=1:30
        Z(i,j) = T2(i);
    end
    for i=2:29
        T2(i)=T1(i)+K*(T1(i+1)-2*T1(i)+T1(i-1));
    end
        T2(1)=T2(2);
    T2(30)=T2(29);
    T1=T2;
    j=j+1;
end

Z1=[];
x=linspace(0,1000,1000);
y=linspace(0,30,30);
[X,Y] = meshgrid(x,y);


for j=1:200;
    i=1:30;
Z1(i,j)=Z(i,j);
end

surf(X,Y,Z);
title('Temperature distribution with Neumann boundary condition')
xlabel('Number of steps (\Delta t=82s)') 
ylabel('Position inside the wall (cm)') 
zlabel('Temperature (Celsius)') 
set(gca,'FontSize',20)
set(findall(gcf,'type','text'),'FontSize',20)
shading flat
colormap jet

%% 2D
hold on
o=plot(y,T1);
title('Temperature distribution with Neumann boundary condition')
xlabel('Position inside the wall (cm)')  
ylabel('Temperature (Celsius)') 
set(gca,'FontSize',20)
set(o,'Color','magenta')
set(findall(gcf,'type','text'),'FontSize',20)  

%% Problem 3:

clc; clf; clear all;

d=30;
m=30;

% www.mah.se/pages/.../Tabeller%20o%20formler%20energio%20klimat.d...‎
% Concrete

lambda=1.2; %(lambda/Wm^-1K^-1);
c=920; %(c/Jkg^-1K^-1)
densi=200; %(kg/m^3)
T0 = 100;

k=(lambda)/(c*densi);

T1=zeros(m,1);
T1(1)=22;
T1(30)=T1(29);
T2=zeros(m,1);
T2(1)=22;

% Step lengths

K=0.5;
dx = 0.3/(m-1);
dt = K*((dx^2)/k);
Z=[30,1];

% Step function

for j=1:5000
    T2=T1;
            for i=1:30
            Z(i,j) = T2(i);
        end
    for i=2:29
        T2(i)=T1(i)+K*(T1(i+1)-2*T1(i)+T1(i-1));
    end
    T2(30)=T2(29);
    T1=T2;
    j=j+1;
end


x=linspace(0,5000,5000);
y=linspace(0,30,30);
[X,Y] = meshgrid(x,y);
Z1=[];

for j=1:200;
    i=1:30;
Z1(i,j)=Z(i,j);
end

surf(X,Y,Z)
title('Temperature distribution with mixed boundary conditions')
xlabel('Number of steps (\Delta t=82s)') 
ylabel('Position inside the wall (cm)') 
zlabel('Temperature (Celsius)') 
set(gca,'FontSize',20)
set(findall(gcf,'type','text'),'FontSize',20)
shading flat

%% Problem 4:
clc;clf;clear all;

d=30;
m=30;

% www.mah.se/pages/.../Tabeller%20o%20formler%20energio%20klimat.d...‎
%Concrete

lambda=1.2; %(lambda/Wm^-1K^-1);
c=920; %(c/Jkg^-1K^-1)
densi=2000; %(kg/m^3)
T0 = 100;
s = 1000; %(kWm^-3)

k=(lambda)/(c*densi);

T1=zeros(m,1);
T1(m)=0;
T1(1)=0;
T2=zeros(m,1);
T2(m)=0;
T2(1)=0;

% Step lengths

K=0.5;
dx = (d/100)/(m-1);
dt = K*((dx^2)/k);
Z=[30,1];

% Step function

for j=1:1750
    T2=T1;
            for i=1:30
            Z(i,j) = T2(i);
        end
        for i=2:29
        T2(i)=T1(i)+K*(T1(i+1)-2*T1(i)+T1(i-1))+dt*s/(c*densi);
            end
    T1=T2;
    j=j+1;
end


x=linspace(0,1750,1750);
y=linspace(0,30,30);
[X,Y] = meshgrid(x,y);

Z1=[];

for j=1:200;
    i=1:30;
Z1(i,j)=Z(i,j);
end

surf(X,Y,Z)
title('Temperature distribution with Dirichlet boundary conditions and a heat sourc')
xlabel('Number of steps (\Delta t=82s)')
ylabel('Position inside the wall (cm)') 
zlabel('Temperature (Celsius)') 
set(gca,'FontSize',20)
set(findall(gcf,'type','text'),'FontSize',20)
shading flat
colormap jet