
clc
clear

%% Boundary Temerature Initial Condition

Top_Side_Temp = 60;
Right_Side_Temp = 80;
Bottom_Side_Temp = 70;
Left_Side_Temp = 90;


% Solid dimensions 
WIDTH = 9;
LENGTH = 10;

% Interior points size, excluding points at the boundaries 
SIZE = (WIDTH-2)*(LENGTH-2);

% Initialize Temp to save all mesh temperature in 2D array
Temp = zeros(LENGTH, WIDTH);

% Use the Boundary condition to fill Temp borders

% Horizontal Borders
for i = 1:WIDTH
    
    % Top Side Horizontal Border
    Temp(1,i)      = Top_Side_Temp;
    
    % Bottom Side Horizontal Border
    Temp(LENGTH,i) = Bottom_Side_Temp;
end

% Vertical Borders
for j = 1:LENGTH
    
    % Left Side Vertical Border
    Temp(j,1)     =  Left_Side_Temp;
    
    % Right Side Vertical Border
    Temp(j,WIDTH) =  Right_Side_Temp;
end





%% Building Mesh --> SLE 

% Left Hand Side of SLE, LENGTH by WIDTH matrix 
LHS_SLE = 4*eye(SIZE);

% Right Hand Side of SLE, LENGTH*WIDTH by 1 column matrix
RHS_SLE = zeros(SIZE,1);

% index for RHS matrix 
INDEX = 0;
% Outer loop
x = 2;
while(x < LENGTH)
    
    % Inner loop
    y = 2;
    while(y < WIDTH)
        
        INDEX = INDEX + 1;
        Inner_Temp = zeros(SIZE);
        
        % Check left side and fill RHS_SLE 
        if x-1 == 1
            RHS_SLE(INDEX) = Temp(x-1,y) + RHS_SLE(INDEX);
        else
            Inner_Temp(x-1-1,y-1) = -1;
        end
        
        % Check right side and fill RHS_SLE 
        if x+1 == LENGTH
            RHS_SLE(INDEX) = Temp(x+1,y) + RHS_SLE(INDEX);
        else
            Inner_Temp(x-1+1,y-1) = -1;
        end
        
        % Check top side and fill RHS_SLE
        if y+1 == WIDTH
            RHS_SLE(INDEX) = Temp(x,y+1) + RHS_SLE(INDEX);
        else
            Inner_Temp(x-1,y-1+1) = -1;
        end
        
        % Check bottom side and fill RHS_SLE
        if y-1 == 1
            RHS_SLE(INDEX) = Temp(x,y-1) + RHS_SLE(INDEX);
        else
            Inner_Temp(x-1,y-1-1) = -1;
        end
        
        
        
        N = 0;
        % Fill in SLE Right Hand Side Matrix with Inner_Temp mesh
        for i = 1:LENGTH-2
            for j = 1:WIDTH-2
                N = N + 1;
                if LHS_SLE(INDEX,N) ~= 4
                    LHS_SLE(INDEX,N) = Inner_Temp(i,j);
                end
                
            end
        end  
    
    % Update Inner loop index y
    y = y + 1;
    end
    % Update Outer loop index x
    x = x + 1;
end


%% SLE Solving Method : Gauss Elimination
for j = 1:SIZE
    
    % Row Scaling and Exchange
    for i = j+1:SIZE
        % LHS_SLE(j,j) is pivot, scale down the remaining row
        PIVOT = -LHS_SLE(i,j)/LHS_SLE(j,j);
   
        % Row exchange , i by the pivot row j plus itself 
        RHS_SLE(i) = RHS_SLE(i) + PIVOT*RHS_SLE(j);
        LHS_SLE(i,:) = LHS_SLE(i,:) + PIVOT*LHS_SLE(j,:);
    end
end


% Gauss Substitution     
for i = SIZE:-1:1
    for j = i-1:-1:1
        PIVOT = -LHS_SLE(j,i)/LHS_SLE(i,i);
        RHS_SLE(j,1) = RHS_SLE(j,1) + PIVOT*RHS_SLE(i,1);
        LHS_SLE(j,:) = LHS_SLE(j,:) + PIVOT*LHS_SLE(i,:);
    end
end

% Calculate Temperature
 Temperature_1D = zeros(1, SIZE);
 for i = 1:SIZE
     Temperature_1D(i) = RHS_SLE(i)/LHS_SLE(i,i);
 end
 
% Change 1D Temperature to 2D Spatial Temperature Representation
 KEY = 0;
 for i = 2:LENGTH-1
     for j = 2:WIDTH-1
         KEY = KEY + 1;
         Temp(i,j) = Temperature_1D(KEY);         
     end
 end
 
 
% Reverse Temp for the plot
Reverse_Temp = zeros(LENGTH,WIDTH);

for j = 1:LENGTH
    Reverse_Temp(j,:) = Temp(LENGTH-j+1,:);
end

     
     
%% Plot Temperature on a 2D Graph 
 %figure('Renderer', 'painters', 'Position', [10 10 900 1000])
[Contour_Matrix, Contour_Object] = contour(Reverse_Temp,20, 'linewidth', 3);
clabel(Contour_Matrix, Contour_Object);
set(gca,'FontSize',20)
xlabel('WIDTH','color', 'r')

ylabel('LENGTH', 'color','red')
hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle',...
    'HorizontalAlignment','right')
title({'TEMPERATURE VARIATION', ''} , 'color', 'r');

