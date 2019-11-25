
clc;
clear;
close all;
format short g;
%% Simplex 
% For the graph visualization please set stop to 10 but no optimal point 

% For accurate minimum point please set stop to 100


for k = 1:4
    switch k
        case 1
% First minimum x = 3.584428000000000, y = -1.848126000000000
% f(3.584428, -1.848126) = 0

 
            v1 =[2, -2];
            v2 =[2, -1];
            v3 =[5, -5];
        case 2
% Second minimum x = 3, y = 2
% f(3, 2) = 0

            v1 =[1, 0];
            v2 =[-1.4, -1.4];
            v3 =[0, 1];

        case 3
% Third minimum x = -3.77931, y = -3.283186
% f(-3.77931, -3.283186) = 0
            
            v1 =[1, 0];
            v2 =[-2, -2];
            v3 =[0, 1];
        case 4
% Fourth minimum x = -2.805118, y = 3.131312
% f(-2.805118,3.131312) = 0

            v1 =[-1, 1];
            v2 =[1, -1];
            v3 =[0.55, 0.55];

    end

stop = 100;
triangles = [];
count = 0;
while 1

    count = count + 1;
    if count ==  stop
        break
    end
    if count == 1
        % Find best, good, worst in initial guess
        rank = best_good_worst(v1, v2, v3);

    else % New worst could be wether best, good or stay worst in current tuple
        rank = best_good_worst(b, g, w);
    end
    
    % First row of rank is the best
    b = rank(1,1:2);
    bfit = rank(1, 3);
    % Second row of rank is the good
    g = rank(2,1:2);
    gfit = rank(2, 3);
    % Third row of rank is the worst
    w = rank(3,1:2);
    wfit = rank(3, 3);
    % Make a cyclic triangle set points [b, g, w, b]
    % c is the simplex of the triangle 
    cx = (b(1)+ g(1) + w(1))./3;
    cy = (b(2)+ g(2) + w(2))./3;
    put = [b(1), g(1), w(1), b(1), cx; b(2), g(2), w(2), b(2), cy];
    triangles = [triangles; put];
    % Middle point of best and good
    m = (b+g)./2;
    m = round(m.*10.^6)/10.^6;
    % Worst reflected respect to middle
    r = reflect(m, w);
    r = round(r.*10.^6)/10.^6;
    rfit = f(r);
    if (rfit < wfit)
        w = r;
        e = expand(r, m);
        e = round(e.*10.^6)/10.^6;
        efit = f(e);
        if (efit < rfit)
            w = e;  
        end

    else

        c1 = contract(w, m);
        c2 = contract(m, r);
        c = min(c1, c2);
        c = round(c.*10.^6)/10.^6;
        cfit = f(c);
        if (cfit < wfit)
            w = c;
        else
            s = shrink(b, w);
            s = round(s.*10.^6)/10.^6;
            w = s;
            g = m;
        end

    end
end


h = figure(k);
% Plot Triangles 
for i = 1: stop*2-2
    if i == stop*2-2
        break;
    end
    plot(triangles(i,1:4), triangles(i+1,1:4), 'linewidth', 3)
    hold on 
end

hold on

% Simplex Annotation 
for ii = 1: stop*2-2
    if ii == stop*2-2
        break;
    end
    % Last Simplex, minimum point 
    if ii == stop*2-3
        text(triangles(ii, 5)+0.1,triangles(ii+1, 5)+0.1,'Last','Color','g', 'fontSize', 15)
        plt = scatter(triangles(ii, 5),triangles(ii+1, 5),25, '*');
        hold on
    else
        text(triangles(ii, 5),triangles(ii+1, 5),num2str(ii),'Color','k', 'fontSize', 15)
        scatter(triangles(ii, 5)+0.1,triangles(ii+1, 5)+0.1,25,  '*')
        hold on
    end
    
end




xlabel('x-axis','color', 'red', 'fontSize', 25)

ylabel('y-axis', 'color','red', 'fontSize', 25)
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',  'HorizontalAlignment','right')

titl = sprintf('Nelder-Mead Method\nHimmelblau Function Minimum point\nf(x, y) = (x^2 + y - 11)^2 + (x + y^2 - 7)^2\nf(%.6f , %.6f) = %.6f', b(1), b(2), bfit);
title(titl, 'color', 'red', 'fontSize', 25)



grid on
set(get(h,'CurrentAxes'),'GridAlpha',0.4);
set(gca,'FontSize',20)
[~,ll] = legend(plt,{'\color{blue}Simplex'}, 'color','y', 'fontsize', 25);
set(findobj(ll,'-property','MarkerSize'),'MarkerSize',10, 'markeredgecolor', 'k');

end
