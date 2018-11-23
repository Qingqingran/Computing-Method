clc
clear all

x = [];
y = [];
l = input('Please input the number of datas you want to calculate:');

for k = 1 : l  
    fprintf('x(%d) = ',k)
    m = input('');
    x = [x, m];
end

for k = 1 : l
    y(k) = 0.0;
    for n = 1 : sqrt(abs(1.0 - x(k))) * 1000
        y(k) = y(k) + (1.0 - x(k)) / double((n * (n + x(k)) * (n + 1)));
    end
    fprintf( 'y(%d) = %.15e\n', k, y(k) + 1);
end