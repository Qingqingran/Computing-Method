clc
syms x;
x0 = [0.1, 0.2, 0.9, 9.0];
x1 = [-0.1, -0.2, -2.0, 0.9];
x2 = [0.1, 0.2, 0.9, 9.0];
xa = 0.0;
ab = 0.0;
f = inline('x^3/3 - x', 'x');
df = diff(f(x));
epsilon = 1e-8;
%fi = inline('x - f(x) / diff(x)', 'x');
%dfi = diff(fi(x), 2);

gap = 1.0;
count = 0;
temp = 0;
a = 0;

fprintf("Newton 迭代算法:\n");
for i = 1 : 4
    gap  = 1.0;
    count = 0;
    xa = x0(i);
    while(gap >= epsilon)       
        xb = xa - f(xa)/subs(df, xa);
        gap = abs(xb - xa);
        temp = xa;
        xa = xb;
        count = count + 1;
    end
    fprintf("x0 = %2.1f 时，方程的根为: %15.e, 迭代步数为: %d\n", x0(i), xa, count);
    fprintf("x - a = %15.e, (x- a)^2 / 2 * dfi = %15.e\n", xb - a, (temp - a)^2 / 2 * diff((0 - f(0) / subs(df, 0)), 2));
end