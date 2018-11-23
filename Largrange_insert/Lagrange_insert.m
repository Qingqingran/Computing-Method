n = input('Please input the value of n:');
x1 = zeros(1, n + 1);
x2 = zeros(1, n + 1);
f1 = zeros(1, n + 1);
f2 = zeros(1, n + 1);
y = zeros(1, 501);
temp1 = 0.00;
temp2 = 0.00;
L1 = 0.00;
L2 = 0.00;

% Caculate the value of all the independent variables and functions
for i = 1 : n + 1
    x1(i) = -5.00 + 10.00 / n * (i - 1);
    f1(i) = fun(x1(i));
    x2(i) = -5 * cos(double(2 * (i - 1) + 1)/(2 * n + 2) * pi);
    f2(i) = fun(x2(i));
end

% Caculate all the value of y
for i = 1 : 501
    y(i) = -5.00 + 10.0 / 500 * (i - 1);
end

% Caculate all the value of L interpolation
for k = 1 : 501
    % Caculate the form of L interpolation
    L1 = 0.00;
    L2 = 0.00;
    for i =1 : n + 1
        l1 = 1;
        l2 = 1;
        for j = 1 : n + 1
            if j ~= i
                l1 = l1 * (y(k) - x1(j))/(x1(i) - x1(j));
                l2 = l2 * (y(k) - x2(j))/(x2(i) - x2(j));
            end
        end
        L1 = L1 + l1 * f1(i);
        L2 = L2 + l2 * f2(i);
    end
   temp1 = max(temp1, abs(fun(y(k))  - L1));
   temp2 = max(temp2, abs(fun(y(k))  - L2));
end

fprintf("NO1. 节点个数：%d，最大模误差：%.15e\n",n,temp1);
fprintf("NO2. 节点个数：%d，最大模误差：%.15e\n",n,temp2);

% Caculate the value of function
function f = fun(a)
    f = 1.00 / (1 + power(a, 2));
end