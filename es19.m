% Nodi e coefficienti
X = [0, 1];
a = [1, 2, -1];

% Valutazione su un vettore di ascisse
xx = linspace(-1, 2, 100);
pvals = zeros(size(xx));
pders = zeros(size(xx));

for k = 1:length(xx)
    [pvals(k), pders(k)] = hornerDeriv(xx(k), a, X);
end

% Grafico dei risultati
figure;
plot(xx, pvals, 'b', 'LineWidth', 2); hold on;
plot(xx, pders, 'r--', 'LineWidth', 2);
legend('p(x)','p''(x)','Location','Best');
xlabel('x');
ylabel('valore');
title('Valutazione polinomio di Newton e derivata');
grid on;

% Verifica puntuale
x_test = 0.5;
[pval_test, pder_test] = hornerDeriv(x_test, a, X);
fprintf('Valore p(%.2f) = %.3f;  derivata p''(%.2f) = %.3f\n',...
    x_test, pval_test, x_test, pder_test);