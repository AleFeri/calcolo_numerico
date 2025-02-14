% FUNZIONE DI RUNGE
f = @(x) 1./(1 + x.^2);

% ESTREMI DELL'INTERVALLO
a = 0; 
b = 10;

% GRIGLIA FINE (10001 PUNTI) PER STIMARE L'ERRORE
xq = linspace(a, b, 10001);
fxq = f(xq);

% VETTORE DI n (NUMERO DI SOTTOINTERVALLI)
nValues = 4:4:800;

% PREALLOCAZIONE DEGLI ERRORI E DEL PASSO h
err_nat = zeros(size(nValues));  % spline naturale
err_nak = zeros(size(nValues));  % spline not-a-knot
hvals   = zeros(size(nValues));  % passo h = (b-a)/n

% CICLO SUI VALORI DI n
for k = 1:length(nValues)
    n = nValues(k);
    % Passo
    h = (b - a)/n;
    
    % NODI UNIFORMI
    xi = linspace(a, b, n+1);
    fi = f(xi);

    % ------ SPLINE NATURALE ------
    % spline0 deve essere la tua function che implementa la spline cubica naturale
    s_nat = spline0(xi, fi, xq);

    % ------ SPLINE NOT-A-KNOT (built-in) ------
    s_nak = spline(xi, fi, xq);

    % ERRORE MASSIMO SU [a,b]
    err_nat(k) = max(abs(s_nat - fxq));
    err_nak(k) = max(abs(s_nak - fxq));

    % SALVO h
    hvals(k) = h;
end

% ---------------- PLOT LOG-LOG ----------------
figure;
loglog(hvals, err_nat, 'b-o', 'LineWidth', 1.2, ...
       'MarkerFaceColor','b', 'DisplayName','Naturale');
hold on;
loglog(hvals, err_nak, 'r--s', 'LineWidth', 1.2, ...
       'MarkerFaceColor','r', 'DisplayName','Not-a-knot');
hold off;
grid on;
xlabel('h = (b-a)/n');
ylabel('Errore massimo di interpolazione');
title('Funzione di Runge su [-10,10]: spline naturale vs not-a-knot');
legend('Location','best');