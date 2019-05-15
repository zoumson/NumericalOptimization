%% Question 1
%  Linear regression
%  Polynomial f(X) = Y =  -0.1138X + 32.0654

clc
clear
%% Data 
x=[0, 1, 2.2, 3, 4.1, 5.2, 5.9, 6.8, 8.1, 8.7, 9.2, 11, 12.4, 14.1,...
    15.2, 16.8, 18.7, 19.9];  
y =[30, 27, 29, 30, 37.3, 36.4, 32.4, 28.5, 30, 34.1, 39, 36, 32, 28,...
    22, 20, 27, 40];


syms m b
yi = m.*x + b;
ri = yi - y;
f = sum(ri.^2);
fm = diff(f,m);
fb = diff(f,b);
sol = solve(fm == 0, fb == 0, m, b);
b = double(sol.b);
m = double(sol.m);
% Linear Regression  Line Function
f = @(t)m.*t + b;
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
title('Linear Regression', 'color', 'r');