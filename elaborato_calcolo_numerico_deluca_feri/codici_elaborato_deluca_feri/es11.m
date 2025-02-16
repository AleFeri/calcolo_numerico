close all; clearvars; clc;

results = zeros(15, 2);

for n = 1:15
    [A, b] = genera_matrice_vettore(n);

    condizionamento_2 = cond(A);
    display(num2str(condizionamento_2));
    
    x_exact = ones(n, 1);
    
    x_computed = mialu(A, b);
end

function [A, b] = genera_matrice_vettore(n)
    A = zeros(n, n);
    for i = 1:n
        for j = 1:n
            A(i, j) = 10^max(i - j, 0);
        end
    end
    
    b = zeros(n, 1);
    for i = 1:n
        b(i) = n - i + (10^i - 1) / 9;
    end
end