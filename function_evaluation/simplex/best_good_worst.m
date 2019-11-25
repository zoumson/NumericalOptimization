function output = best_good_worst(x1, x2, x3)
    function y = f(x)
        y = (x(1).^2+x(2)-11).^2 + (x(2).^2+x(1)-7).^2;
    end
fx1 = f(x1);
fx2 = f(x2);
fx3 = f(x3);
fitVec = [x1; x2; x3];
fit = [fx1, fx2, fx3];
if fx1 == fx2 == fx3
    b = x1;bfit = fx1;
    g = x2;gfit = fx2;
    w = x3;wfit = fx3;
elseif fx1 == fx2
    if fx3 < fx1
        b = x3;bfit = fx3;
        g = x1;gfit = fx1;
        w = x2;wfit = fx2;
    else
        b = x1;bfit = fx1;
        g = x2;gfit = fx2;
        w = x3;wfit = fx3;
    end
elseif fx1 == fx3
        if fx2 < fx1
        b = x2;bfit = fx2;
        g = x1;gfit = fx1;
        w = x3;wfit = fx3;
    else
        b = x1;bfit = fx1;
        g = x3;gfit = fx3;
        w = x2;wfit = fx2;
        end
elseif fx2 == fx3
        if fx1 < fx2
        b = x1;bfit = fx1;
        g = x2;gfit = fx2;
        w = x3;wfit = fx3;
    else
        b = x2;bfit = fx2;
        g = x3;gfit = fx3;
        w = x1;wfit = fx1;
        end
else
bind = fit == min(fit);
b = fitVec(bind, :);
bfit = fit(bind);
wind = fit == max(fit);
w = fitVec(wind, :);
wfit = fit(wind);

gind = fit ~= wfit & fit ~= bfit ;
g = fitVec(gind, :);
gfit = fit(gind);
end

output = [b, bfit; g, gfit; w, wfit];

end