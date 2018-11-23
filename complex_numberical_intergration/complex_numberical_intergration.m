clc
syms x;
f = inline('sin(x)', 'x');
If = int(sin(x), x, 1, 5);

T = zeros(1, 12);
S = zeros(1, 12);
E1 = zeros(1, 12);
E2 = zeros(1, 12);
o21 = zeros(1, 11);
o22 = zeros(1, 12);

for l = 1 : 12
    n = power(2 ,l);
    m = power(2, l - 1);
    h = 4 / n;
    for x = 1 + h : h : 5 - h
        T(l) = T(l) + h * f(x); 
    end
    T(l) = T(l) + h / 2 * (f(1) + f(5));
    E1(l) = If - T(l);
    for x = 1 + 2 * h : 2 * h : 5 - 2 * h
        S(l) = S(l) + h / 3 * 2 * f(x);
    end
    for x = 1 + h : 2 *h : 5 - h
        S(l) = S(l) + h / 3 * 4 * f(x);
    end
    S(l) = S(l) + h / 3 * (f(1) + f(5));
    E2(l) = If - S(l);
end
 
for i = 1 : 11
    o21(i) = log(E1(i) / E1(i + 1)) / log(2);
    o22(i) = log(E2(i) / E2(i + 1)) / log(2);
end

fprintf("复化梯形积分为：\n");
for l = 1 : 11   
    fprintf("N = %-4d, 积分值: %.15e, 误差: %.15e, 误差阶: %.15e\n", power(2, l) + 1, T(l), E1(l), o21(l));
end
fprintf("N = %-4d, 积分值: %.15e, 误差: %.15e\n", power(2, 12) + 1, T(12), E1(12));
fprintf("\n复化辛普森积分为：\n");
for l = 1 : 11
    fprintf("N = %-4d, 积分值: %.15e, 误差: %.15e, 误差阶: %.15e\n", power(2, l) + 1, S(l), E2(l), o22(l));
end
fprintf("N = %-4d, 积分值: %.15e, 误差: %.15e\n", power(2, 12) + 1, S(12), E2(12));