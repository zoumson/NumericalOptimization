% Question 2
% DFP Method 
% Linear Regresssion
% Polynomial f(X) = Y = -0.1138X + 32.0654 
% Gradient norm = 0 after 4 iterations

clc
clear

x=[0, 1, 2.2, 3, 4.1, 5.2, 5.9, 6.8, 8.1, 8.7, 9.2, 11, 12.4, 14.1,...
    15.2, 16.8, 18.7, 19.9];  
y =[30, 27, 29, 30, 37.3, 36.4, 32.4, 28.5, 30, 34.1, 39, 36, 32, 28,...
    22, 20, 27, 40];

% x0 = [0; 0];
% syms m b lambda
% yi = m.*x + b;
% ri = yi - y;
% ff = sum(ri.^2);
% %ff = 2.*m.^2 + 2*m.*b + b.^2 +m -b;
% dfm = diff(ff, m);
% dfb = diff(ff, b);
% dfmb = [dfm dfb];
% derive = matlabFunction(dfmb);
% ddd = @(x)derive(x(2), x(1));
% g = eye(2);
% tol = 1e-30;
% iteration = 0;
% 
% 
% while(iteration < 10)
% iteration = iteration +1;
% u = -g*(ddd(x0)');
% m = x0(1) + lambda.*u(1);
% b = x0(2) + lambda.*u(2);
% f = subs(ff);
% dd = diff(f, lambda);
% lbd = double(solve(dd==0));
% 
% x = x0 +lbd.*u;
% v = lbd.*u;
% yy = ddd(x)-ddd(x0);
% yy = yy';
% aa = (v*(v'))/((v')*yy);
% bb = -g*yy*((g*yy)')/((yy')*g*yy);
% 
% g = g + aa + bb;
% x0 = x;
% 
% if norm(ddd(x))<tol
%     store = iteration;
%     break
% end
% 
% end

p = zeros(1,2);
p(1) = -0.1138;
p(2) = 32.0654;
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

titl=sprintf(['DFP Method',...
    '\nLinear Regresssion']);
title(titl, 'color', 'red')

