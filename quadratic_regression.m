%% Question 1
%  Quadratic regression
%  Polynomial f(X) = Y =  -0.0255X^2 + 0.3911X + 30.4942

clc
clear
%% Data 
x=[0, 1, 2.2, 3, 4.1, 5.2, 5.9, 6.8, 8.1, 8.7, 9.2, 11, 12.4, 14.1,...
    15.2, 16.8, 18.7, 19.9];  
y =[30, 27, 29, 30, 37.3, 36.4, 32.4, 28.5, 30, 34.1, 39, 36, 32, 28,...
    22, 20, 27, 40];


syms a0 a1 a2

yq = a0 + a1.*x + a2.*(x.^2) ;
rq = yq - y;
f = sum(rq.^2);
fa0 = diff(f,a0);
fa1 = diff(f,a1);
fa2 = diff(f,a2);
sol = solve(fa0 == 0, fa1 == 0, fa2 == 0, a0, a1, a2);
a0 = sol.a0;
a1 = sol.a1;
a2 = sol.a2;

% Quadratic Regression  Curve Function

f =@(t)a0 + a1.*t + a2.*(t.^2);

% Plot Data and Quadratic Regression Curve
h2 = figure(2);
% Data
plot3 = scatter(x, y, 100, '+', 'MarkerEdgeColor', 'red', 'linewidth', 5);
hold on
% Quadratic Regression Curve
xx = linspace(0,20,100);
plot4 = plot(xx, f(xx), 'linewidth', 5);
[~,b] = legend([plot3 plot4],{'Real Data','Quadratic Regression'}, 'FontSize',30);
set(findobj(b,'-property','MarkerSize'),'MarkerSize',30);

xlabel('x-axis','color', 'k', 'fontSize', 25)
ylabel('y-axis', 'color','k', 'fontSize', 25)
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
grid on
grid minor
set(gca,'FontSize',20)
set(get(h2,'CurrentAxes'),'GridAlpha',0.8,'MinorGridAlpha',0.5);
xticks(x);
title('Quadratic Regression', 'color', 'r');