clear;
clc;
%% Lagrange Method
format long
% Data set
tic
% Provide data with 2 rows, first is x, second is y for interpolation
file = xlsread('filename.csv');
dataIn = file(1, :);
dataOut = file(2, :);
l = length(dataIn);
pol = 0;
syms x
for i = 1:l
    tempPol =1;
    for j = 1:l
        if j == i
        else
            tempPol = tempPol*(x-dataIn(j))/(dataIn(i)-dataIn(j));
        end
        
    end
    
    tempPol = tempPol*dataOut(i);
    pol = pol + tempPol;
    
end
toc

x = 1980:1:2010;
y = subs(pol);
h = figure;
% Plot lagrange higher polynomial 
plot(x, y, 'Linewidth', 3, 'color', 'blue')
hold on
% Plot dataset
scatter(dataIn, dataOut,'+', 'LineWidth', 2, 'MarkerEdgeColor', 'red', 'Linewidth', 2)
xticks(dataIn)
sort_dataOut = sort(dataOut);
yticks(sort_dataOut);


xlabel('Years','color', 'red', 'fontSize', 25)
ylab=sprintf('Population\n(Millions)  ');
ylabel(ylab, 'color','red', 'fontSize', 25)
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
titl=sprintf('Lagrange Interpolation\nItaly Population Growth');
title(titl, 'color', 'red', 'fontSize', 25)
[~,b] = legend({'Lagrange Polynomial ','Real Data'}, 'FontSize',30);
set(findobj(b,'-property','MarkerSize'),'MarkerSize',30);

grid on
set(get(h,'CurrentAxes'),'GridAlpha',0.4);
