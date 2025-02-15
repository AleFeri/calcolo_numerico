clc; clearvars; close all;

f  = @(x) exp(x/2 + exp(-x));
df = @(x) 0.5 * exp(exp(-x) - x/2) .* (-2 + exp(x));

xi  = [0, 2.5, 5];
fi  = f(xi);
f1i = df(xi);

x = linspace(0, 5, 200);
pvals = hermite(xi, fi, f1i, x);

xiH = repelem(xi, 2);   
fiH = repelem(fi, 2);
for i = 1:length(f1i)
    fiH(2*i) = f1i(i);
end

dd = difdivHermite(xi, fiH);

XforHorner = xiH(1:end-1);

dvals = zeros(size(x));
for k = 1:length(x)
    [~, dvals(k)] = hornerDeriv(x(k), dd, XforHorner);
end

figure('Name','Interpolazione di Hermite - Funzione e Derivata');
hold on;
plot(x, f(x),    'b-', 'LineWidth', 2, 'DisplayName','Funzione interpolanda');
plot(x, pvals,   'r--','LineWidth', 2, 'DisplayName','Polinomio interpolante');
plot(x, df(x),   'g-', 'LineWidth', 2, 'DisplayName','Derivata funzione');
plot(x, dvals,   'm--','LineWidth', 2, 'DisplayName','Derivata polinomio');
hold off;

xlabel('x'); 
ylabel('valore');
title('Interpolazione di Hermite e verifica della derivata');
legend('Location','best');
grid on;

disp('Verifica delle condizioni di Hermite nei nodi:');
for i = 1:length(xi)
    [pVal_i, dVal_i] = hornerDeriv(xi(i), dd, XforHorner);
    fprintf('x = %.2f: f = %g, p = %g,  df = %g, p'' = %g\n', ...
        xi(i), f(xi(i)), pVal_i, df(xi(i)), dVal_i);
end