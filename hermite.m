function yy = hermite(xi, fi, f1i, xx)
% HERMIT funzione che calcola il polinomio interpolante di Hermite
%   yy = hermite(xi, fi, f1i, xx)
% 
% Input:
%   xi  - vettore dei punti dati
%   fi  - valori della funzione in xi
%   f1i - valori delle derivate in xi
%   xx  - punti di valutazione
% 
% Output:
%   yy  - valori interpolati in xx

    n = length(xi);
    z = zeros(2*n, 1); % Vettore dei nodi duplicati
    Q = zeros(2*n, 2*n); % Tabella delle differenze divise
    
    % Riempie z con i valori duplicati di xi
    z(1:2:end) = xi;
    z(2:2:end) = xi;
    
    % Riempie la prima colonna di Q con i valori della funzione
    Q(1:2:end, 1) = fi;
    Q(2:2:end, 1) = fi;
    
    % Riempie la seconda colonna di Q con i valori delle derivate
    Q(2:2:end, 2) = f1i;
    
    % Calcola le prime differenze divise per i nodi duplicati
    Q(1:2:2*n-2, 2) = diff(fi) ./ diff(xi);
    
    % Calcola le differenze divise rimanenti
    for j = 3:2*n
        for i = j:2*n
            Q(i, j) = (Q(i, j-1) - Q(i-1, j-1)) / (z(i) - z(i-j+1));
        end
    end
    
    % Calcola il polinomio di Hermite usando la forma di Newton
    yy = Q(1,1) * ones(size(xx));
    term = ones(size(xx));
    for k = 2:2*n
        term = term .* (xx - z(k-1));
        yy = yy + Q(k, k) * term;
    end
end