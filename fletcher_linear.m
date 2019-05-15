% Question 2
% Fletcher-Reeves conjugate gradient method
% Linear Regresssion
% Polynomial  f(X) = Y = -0.1386X + 32.3943
% Gradient norm  = 4.9 after  1000 iterations
clc
clear

x=[0, 1, 2.2, 3, 4.1, 5.2, 5.9, 6.8, 8.1, 8.7, 9.2, 11, 12.4, 14.1,...
    15.2, 16.8, 18.7, 19.9];  
y =[30, 27, 29, 30, 37.3, 36.4, 32.4, 28.5, 30, 34.1, 39, 36, 32, 28,...
    22, 20, 27, 40];

p0 = [0, 0];
syms m b lambda
yi = m.*x + b;
ri = yi - y;
% Least Square to be minimized
ff = sum(ri.^2);
%ff = 0.5.*m.^2 + m.*b + b.^2;
dfm = diff(ff, m);
dfb = diff(ff, b);
dfmb = [dfm dfb];
derive = matlabFunction(dfmb);
% Least square gradient vector 
ddd = @(p)derive(p(2), p(1));
% First Search Direction
u = -ddd(p0);
% Stop Criteria
tol = 0.001;
iteration = 0;

while(iteration < 1000)
iteration = iteration +1;
% Function f(p0 + lambda*u)
m = p0(1) + lambda.*u(1);
b = p0(2) + lambda.*u(2); 
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
    indep = iteration;
    break
end
end

% %  Plot without doing the above computation 
% 
% p = zeros(1,2);
% p(1)=0.1386;
% p(2) = 32.3943;
% Linear Regression  Line Function
f = @(t)p(1).*t + p(2);
% Plot Data and Linear Regression Line
h1 = figure(1);
% Data
plot1 = scatter(x, y, 100, '+', 'MarkerEdgeColor', 'red', 'linewidth', 5);
hold on
% Linear Regression Line
xx = linspace(0,20,100);
plot2 = plot(xx, f(xx), 'linewidth', 5);
[~,b] = legend([plot1 plot2],{'Real Data','Linear Regression'}, 'FontSize',30);
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
    '\nLinear Regresssion']);
title(titl, 'color', 'red')
