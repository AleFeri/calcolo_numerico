close all; clearvars; clc;

% Definizione dell'intervallo x con molti punti per catturare il comportamento vicino a 4/3
x = linspace(1, 5/3, 100001); 

% Calcolo della funzione f(x)
f = 1 + x.^2 + log(abs(3*(1-x) + 1)) / 80;

% Individuazione del minimo
[min_f, idx_min] = min(f);
x_min = x(idx_min);
disp(['Il minimo della funzione si verifica in x = ', num2str(x_min), ' con valore f(x) = ' , num2str(min_f)]);

% Plot della funzione
figure;
plot(x, f, 'b', 'LineWidth', 1.5);
hold on;
plot(x_min, min_f, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Evidenzia il minimo
xlabel('x');
ylabel('f(x)');
title('Grafico di f(x) con evidenza del minimo');
grid on;

% Calcolo dei limiti destro e sinistro per x = 4/3
x_asintoto = 4/3;
epsilon = logspace(-10, -1, 100); % Sequenza di valori 100 tra 10^-10 e 10^-1 per avvicianrci pogressivamente a 4/3

% Limite sinistro (x -> 4/3^-)
x_left = x_asintoto - epsilon;
f_left = 1 + x_left.^2 + log(abs(3*(1-x_left) + 1)) / 80;

% Limite destro (x -> 4/3^+)
x_right = x_asintoto + epsilon;
f_right = 1 + x_right.^2 + log(abs(3*(1-x_right) + 1)) / 80;

% Stampa dei risultati
disp(['Limite sinistro (x → 4/3⁻): ', num2str(f_left(end))]);
disp(['Limite destro (x → 4/3⁺): ', num2str(f_right(end))]);

% Grafico dell'andamento vicino a x = 4/3 per lo studio della divergenza
figure;
semilogx(epsilon, f_left, 'b', 'LineWidth', 1.5);
hold on;
semilogx(epsilon, f_right, 'r', 'LineWidth', 1.5);
xlabel('Distanza da x = 4/3 (log scale)');
ylabel('f(x)');
legend('Limite sinistro', 'Limite destro');
title('Convergenza della funzione vicino a x = 4/3');
grid on;