nn = 1:100;

% Intervallo [0,1]
figure;
semilogy(nn, lebesgue(0, 1, nn, 1), 'b-', 'LineWidth', 1.5, ...
    'DisplayName', 'Chebyshev [0,1]');
hold on;
semilogy(nn, lebesgue(0, 1, nn, 0), 'r--', 'LineWidth', 1.5, ...
    'DisplayName', 'Equidistanti [0,1]');
hold off;
grid on;
xlabel('Grado del polinomio');
ylabel('Costante di Lebesgue');
title('Costante di Lebesgue su [0,1]');
legend('Location','best');

% Intervallo [-5,8]
figure;
semilogy(nn, lebesgue(-5, 8, nn, 1), 'b-', 'LineWidth', 1.5, ...
    'DisplayName', 'Chebyshev [-5,8]');
hold on;
semilogy(nn, lebesgue(-5, 8, nn, 0), 'r--', 'LineWidth', 1.5, ...
    'DisplayName', 'Equidistanti [-5,8]');
hold off;
grid on;
xlabel('Grado del polinomio');
ylabel('Costante di Lebesgue');
title('Costante di Lebesgue su [-5,8]');
legend('Location','best');