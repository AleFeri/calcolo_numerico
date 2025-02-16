clc; clearvars; close all;

tolleranze = [1e-3, 1e-8, 1e-13];
iterazioni = zeros(length(tolleranze), 1);

x0 = zeros(50, 1);
x = zeros(50, length(tolleranze));

for i = 1:length(tolleranze)
    [x(:, i), iterazioni(i)] = newton2(@fun, x0, tolleranze(i), 1000);
end

fprintf('Tolleranza\tIterazioni\n');
for i = 1:length(tolleranze)
    fprintf('10^{%d}\t\t%d\n', log10(tolleranze(i)), iterazioni(i));
end

figure;
colors = {'r', 'g', 'b'};
hold on;
for i = 1:length(tolleranze)
    plot(1:50, x(:, i), colors{i}, 'DisplayName', ...
        sprintf('tol = 10^{%d}', log10(tolleranze(i))));
end
hold off;
xlabel('Indice della radice');
ylabel('Valore di x');
title('Convergenza della soluzione con diverse tolleranze');
legend('Location', 'best');

function [f, jacobian] = fun(x)
% fun - Calcola il gradiente e l’Hessiana di f(x)
    x = x(:);
    n = length(x);
    Q = 4 * eye(n) + diag(ones(n-1, 1), 1) + diag(ones(n-1, 1), -1);
    e = ones(n, 1);
    alpha = 2;
    beta = -1.1;

    grad = @(x) Q * x - alpha * e .* sin(alpha * x) - beta * e .* exp(-x);
    
    Jac = @(x) Q - alpha^2 * diag(e .* cos(alpha * x)) + beta * diag(e .* exp(-x));
    
    f = grad(x);
    jacobian = Jac(x);
end