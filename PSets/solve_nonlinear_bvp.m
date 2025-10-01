%% This function solves the nonlinear boundary-value problem for the ODE
%% corresponding to the Blasius problem [Panton Eqs. (20.1.12), (20.1.13)].
%% The 3rd-order ODE is converted to a first-order system and solved
%% using MATLAB's built-in numerical BVP solvers.
%% See also Panton, pages 248--249 and Appendix E.

function solve_nonlinear_bvp
  % Specify the value of eta that we shall consider to be 'infinity'
  % for all practical purposes.
  inf = 6;

  % How many grid points we want to use between 0 and inf.
  ngrid = 100;

  % Constant guesses for initial function shape and its derivatives
  % on the domain for eta from 0 to inf using ngrid points;
  %
  % WARNING: if inf is too large, these initial gueses are no good,
  % and you'll get a different solution branch of the nonlinear ODE!
  %
  % [0 1 1] correspond to f = 0, f'= 1, and f'' = 1.
  solinit = bvpinit(linspace(0,inf,ngrid),[0 1 1]);

  % To tighten the tolerances on the solver and the make the
  % numerical solution more accurate.
  options = bvpset('RelTol',1e-9,'Stats','on');

  % Numerically solve the nonlinear BVP. ODEs are @fsode, and BCs are @fsbc.
  sol = bvp4c(@fsode,@fsbc,solinit,options);
  eta = sol.x;
  f = sol.y;

  % Numerically solve the nonlinear equation f'(eta) = 0.99 for eta99,
  % defined by @fp99eq, and using the BVP numerical solution for f',
  % from an initial guess eta99 = 1, and tighter-than-default tolerance.
  optopt = optimoptions('fsolve','OptimalityTolerance',1e-9,...
                        'Display','off');
  eta99 = fsolve(@(eta)fp99eq(eta,sol),1,optopt);

  %% We can check if our choice of infinity was good by computing on
  %% larger domains up to 2*inf, and seeing if f''(0) is converging.
  for infnew = inf:2*inf
    % 'bvpxtend' allows us to re-use the previous domain's solution as
    % a good initial guess for the solution on the new domain.
    solinit = bvpxtend(sol,infnew);
    sol = bvp4c(@fsode,@fsbc,solinit,options);
    f = sol.y;
    eta99 = fsolve(@(eta)fp99eq(eta,sol),1,optopt);
    fprintf('With inf = %g, f''''(0) = %7.10f and eta_99%% = %7.10f.\n\n',...
            infnew,f(3,1),eta99);
  end

  %% Make a plot of the solution from the longest domain used.
  % Evaluate numerical solutions for f, f' and f'' on a grid of [0 2inf].
  eta = linspace(0,2*inf,ngrid);
  f = deval(sol,eta,1);
  fprime = deval(sol,eta,2);
  fdoubleprime = deval(sol,eta,3);

  plot(fprime,eta,'-k','LineWidth',2);
  hold on;
  plot(0.5*(eta.*fprime - f),eta,'b--','LineWidth',2);
  plot(fdoubleprime,eta,'r-.','LineWidth',2);
  leg = legend('$f'' = u^*$', ...
               '$\frac{1}{2}(\eta f'' - f) = v^* \sqrt{x^*}$', ...
               '$f'''' = \sqrt{x^*} \partial u^*/\partial y^*$', ...
               'Location','N', ...
               'Interpreter','LaTeX');
  set(leg,'FontSize',10);
  ylabel('\eta \sim distance from the plate','FontSize',12);
  title('solution to Blasius'' problem','FontSize',10);
  grid on;
  xlim([-0.005,1.005]); % for clarity
  pbaspect([5 7 1]); % for clarity

%% The 3rd-order Blasius ODE, written as a first-order system.
%% This function spefies the right-hand side of the ODE.
%% Here: f(1) = f, f(2) = f', f(3) = f''.
function dfdeta = fsode(eta,f)
  dfdeta = [ f(2)
             f(3)
             -1/2*f(1)*f(3) ];

%% The BCs: f(0) = 0, f'(0) = 0, f'(finf) - 1 = 0
%% the solver expects BCs in the form stuff(f) = 0
%% with f0 an finf being the values at the two endpoints of the domain.
function res = fsbc(f0,finf)
  res = [ f0(1) - 0
          f0(2) - 0
          finf(2) - 1 ];

%% The algebraic equation for solving f' = 0.99 to find eta_99%.
function res = fp99eq(eta,sol)
    res = deval(sol,eta,2) - 0.99;
