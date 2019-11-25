function mini = dichotomous(f,lb,ub,stop) 


    if (nargin < 3)
        error('Less number of inputs');
    elseif (nargin > 4)
        error('Too many input arguments')
    else
        if (nargin == 3)
            stop = 10.^-2;
        end
        sol = [];
        while 1
                m = (lb + ub)/2;
                epsilon = 10.^-6;
                lb1 = m - epsilon;
                ub1 = m + epsilon;
                if (f(lb1) < f(ub1))
                    ub = ub1;
                elseif (f(lb1) > f(ub1))
                    lb = lb1;
                elseif (f(lb1) == f(ub1))
                    lb = lb1;
                    ub = ub1;
                end
                diff = ub-lb;
                 minim = min(lb,ub);
                fminim = f(minim);
                sol = [sol;fminim];
                if diff < stop
                    sol(end) = [];
                    break
                end
        end
        minval = min(lb,ub);
        mini = [sol;minval];
 %       mini = f(min(lb,ub));

    end
end