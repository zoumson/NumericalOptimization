%% Question 4
% Creative model f(X) = (aX + bX^2 + cX^3)*(cos(dX)) + e
% f(X) = (-1.9738X + 0.3326X^2 - 0.0100X^3)*cos(0.5826X) + 31.1449

clc
clear

%% Data 
x=[0, 1, 2.2, 3, 4.1, 5.2, 5.9, 6.8, 8.1, 8.7, 9.2, 11, 12.4, 14.1,...
    15.2, 16.8, 18.7, 19.9];  
y =[30, 27, 29, 30, 37.3, 36.4, 32.4, 28.5, 30, 34.1, 39, 36, 32, 28,...
    22, 20, 27, 40];


yc = @(c)sum((((c(1).*x + c(2).*(x.^2)+ c(3).*(x.^3)).*cos(c(4).*x) +...
    c(5) )-y).^2);

x0 = [20, 2, 1, 0.5, 10];
[t, fval] = fminsearch(yc,x0);
%f(x) = (ax + bx^2 + cx^3)*(cos(dx)) + e
%Amplitude  = ax + bx^2 + cx^3
%Frequency = dx
%Offset = e
f = @(m)(t(1).*m + t(2).*(m.^2)+ t(3).*(m.^3)).*cos(t(4).*m) + t(5);


h  = figure;
plot9 = scatter(x, y, 100, '+', 'MarkerEdgeColor', 'red', 'linewidth', 5);
hold on
xx = linspace(0,20,100);
plot10 = plot(xx, f(xx), 'linewidth', 5);
[~,b] = legend([plot9, plot10],{'Real Data','Best Fit Curve'},...
                                                          'FontSize',30);
set(findobj(b,'-property','MarkerSize'),'MarkerSize',30);

xlabel('x-axis','color', 'k', 'fontSize', 25)
ylabel('y-axis', 'color','k', 'fontSize', 25)
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',...
                                            'HorizontalAlignment','right')
grid on
grid minor
set(gca,'FontSize',20)
set(get(h,'CurrentAxes'),'GridAlpha',0.8,'MinorGridAlpha',0.5);
xticks(x);
title('Creative Model', 'color', 'r');
