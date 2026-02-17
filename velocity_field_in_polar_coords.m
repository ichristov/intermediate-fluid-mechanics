close all; clear all;

% ----------------------------
% Parameters & plotting setup
% ----------------------------
h = 0.05;   % grid spacing
xmax = 2.0;
ymax = 2.0;
[x,y] = meshgrid(-xmax:h:xmax,-ymax:h:ymax);

% Polar coordinates
% Note: atan2(y,x) computes arctangent(y/x) taking into account the
% signs of x and y. This is important. If you use atan(y/x),
% you might get funny results due to the 'branch cut' of atan.
r = sqrt(x.^2 + y.^2);   % r = sqrt(x^2+y^2)
th = atan2(y,x);         % theta in (-pi,pi]

% -----------------------------------------
% Define your (vr, vθ) in polar coordinates
% -----------------------------------------
w = 1;
R = 1;
vr  =  0*r;    % vr = 0 in this example
vth =  0*r;    % empty initialization, for piecewise definition below
vth(r < R) = w*r(r < R);
vth(r >= R) = w*R^2./r(r >= R);

% ----------------------------------------------
% Convert to Cartesian: vx = vr cos θ - vθ sin θ
%                       vy = vr sin θ + vθ cos θ
% ----------------------------------------------
vx = vr .* cos(th) - vth .* sin(th);
vy = vr .* sin(th) + vth .* cos(th);

% Optional: Mask a tiny disk around the origin if needed
% (to hide giant arrows near the singularity at r=0)
%mask = r < 1.5*1e-3;
%vx(mask) = 0; vy(mask) = 0;

% -------------------------------------------------
% Plots: quiver (figure 1) & streamlines (figure 2)
% -------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);

% Quiver plot on a thinned grid, using skip, for clarity
skip = max(1, round(xmax/h/25));
quiver(x(1:skip:end,1:skip:end), y(1:skip:end,1:skip:end), ...
       vx(1:skip:end,1:skip:end), vy(1:skip:end,1:skip:end), 1.25, 'k');

axis equal tight; box on;
xlabel('$x$', 'FontSize', 14, 'Interpreter', 'LaTeX');
ylabel('$y$', 'FontSize', 14, 'Interpreter', 'LaTeX');
title('velocity vector field' ,'FontSize', 10);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);

% Speed (magnitude of velocity vector, |\underline{v}|)
speed = sqrt(vx.^2 + vy.^2);
hold on;

% Filled contours of |\underline{v}|
contourf(x, y, speed, 24, 'LineStyle','none');
colormap(parula);

% If you want a colorbar (note that it changes plot size)
cb = colorbar('Location','eastoutside');
cb.Label.Interpreter = 'LaTeX';
cb.Label.String = '$\sqrt{v_x^2 + v_y^2}$';
cb.Label.FontSize = 13;
clim([0, prctile(speed(:), 99)]);

% Streamlines with direction arrows computed by numerically
% using 'streamslice', which integrates the governing equation
% of streamlines, namely dy/dx = vy/vx
sl = streamslice(x, y, vx, vy);
set(sl, 'Color', 'k', 'LineWidth', 1);

axis equal tight; box on;
xlabel('$x$', 'FontSize', 14, 'Interpreter', 'LaTeX');
ylabel('$y$', 'FontSize', 14, 'Interpreter', 'LaTeX');
title('streamline plot' ,'FontSize', 10);
