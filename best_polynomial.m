%% Question 3: Polynomial Degree is 10
% Polynomial degree is increased every time to check see if the 
% corresponding least square is the minimum
% Degree 17 has the lowest square 7, but 17 is too big
% Degree 10 has a relative low Least square and degree
clc
clear

%% Data 
x=[0, 1, 2.2, 3, 4.1, 5.2, 5.9, 6.8, 8.1, 8.7, 9.2, 11, 12.4, 14.1,...
    15.2, 16.8, 18.7, 19.9];  
y =[30, 27, 29, 30, 37.3, 36.4, 32.4, 28.5, 30, 34.1, 39, 36, 32, 28,...
    22, 20, 27, 40];

n = length(x);
x0 = ones(n, 1);
x1 = x';
x2 = (x.^2)';
x3 = (x.^3)';
x4 = (x.^4)';
x5 = (x.^5)';
x6 = (x.^6)';
x7 = (x.^7)';
x8 = (x.^8)';
x9 = (x.^9)';
x10 = (x.^10)';

X = [x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10];
a = ((X')*X)\((X')*(y'));

f =@(t)a(1) + a(2).*t + a(3).*(t.^2)+ a(4).*(t.^3)+ a(5).*(t.^4)+ ...
    a(6).*(t.^5)+ a(7).*(t.^6)+ a(8).*(t.^7)...
    + a(9).*(t.^8)+ a(10).*(t.^9)+ a(11).*(t.^10);


yi =  a(1) + a(2).*x + a(3).*(x.^2)+ a(4).*(x.^3)+ a(5).*(x.^4)+ a(6).*(x.^5)+ a(7).*(x.^6)+ a(8).*(x.^7)...
    + a(9).*(x.^8)+ a(10).*(x.^9)+ a(11).*(x.^10);
ri = yi - y;
% The best polynomial will have the minimum Least square
Least_square = sum(ri.^2);

% Plot Data and Best Polynomial curve
h1 = figure(1);
% Data
plot1 = scatter(x, y, 100, '+', 'MarkerEdgeColor', 'red', 'linewidth', 5);
hold on
% Linear Regression Line
xx = linspace(0,20,100);
plot2 = plot(xx, f(xx), 'linewidth', 5);
[~,b] = legend([plot1 plot2],{'Real Data','Best Polynomial'}, 'FontSize',30);
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
title('Best Polynomial: Degree 10', 'color', 'r');



