rng(0);

xi = linspace(0, 2*pi, 101);
yi = sin(xi) + rand(size(xi)) *.05;

coeff = polyfit(xi, yi, 3);

disp('Coefficienti del polinomio di grado 3:');
disp(coeff);

xi_fit = linspace(0, 2*pi, 1000);
yi_fit = polyval(coeff, xi_fit);

figure;
plot(xi, yi, 'bo', 'MarkerSize', 6, 'DisplayName', 'Dati');
hold on;
plot(xi_fit, yi_fit, 'r-', 'LineWidth', 2, 'DisplayName', 'Polinomio di grado 3');
xlabel('x');
ylabel('y');
title('Approssimazione ai minimi quadrati (grado 3)');
legend show;
grid on;