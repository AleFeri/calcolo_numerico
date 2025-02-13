% Definizione della funzione e della sua derivata
f  = @(x) exp(x/2 + exp(-x));
df = @(x) 0.5*exp(exp(-x) - x/2).*(-2 + exp(x));

% Nodi di interpolazione
x = linspace(0, 5, 1000);
xi = [0, 2.5, 5];
fi  = f(xi);
f1i = df(xi);

plot(x , f(x), "DisplayName", "Funzione interpolanda");
hold on

plot(x, hermite(xi, fi, f1i, x), "--", "DisplayName", "Polinomio di interpolazione");
hold on

plot(x, df(x), "DisplayName", "Derivata dalla funzione");
hold on

xiRaddoppiato = repelem(xi, 2);
fi = repelem(fi, 2);
for i = 1:length(f1i)
    fi (i*2) = f1i(i);
end
dd = difdivHermite(xi,fi);

plot(x, hornerDeriv(xiRaddoppiato, dd, x), "--", "DisplayName", "Derivata del polinomio");
hold off

legend("Location", "best");
