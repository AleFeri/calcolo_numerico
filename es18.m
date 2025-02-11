% Definizione dei punti di interpolazione
xi = [0 1 2];
fi = [1 2 0];
f1i = [0 1 -1];

% Punti in cui valutare il polinomio interpolante
xx = linspace(-0.5, 2.5, 100);

yy = hermite(xi, fi, f1i, xx);

% Grafico della funzione interpolata
figure;
plot(xx, yy, 'b-', 'LineWidth', 2);
hold on;
plot(xi, fi, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
title('Interpolazione di Hermite');
xlabel('x');
ylabel('y');
grid on;
legend('Polinomio di Hermite', 'Punti dati');