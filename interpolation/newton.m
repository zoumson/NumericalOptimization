clear;
clc;

tic 
% Provide data with 2 rows, first is x, second is y for interpolation
file = xlsread('filename.csv');

dataIn = file(1, :);
dataOut = file(2, :);
l = length(dataIn);
divDiff = zeros(l,l);

for i = 1:l
    if i == 1
        divDiff(1,:) = dataOut;
    else
        for j = 1:l-i+1
            divDiff(i, j)=(divDiff(i-1,j+1)-divDiff(i-1,j))/(dataIn(i+j-1)-dataIn(j));
        end
    end
end


%% pol(x)= divDiff1 +divDiff2(x-x1)+divDiff3(x-x1)(x-x2)+divDiffn(x-x1)...(x-xn-1)
% x is polynomial variable 
syms x
% pol(x) = 0, will store the accumulated products
pol = 0;

for k = 2:l
    %tempPol = (x-x0)(x-x1)..(x-xn-1)
    tempPol = 1;
    for m =1:k-1
    tempPol = tempPol*(x - dataIn(m));
    end
    %tempPol = divdiffk*(x-x0)(x-x1)..(x-xn-1)
    tempPol = tempPol*(divDiff(k,1));
    
    pol = pol + tempPol;
end
%Finally add the first divided difference coefficient
pol = pol + divDiff(1,1);
toc

%% Plot Newton Differential polynomial and dataset
x = 1980:1:2010;
y = subs(pol);

h = figure;
% Newton Differential polynomial
plot(x, y, 'Linewidth', 3)
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
titl=sprintf('Newton Divided Difference Interpolation\nItaly Population Growth');
title(titl, 'color', 'red', 'fontSize', 25)
[~,b] = legend({'Newton Divided Difference ','Real Data'}, 'FontSize',30);
set(findobj(b,'-property','MarkerSize'),'MarkerSize',30);

grid on
set(get(h,'CurrentAxes'),'GridAlpha',0.4);







