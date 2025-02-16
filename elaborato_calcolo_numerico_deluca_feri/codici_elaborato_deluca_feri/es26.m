f = @(x) 1./(1 + x.^2);

a = 0; 
b = 10;

xfine = linspace(a, b, 10001);
ffine = f(xfine);

n_values = 4:4:800;
err_nat = zeros(size(n_values));
err_nak = zeros(size(n_values));
hvals = zeros(size(n_values));

for k = 1:length(n_values)
    n = n_values(k);

    xi = linspace(a, b, n+1);
    fi = f(xi);

    snat = spline0(xi, fi, xfine);

    snak = spline(xi, fi, xfine);

    err_nat(k) = max(abs(ffine - snat));
    err_nak(k) = max(abs(ffine - snak));

    hvals(k) = (b - a) / n;
end

figure;
loglog(hvals, err_nat, 'b-+', 'LineWidth',1.2, 'MarkerFaceColor','b');
hold on;
loglog(hvals, err_nak, 'r-x', 'LineWidth',1.2, 'MarkerFaceColor','r');
hold off; 
grid on;
xlabel('h');
ylabel('Errore massimo di interpolazione');
title('Funzione di Runge su [0,10] - Confronto spline naturale vs not-a-knot');
legend('Naturale','Not-a-Knot','Location','best');