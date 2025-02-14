% Fissiamo il seme per la riproducibilità
rng(0);

% Generazione dei dati
xi = linspace(0, 2*pi, 101);
yi = sin(xi) + rand(size(xi)) *.05;

% Calcolo dei coefficienti del polinomio di grado 3
% I coefficienti sono ordinati a partire da quello relativo al termine di grado 3
coeffs = polyfit(xi, yi, 3);
% Il polinomio ottenuto è:
%   p(x) = coeffs(1)*x^3 + coeffs(2)*x^2 + coeffs(3)*x + coeffs(4)
disp('Coefficienti del polinomio di grado 3:');
disp(coeffs);

% Calcolo dei valori del polinomio per un grafico più "liscio"
xi_fit = linspace(0, 2*pi, 1000);
yi_fit = polyval(coeffs, xi_fit);

% Plot dei dati originali e del polinomio di approssimazione
figure;
plot(xi, yi, 'bo', 'MarkerSize', 6, 'DisplayName', 'Dati');
hold on;
plot(xi_fit, yi_fit, 'r-', 'LineWidth', 2, 'DisplayName', 'Polinomio di grado 3');
xlabel('x');
ylabel('y');
title('Approssimazione ai minimi quadrati (grado 3)');
legend show;
grid on;