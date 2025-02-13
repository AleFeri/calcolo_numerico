% Gradi da considerare
nn = 1:100;

%% Intervallo [0,1]
a1 = 0; b1 = 1;

% Calcolo delle costanti di Lebesgue
ll_equidistant_01 = lebesgue(a1, b1, nn, 0);
ll_chebyshev_01    = lebesgue(a1, b1, nn, 1);

% Grafico per [0,1]
figure;
plot(nn, ll_equidistant_01, 'r-', 'LineWidth', 2);
hold on;
plot(nn, ll_chebyshev_01, 'b--', 'LineWidth', 2);
xlabel('Grado n');
ylabel('Costante di Lebesgue');
title('Costante di Lebesgue su [0,1]');
legend('Ascisse equidistanti','Ascisse di Chebyshev','Location','northwest');
grid on;

%% Intervallo [-5,8]
a2 = -5; b2 = 8;

% Calcolo delle costanti di Lebesgue
ll_equidistant_58 = lebesgue(a2, b2, nn, 0);
ll_chebyshev_58    = lebesgue(a2, b2, nn, 1);

% Grafico per [-5,8]
figure;
plot(nn, ll_equidistant_58, 'r-', 'LineWidth', 2);
hold on;
plot(nn, ll_chebyshev_58, 'b--', 'LineWidth', 2);
xlabel('Grado n');
ylabel('Costante di Lebesgue');
title('Costante di Lebesgue su [-5,8]');
legend('Ascisse equidistanti','Ascisse di Chebyshev','Location','northwest');
grid on;