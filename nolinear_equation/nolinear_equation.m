clc
syms x;
x0 = [0.1, 0.2, 0.9, 9.0]; % 牛顿迭代法的初始条件
x1 = [-0.1, -0.2, -2.0, 0.9]; % 弦截法的初始条件 x0
x2 = [0.1, 0.2, 0.9, 9.0]; % 弦截法的初始条件 x1
f = inline('x^3/3 - x', 'x'); % 待求解函数
df = diff(f(x)); % 待求解函数的导数
epsilon = 1e-8; % 精度要求

a = 0;

fprintf("Newton 迭代算法:\n");
l = length(x0);
for i = 1 : l
    new = Newton(f, df, x0(i), epsilon);
    fprintf("x0 = %f 时，方程的根为: %.15e, 迭代步数为: %d, ", x0(i), new(1), new(2));
    fprintf("收敛阶验证: C = %.15e\n", abs(new(1) - x0(i)) / abs(new(3) - x0(i)));
end

fprintf("弦截法：\n");
l = length(x1);
for i = 1 : l
    sec = Secant(f, x1(i), x2(i), epsilon);
    fprintf("x0 = %f, x1 = %f 时，方程的根为: %.15e, 迭代步数为: %d, ", x1(i), x2(i), sec(1), sec(2));
    fprintf("收敛阶验证:C = %.15e\n", abs(sec(1) - (x2(i) + x1(i)) / 2) / abs(sec(3) - (x2(i) + x1(i)) / 2)^((1 + sqrt(5)) / 2));
end

% 牛顿迭代法
function Nt = Newton(f, df, x, epsilon)
    count = 0;
    temp = 0;
    while(abs(temp - x) >= epsilon)
        temp = x;
        x = x - f(x) / subs(df, x);
        count = count + 1;
    end
    Nt = [x, count, temp];
end

% 弦截法
function Sc = Secant(f, x1, x2, epsilon)
    count = 0;
    while(abs(x2 - x1) >= epsilon && abs(f(x2)) >= epsilon)
        temp = x2;
        x2 = x2 - f(x2) * (x2 - x1)/(f(x2) - f(x1));
        x1 = temp;
        count = count + 1;
    end
    Sc = [x2, count, x1];
end