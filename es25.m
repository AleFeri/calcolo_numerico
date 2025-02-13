% FUNZIONE DI RUNGE
f = @(x) 1./(1 + x.^2);

% INTERVALLO
a = -10;
b =  10;

% GRIGLIA FINE PER LA STIMA DELL'ERRORE
xfine = linspace(a, b, 10001);
ffine = f(xfine);

% VETTORI PER N E PER GLI ERRORI
n_values = 4:4:800;              % gradi "n" corrispondenti a (n+1) nodi
err_nat  = zeros(size(n_values));
err_nak  = zeros(size(n_values));
hvals    = zeros(size(n_values)); % passo h = (b-a)/n

% CICLO SUI VARI n
for k = 1:length(n_values)
    n = n_values(k);

    % ASCISSE UNIFORMI
    xi = linspace(a, b, n+1);
    fi = f(xi);

    % -------- SPLINE NATURALE --------
    % Assumendo di avere la function spline0(x, y, xx) 
    % che calcola la spline naturale e la valuta in xx:
    snat = spline0(xi, fi, xfine);

    % -------- SPLINE NOT-A-KNOT (built-in "spline") --------
    snak = spline(xi, fi, xfine);

    % ERRORE MASSIMO SU [a,b]
    err_nat(k) = max(abs(ffine - snat));
    err_nak(k) = max(abs(ffine - snak));

    % CALCOLIAMO IL PASSO h = 20 / n
    hvals(k) = (b - a) / n;
end

% ---------------- GRAFICO IN SCALA LOG-LOG ----------------
figure;
loglog(hvals, err_nat, 'b-o', 'LineWidth',1.2, 'MarkerFaceColor','b');
hold on;
loglog(hvals, err_nak, 'r-s', 'LineWidth',1.2, 'MarkerFaceColor','r');
hold off; 
grid on;
xlabel('Passo h = 20/n');
ylabel('Errore massimo di interpolazione');
title('Funzione di Runge su [-10,10] - Confronto spline naturale vs not-a-knot');
legend('Naturale','Not-a-Knot','Location','best');