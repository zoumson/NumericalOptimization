%Try to transform n-dimensional search to 1-dimensional search
close all;
clear;
clc;

global  X FUNC S ndim
ndim=2; %suppose the objective function is 2-dimensional (that is, 2-variable)
ep = 10.^-6;
stop = 20;
ub = 4;
lb = -4;
FUNC=@myfunc;


for k = 1:4
        %Initial Guess and minimum point
        switch k
            case 1
    % First minimum x = 3.584428000000000, y = -1.848126000000000
    % f(3.584428, -1.848126) = 0
                X = [0;0];
            case 2
    % Second minimum x = 3, y = 2
    % f(3, 2) = 0
                X = [1;1];

            case 3
    % Third minimum x = -3.77931, y = -3.283186
    % f(-3.77931, -3.283186) = 0
                X = [-1;-1];
            case 4
    % Fourth minimum x = -2.805118, y = 3.131312
    % f(-2.805118,3.131312) = 0

                X = [-1;1];

        end




    sol = [X(1), X(2)];
    count = 0;
    while 1

        count = count +1;
        if count == stop 
            break;
        end
        S=[1;0];
        [nu,fMin] = goldSearch(@fLine,lb, ub) ;
        %here the initial interval for golden section is [-10, 10]. Actually you should use some algorithm to get a better initial interval.

        X=X+nu*S; % the next point
        X = round(X*10.^6)/10.^6;
        sol = [sol; X.'];
        si = size(sol);
        if si(1) == 1
        else
        if abs(sol(end, :)-sol(end-1, :))< ep
            break;
        end
        end
        S=[0;1];
        [nu,fMin] = goldSearch(@fLine,lb, ub) ;
        %If you use the Univariate method, the next search direction S=[0;1];
        %Anyway, keep searching (by using the while loop) until the stopping criterion is met.
        X=X+nu*S; % the next point
        X = round(X*10.^6)/10.^6;
        sol = [sol; X.'];
        si = size(sol);
        if si(1) == 1
        else
        if abs(sol(end, :)-sol(end-1, :))< ep
            break;
        end
        end
    end

    h = figure(k);
    x = sol(:,1);
    z = sol(:,2);
    plot(x, z, 'linewidth', 3)
    siz = size(sol);
    r = siz(1);
    hold on
    for i = 1: r
        if i == r
            text(x(i),z(i),'Last','Color','r', 'fontSize', 15)
        else
             text(x(i),z(i),num2str(i),'Color','r', 'fontSize', 15)
        end

    end

    xlabel('x-axis','color', 'red', 'fontSize', 25)

    ylabel('y-axis', 'color','red', 'fontSize', 25)
    hYLabel = get(gca,'YLabel');
    set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')
   
    titl = sprintf('Univariate: Using Golden Search  Method\nHimmelblau Function Minimum point\nf(x, y) = (x^2 + y - 11)^2 + (x + y^2 - 7)^2\nx = %.6f, y = %.6f', x(end), z(end));
    title(titl, 'color', 'red', 'fontSize', 25)

    grid on
    set(get(h,'CurrentAxes'),'GridAlpha',0.4);
    set(gca,'FontSize',20)
end
