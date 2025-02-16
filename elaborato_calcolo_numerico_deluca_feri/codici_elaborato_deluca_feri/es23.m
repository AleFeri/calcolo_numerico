f = @(x) 1 ./ (1 + x.^2);

a = -5; 
b =  5;

nCheb = 2:2:100;

normLagr = zeros(size(nCheb));
normNewt = zeros(size(nCheb));

x_eval = linspace(a, b, 10001);
f_eval = f(x_eval);

for i = 1:length(nCheb)
    n = nCheb(i);

    x_cheb = chebyshev(n, a, b);

    f_nodes = f(x_cheb);

    f_lag = lagrange(x_cheb, f_nodes, x_eval);

    f_newt = newton3(x_cheb, f_nodes, x_eval);

    normLagr(i) = norm(f_eval - f_lag, 2);
    normNewt(i) = norm(f_eval - f_newt, 2);
end

figure;
semilogy(nCheb, normLagr, 'r-o', 'LineWidth',1.5, 'DisplayName','Lagrange');
hold on;
semilogy(nCheb, normNewt, 'b-o', 'LineWidth',1.5, 'DisplayName','Newton');
hold off;
grid on;
legend('Location','best');
xlabel('Grado del polinomio');
ylabel('Errore (norma 2)');
title('Errore di interpolazione della Funzione di Runge con nodi di Chebyshev');