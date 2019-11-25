


% Question 3
clc
clear
% Simplex method solution x1 = 0.2; x2 = 0; x3 = 1.6;
f = [3 1 3];
lb = zeros(1,3);
A = [2 1 1; 1 2 3; 2 2 1];
b = [2;5;6];


options = optimoptions('linprog','Algorithm','dual-simplex');
[x,~,~,~] = linprog(-f,A,b,[],[],lb,[], options);
Simplex_method_solution = x;


% Penalty method solution x1 = 0.2; x2 = 0; x3 = 1.6;

penalty = 10000*ones(1, 6);
violation_constant = 0.4;
x0 = zeros(1,3) ;
for i = 1:2
 g =@(x)      -(3*x(1) + x(2) + 3*x(3))...
              + penalty(1)*(max(0, -x(1)))^2 ...
              + penalty(2)*(max(0, -x(2)))^2 ...
              + penalty(3)*(max(0, -x(3)))^2 ...
              + penalty(4)*(max(0, (2*x(1) + x(2) + x(3)-2)))^2 ...
              + penalty(5)*(max(0, (x(1) + 2*x(2) + 3*x(3)-5)))^2 ...
              + penalty(6)*(max(0, (2*x(1) + 2*x(2) + x(3)-6)))^2;
x0 = fminsearch(g,x0);
penalty = violation_constant.*penalty;

end
Penalty_method_solution = x0;

