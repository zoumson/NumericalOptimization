% Question 2
% Fletcher-Reeves conjugate gradient method
% Quadratic regression 
% Polynomial f(X) = Y = -0.0286X^2 + 0.3971X + 31.2922
% Gradient norm  = 1.8877-11 after 5000 iterations
clc
clear
% Iteration = 200, delta = 150
% Polynomial = -0.2753    6.3677    1.8057 
x=[0, 1, 2.2, 3, 4.1, 5.2, 5.9, 6.8, 8.1, 8.7, 9.2, 11, 12.4, 14.1,...
    15.2, 16.8, 18.7, 19.9];  
y =[30, 27, 29, 30, 37.3, 36.4, 32.4, 28.5, 30, 34.1, 39, 36, 32, 28,...
    22, 20, 27, 40];

p0 = [0, 0, 0];
syms m b c lambda
yi = m.*(x.^2) + b.*x + c;
ri = yi - y;
% Least Square to be minimized
ff = sum(ri.^2);
%ff = 0.5.*m.^2 + m.*b + b.^2;
dfm = diff(ff, m);
dfb = diff(ff, b);
dfc = diff(ff, c);
dfmbc = [dfm dfb dfc ];
derive = matlabFunction(dfmbc);
% Least square gradient vector 
ddd = @(p)derive(p(2),p(3), p(1));
% First Search Direction
u = -ddd(p0);
% Stop Criteria
tol = 0.001;
iteration = 0;

while(iteration < 5000)
iteration = iteration +1;
% Function f(p0 + lambda*u)
m = p0(1) + lambda.*u(1);
b = p0(2) + lambda.*u(2);
c = p0(3) + lambda.*u(3); 
f = subs(ff);
% Line search
dd = diff(f, lambda);
% lbd minimizes f(p0 + lambda*u) 
lbd = double(solve(dd==0));
% p = p0 + lambda*u
p = p0 +lbd.*u;
p0 = p;
beta =  (norm(ddd(p0))./norm(ddd(p))).^2;
% Nept Search Direction
u = -ddd(p) + beta.*u;
% Stop Criteria
if norm(ddd(p))<tol
    strore = iteration;
    break
end
end
% % Plot without doing the above computation 
% p = zeros(1,3);
% p(1) = -0.0286;
% p(2) = 0.3971;
% p(3) = 31.2922;
% Linear Regression  Line Function
f = @(t)p(1).*(t.^2) + p(2).*t + p(3);
% Plot Data and Linear Regression Line
h1 = figure(1);
% Data
plot1 = scatter(x, y, 100, '+', 'MarkerEdgeColor', 'red', 'linewidth', 5);
hold on
% Linear Regression Line
xx = linspace(0,20,100);
plot2 = plot(xx, f(xx), 'linewidth', 5);
[~,b] = legend([plot1 plot2],{'Real Data','Quadratic Regression'}, 'FontSize',30);
set(findobj(b,'-property','MarkerSize'),'MarkerSize',30);

xlabel('x-axis','color', 'k', 'fontSize', 25)
ylabel('y-axis', 'color','k', 'fontSize', 25)
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
grid on
grid minor
set(gca,'FontSize',20)
set(get(h1,'CurrentAxes'),'GridAlpha',0.8,'MinorGridAlpha',0.5);
xticks(x);
%title('Linear Regression', 'color', 'r');

titl=sprintf(['Fletcher-Reeves conjugate gradient method',...
    '\nQuadratic regression ']);
title(titl, 'color', 'red')



