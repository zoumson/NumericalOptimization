clc;
clear;
close all;
fmin =@(x)(x.^2).*(cos(x));
fmax = @(x)(-1)*(x.^2).*(cos(x));
lb = 2;
ub = 12;
stop = 10^-7;
minimum  = goldSearch(fmin,lb,ub, stop);
maximum   = goldSearch(fmax,lb,ub, stop);
minimum_val = minimum(end);
maximum_val = maximum(end);
feval_min = minimum(1:end-1);
feval_max = -1*maximum(1:end-1);

l1 = length(feval_min);
l2 = length(feval_max);
x_axis2 = 1:l2;
x_axis1 = 1:l1;





h = figure;
subplot(2, 1, 1)
plot(x_axis1, feval_min, 'linewidth', 3, 'color', 'blue')

minf = min(feval_min);
maxf = max(feval_min);



yticks([minf, maxf]);

xlabel('Number of function evaluation ','color', 'red', 'fontSize', 25)
ylabel('Function f value', 'color','red', 'fontSize', 25)
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
titl=sprintf('Golden Search Method\nf(x) = x^2cos(x)\nFunction Minimum point x = %.4f, f(%.4f) = %.4f', minimum_val, minimum_val, minf);
title(titl, 'color', 'red', 'fontSize', 25)
grid on
grid minor 
set(get(h,'CurrentAxes'),'GridAlpha',0.4, 'MinorGridAlpha',0.9);
set(gca,'FontSize',20)

subplot(2, 1, 2)
plot(x_axis2, feval_max, 'linewidth', 3, 'color', 'green')

minf = min(feval_max);
maxf = max(feval_max);



yticks([minf, maxf]);



xlabel('Number of function evaluation ','color', 'red', 'fontSize', 25)
ylabel('Function f value', 'color','red', 'fontSize', 25)
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
titl=sprintf('Maximum point x = %.4f, f(%.4f) = %.4f', maximum_val, maximum_val, maxf);
title(titl, 'color', 'red', 'fontSize', 25)



grid on
grid minor 
set(get(h,'CurrentAxes'),'GridAlpha',0.4, 'MinorGridAlpha',0.9);
set(gca,'FontSize',20)