clc
square = input("请输入增广矩阵：\n");
epsilon = input("请输入度量精度： ");
k = size(square);
dim = k(1);

fprintf("\n*************************************************\n*************************************************\nGauss-Seidel 迭代法:\n");
GS = Gauss_Seidel(square, dim, epsilon);
fprintf("\n迭代步数：%d\n", GS(dim + 1)) ;
fprintf("方程组的解: \n");
for i = 1 : dim
	fprintf("x%d = %.15e\n", i, GS(i));
end

fprintf("\n*************************************************\n*************************************************\nSOR 迭代法\n");
best = [0, 65535];
for i = 1 : 99
	SR = SOR(square, dim, epsilon, i / 50);
    if(SR(dim + 1) < best(2))
        best(1) = i / 50;
        best(2) = SR(dim + 1);
    end
	fprintf("\nw = %f, 迭代步数：%d\n", i / 50, SR(dim + 1)) ;
	fprintf("方程组的解: \n");
    for j = 1 : dim
		fprintf("x%d = %.15e\n", j, SR(j));
    end
    fprintf("\n*************************************************\n");
end
fprintf("最佳松弛因子为: %.15e, 迭代步数为: %d\n", best(1), best(2));

% Gauss_Seidel 迭代
function G = Gauss_Seidel(m, dim, epsilon)
	count = 0;
	x = ones(1, dim);
	y = zeros(1, dim);
	while(max(abs(x - y)) >= epsilon)
		count = count + 1;
		y = x;
		for i = 1 : dim
			x(i) = m(i, dim + 1) / m(i, i);
			for j = 1 : dim
				if(i ~= j)
					x(i) = x(i) - m(i, j) / m(i, i) * x(j);
				end
			end
		end
	end
	G = [x, count];
end

% SOR 迭代
function S = SOR(m, dim, epsilon, w)
	count = 0;
	x = ones(1, dim);
	y = zeros(1, dim);
	while(max(abs(x - y)) >= epsilon)
		count = count + 1;
		y = x;
		for i = 1 : dim		
            x(i) = (1 - w) * x(i) + w * (m(i, dim + 1) / m(i, i));
			for j = 1 : dim
				if(i ~= j)
					x(i) = x(i) - w * (m(i, j) / m(i, i) * x(j));
				end
            end
            
		end
	end
	S = [x, count];
end