close all; clear all;

% ----------------------------
% Parameters & plotting setup
% ----------------------------
h = 0.01;   % grid spacing
xmax = 0.5;
ymax = 0.5;
[x,y] = meshgrid(-xmax:h:xmax,-ymax:h:ymax);

% Parameters of the example flow
mu = 1; % strength of the doublet

% Evaluate phi and psi using definition in **Cartesian** coordinates
phi = mu*x./(x.^2+y.^2);  % doublet's potential, phi(x,y)
psi = -mu*y./(x.^2+y.^2); % doublet's streamfunction, psi(x,y)

% Evaluate phi and psi using definition in **polar** coordinates
% but we need to first define (r,th) in terms of (x,y);
% when we call contour, we always send it x,y, but we can evaluate phi,psi using r,th
% NOTE: atan2(y,x) computes arctangent(y/x) taking into account the
% signs of x and y. This is important for the problems on the PSet. If you
% use atan(y/x), you might get funny results due to the 'branch cut' of atan.
r = sqrt(x.^2 + y.^2);
th = atan2(y,x);

phi = mu*cos(th)./r;  % doublet's potential, phi(r,th)
psi = -mu*sin(th)./r; % doublet's streamfunction, psi(r,th)

% Evaluate the velocity field (vr,vth) in polar coordinates
vr = -mu*cos(th)./(r.^2);
vth = -mu*sin(th)./(r.^2);
% IMPORTANT: transform velocities to Cartesian for streamslice
% (it will accept anything you give it, but your plot won't make sense)
vx = vr.*cos(th) - vth.*sin(th);
vy = vr.*sin(th) + vth.*cos(th);

% OR, instead of polar (vr,vth), you could also compute the Cartesian
% (vx,vy) from phi(x,y), which requires no transformation of velocity
vx = mu*1./(x.^2+y.^2) - mu*x./((x.^2+y.^2).^2).*(2*x);
vy = - mu*x./((x.^2+y.^2).^2).*(2*y);

% Optional: Mask a tiny disk around the origin if needed
% (to hide giant arrows near the singularity at r=0)
%mask = r < 1e-1;
%vx(mask) = 0; vy(mask) = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);

% Plot contours of equal phi, i.e., equipotential lines
% -10:10 specifies the values of phi chosen
contour(x,y,phi,-10:10,'r-',LineWidth=1);

hold on; % don't erase plot on next plot command

% Streamlines with velocity field arrows computed by numerically
% integrating the governing equation of streamlines, dy/dx = v/u
sl = streamslice(x,y,vx,vy,3);
set(sl,'LineWidth',1);

axis tight;
axis equal;
xlabel('$x$','FontSize',14,'Interpreter',"latex");
ylabel('$y$','FontSize',14,'Interpreter',"latex");
title('equipotential and stream lines for ideal flow due to doublet','FontSize',10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2);

% Plot velocity field arrows (not as nice as streamslice)
% using an arrow scaling factor (4th argument)
% also, take only every 4th point, so there's not too many arrows
quiver(x(1:4:end,1:4:end),y(1:4:end,1:4:end), ...
       vx(1:4:end,1:4:end),vy(1:4:end,1:4:end),5);

axis tight;
axis equal;
xlabel('$x$','FontSize',14,'Interpreter',"latex");
ylabel('$y$','FontSize',14,'Interpreter',"latex");
title('velocity field of ideal flow due to doublet','FontSize',10);
