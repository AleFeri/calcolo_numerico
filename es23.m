% Funzione di Runge
f = @(x) 1./(1 + x.^2);

% Intervallo di interpolazione
a = -5; 
b = 5;

% Gradi di interpolazione da testare
nn = 2:2:100;  % ad esempio i valori pari tra 2 e 100

% Griglia per la valutazione dell'errore
x_eval = linspace(a, b, 10001);
f_eval = f(x_eval);

% Vettore per memorizzare l'errore massimo
err_equi = zeros(size(nn));
err_cheb = zeros(size(nn));

% Ciclo sui vari gradi di interpolazione
for k = 1:length(nn)
    n = nn(k);
    
    x_equi = linspace(a, b, n+1);
    f_equi = f(x_equi);

    p_equi = lagrange_baricentrica(x_eval, x_equi, f_equi);
    
    err_equi(k) = max(abs(f_eval - p_equi));

    x_cheb = chebyshev(n, a, b);
    f_cheb = f(x_cheb);

    p_cheb = lagrange_baricentrica(x_eval, x_cheb, f_cheb);
    
    err_cheb(k) = max(abs(f_eval - p_cheb));
end

% Grafico dell'errore in scala logaritmica
figure;
semilogy(nn, err_equi, 'ro-', 'LineWidth', 1.2, 'DisplayName','Equidistanti');
hold on;
semilogy(nn, err_cheb, 'bo-', 'LineWidth', 1.2, 'DisplayName','Chebyshev');
hold off;
grid on;
xlabel('Grado del polinomio');
ylabel('Errore di interpolazione (norma infinito)');
title('Funzione di Runge su [-5,5]: confronto nodi equidistanti vs Chebyshev');
legend('Location','best');