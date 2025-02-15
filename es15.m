format long;
x0 = zeros(50, 1);
x = zeros(50, 3);
iterazioni = zeros(3, 1);

[x(:, 1), iterazioni(1)] = newton2(@fun, x0, 10.^(-3), 1000);
[x(:, 2), iterazioni(2)] = newton2(@fun, x0, 10.^(-8), 1000);
[x(:, 3), iterazioni(3)] = newton2(@fun, x0, 10.^(-13), 1000);

figure;
plot(1:50, x(:, 1), 'r', 'DisplayName', 'tol = 10^{-3}');
hold on;
plot(1:50, x(:, 2), 'g', 'DisplayName', 'tol = 10^{-8}');
plot(1:50, x(:, 3), 'b', 'DisplayName', 'tol = 10^{-13}');
hold off;
xlabel('Indice della radice');
ylabel('Valore di x');
title('Convergenza della soluzione con diverse tolleranze');

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