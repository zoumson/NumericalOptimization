%x = [0 1 2 3];
clc
clear
tic
% Provide data with 2 rows, first is x, second is y for interpolation
aa = xlsread('filename.csv');


dataIn = aa(1, :);
dataOut = aa(2, :);


m = length(dataIn);

h = zeros(1, m-1);
for i = 1:m-1
    h(i) = dataIn(i+1)-dataIn(i);
end

%a = [1 exp(1) exp(2) exp(3)];
b = zeros(m, 1);

for i = 1:m
    if i == 1 || i == m
        b(i) = 0;
    else
        b(i) = (3/h(i))*(dataOut(i+1)-dataOut(i))-(3/h(i-1))*(dataOut(i)-dataOut(i-1));
    end
end


A = diag(ones(1, m));

for i = 2:m-1
    A(i, i-1) = h(i-1);
    A(i,i) = 2*(h(i-1)+h(i));
    A(i,i+1) = h(i);
end


%% LU factorization
l = zeros(m);
u = diag(ones(1,m));

for i = 1:m
    if i==1
        l(i,i) = A(i, i);
        u(i,i+1) = A(i, i+1)/l(i, i);
    elseif i == m
        l(i, i-1) = A(i, i-1);
        l(i,i) = A(i,i)-l(i,i-1)*u(i-1,i);
    else
        l(i, i-1)=A(i, i-1);
        l(i,i) = A(i,i)-l(i,i-1)*u(i-1,i);
        u(i, i+1)= A(i, i+1)/l(i, i);
    end
end
%% Solving LZ = b
z = zeros(m,1);
for i = 1:m
    if i == 1
        z(i) = b(i)/l(i,i);
    else
        z(i) = (b(i)-z(i-1)*l(i,i-1))/l(i,i);
    end
end

%% Solving UX = Z
c = zeros(m,1);

for i = m:-1:1
    if i == m
       c(i)=z(i);
    else
       c(i) = z(i)-u(i, i+1)*c(i+1);
    end
end


bb = zeros(m-1,1);

for i = 1:m-1
    bb(i)= (1/h(i))*(dataOut(i+1)-dataOut(i))-(h(i)/3)*(c(i+1) + 2*c(i));
end

dd = zeros(m-1,1);
for i = 1:m-1
    dd(i) = (1/(3*h(i)))*(c(i+1)-c(i));
end

syms v s

for i = 1:m-1
    s(i) = dataOut(i)+bb(i)*(v-dataIn(i))+ c(i)*(v-dataIn(i)).^2+ dd(i)*(v-dataIn(i)).^3;
end
toc

%% Plot cubic splines and datasets
h = figure;
for i = 1:m-1
    
v = dataIn(i):0.2:dataIn(i+1);
yax = subs(s(i));

plot1 = plot(dataIn(i):0.2:dataIn(i+1), yax, 'Linewidth', 3, 'color', 'blue');

hold on
end

hold on
plot2 = scatter(dataIn, dataOut,'+', 'LineWidth', 2, 'MarkerEdgeColor', 'red', 'Linewidth', 2);

xticks(dataIn)
sort_dataOut = sort(dataOut);
yticks(sort_dataOut);


xlabel('Years','color', 'red', 'fontSize', 25)
ylab=sprintf('Population\n(Millions)  ');
ylabel(ylab, 'color','red', 'fontSize', 25)
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
titl=sprintf('Cubic Spline Interpolation\nItaly Population Growth');
title(titl, 'color', 'red', 'fontSize', 25)
[~,b] = legend([plot1 plot2],{'Cubic Spline  ','Real Data'}, 'FontSize',30);
set(findobj(b,'-property','MarkerSize'),'MarkerSize',30);

grid on
set(get(h,'CurrentAxes'),'GridAlpha',0.4);





