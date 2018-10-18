%% Vektorlabb 1. Useful commands: quiver streamline contour divergence curl
clear all
clc
p = load('tryckfalt.dat');
u = load('vindfalt_u.dat');
v = load('vindfalt_v.dat');
x = 0:55:55*30;
y = 0:55:55*29;
%% Problem 1: Isobars
% Read in data of air pressure and plot contourlines (isobars) 
contour(x,y,p,60);
title('Contour lines')
xlabel('Distance west-east (km)') 
ylabel('Distance south-north (km)')
set(gca,'FontSize',20)
set(findall(gcf,'type','text'),'FontSize',20)
%% Problem 2: Wind vectors
clf
% Visualize by plotting wind vectors
x = 0:55:55*30;
y = 0:55:55*29;
quiver(x,y,u,v,0)
title('Wind vectors')
xlabel('Distance west-east (km)') 
ylabel('Distance south-north (km)')
set(gca,'FontSize',20)
set(findall(gcf,'type','text'),'FontSize',20)
xlim([0 1650])
ylim([0 1595])
%% Rescaling and plotting
clf
u1=[];
v1=[];
for i=1:30, j=1:31
    u1(i,j)=u(i,j)*3.6;
end
    
for i=1:30, j=1:31
    v1(i,j)=v(i,j)*3.6;
end

x = 0:55:55*30;
y = 0:55:55*29;
quiver(x,y,u1,v1,0);
title('Vindvektorer')
xlabel('Distance west-east (km)') 
ylabel('Distance south-north (km)')
set(gca,'FontSize',20)
set(findall(gcf,'type','text'),'FontSize',20);
xlim([0 1650])
ylim([0 1595])
axis equal
%%
[maxval maxloc] = max(u(:));
[maxval maxloc] = max(v(:));

%% Wind strength. Field lines
clf
[sx,sy] = meshgrid(0:31,0:30);
streamline(stream2(u1,v1,sx,sy,[0.1, 35]))
title('Field lines')
xlabel('Distance west-east (km) (\Delta x = 55 km)') 
ylabel('Distance south-north (km) (\Delta y = 55 km)') 
set(gca,'FontSize',20)
set(findall(gcf,'type','text'),'FontSize',20)
hold on

%% Problem 3: Divergence and rotation
% Calculate and plot divergence
dudx=[];
dudy=[];
dvdx=[];
dvdy=[];

for i=1:30, j=1:1;
    dudx(i,j)=(-u(i,j)+u(i,j+1))/(55);
end

for i=1:30, j=2:30;
    dudx(i,j)=(u(i,j+1)-u(i,j-1))/(2*55);
end

for i=1:30, j=31:31;
    dudx(i,j)=(u(i,j)-u(i,j-1))/(55);
end

for i=1:30, j=1:1;
    dvdx(i,j)=(-v(i,j)+v(i,j+1))/(55);
end

for i=1:30, j=2:30;
    dvdx(i,j)=(v(i,j+1)-v(i,j-1))/(2*55);
end

for i=1:30, j=31:31;
    dvdx(i,j)=(v(i,j)-v(i,j-1))/(55);
end

for i=1:1, j=1:31;
    dudy(i,j)=(-u(i,j)+u(i+1,j))/(55);
end

for i=2:29, j=1:31;
    dudy(i,j)=(u(i+1,j)-u(i-1,j))/(2*55);
end

for i=30:30, j=1:31;
    dudy(i,j)=(u(i,j)-u(i-1,j))/(55);
end

for i=1:1, j=1:31;
    dvdy(i,j)=(-v(i,j)+v(i+1,j))/(55);
end

for i=2:29, j=1:31;
    dvdy(i,j)=(v(i+1,j)-v(i-1,j))/(2*55);
end

for i=30:30, j=1:31;
    dvdy(i,j)=(v(i,j)-v(i-1,j))/(55);
end

clf
deriv=dudx+dvdy;
contour(x,y,deriv,30)
title('Divergence of wind field')
xlabel('Distance west-east (km)') 
ylabel('Distance south-north (km)')
set(gca,'FontSize',20)
set(findall(gcf,'type','text'),'FontSize',20)
axis equal


%% Rotation of the wind field
clf
[curlz, cav]=curl(x,y,u,v);
pcolor(x,y,cav); shading interp
%hold on;
%quiver(x,y,u,v,'y')
%hold off
%colormap copper
title('Rotation of wind field')
xlabel('Distance west-east (km)') 
ylabel('Distance south-north (km)')
set(gca,'FontSize',20)
set(findall(gcf,'type','text'),'FontSize',20)
xlim([0 1650])
ylim([0 1595])

%% Different visualization of rotation
clf
ax.FontSize = 12;
ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];
ax.YLim = [-2 2];
[curlz, cav]=curl(x,y,u,v);
surf(x,y,curlz); %shading interp
colorbar
%hold on;
%quiver(x,y,u,v,'y')
%hold off
%colormap hot
title('Rotation of windfield')
xlabel('Distance west-east (km)') 
ylabel('Distance south-north (km)')
set(gca,'FontSize',20)
set(findall(gcf,'type','text'),'FontSize',20)
xlim([0 1650])
ylim([0 1595])

 
%% Another visualisation
[px,py] = gradient(u,55);
[px2,py2] = gradient(v,55);
clf
quiver(x,y,px2,-py)
title('Rotation of wind field')
xlabel('Distance west-east (km)') 
ylabel('Distance south-north (km)')
set(gca,'FontSize',20)
set(findall(gcf,'type','text'),'FontSize',20)
xlim([0 1650])
ylim([0 1595])


%% Yet more ways of showing rotation
clf
[curlz, cav]=curl(x,y,u,v);
rotation=dvdx-dudy;
surf(x,y,rotation); shading interp
%hold on;
%quiver(x,y,u,v,'y')
%hold off
%colormap copper
title('Rotation of wind field')
xlabel('Distance west-east (km)') 
ylabel('Distance south-north (km)')
set(gca,'FontSize',20)
set(findall(gcf,'type','text'),'FontSize',20)

%% Finding maxima from labpm
a1=[];

for i=1, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end

for i=2, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end

for i=3, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end

for i=4, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=5, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=6, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end

for i=7, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end

for i=8, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=9, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=10, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=11, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=12, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=13, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=14, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=15, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end

for i=16, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=17, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=18, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=19, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=20, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end

for i=21, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=22, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=23, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=24, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=25, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=26, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=27, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=28, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=29, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end
for i=30, for j=1:31, 
    a1(i,j)=sqrt(norm(u1(i,j)).^2+norm(v1(i,j)).^2);
    end
end

b1=max(a1,[],2);
b1(17)=0;
b1(16)=0;
b1(15)=0;
b1(18)=0;
c1=max(b1)
