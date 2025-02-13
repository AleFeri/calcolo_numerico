function ll = lebesgue(a, b, nn, type)
% LEBESGUE Approssima la costante di Lebesgue per l'interpolazione polinomiale
%
%   ll = lebesgue(a, b, nn, type) restituisce un vettore ll, in cui ciascun
%   elemento corrisponde all'approssimazione della costante di Lebesgue per 
%   il polinomio interpolante di grado n (con n+1 nodi), calcolata 
%   sull'intervallo [a,b].
%
%   Input:
%      a, b  - estremi dell'intervallo
%      nn    - vettore contenente i gradi dei polinomi (es. 1:100)
%      type  - 0: ascisse equidistanti, 1: ascisse di Chebyshev
%
%   Output:
%      ll    - vettore delle costanti di Lebesgue per ciascun grado in nn

    numPts = 10001;              % Numero di punti di valutazione
    x = linspace(a, b, numPts);  % Griglia in [a,b] su cui calcoliamo la funzione di Lebesgue
    ll = nn;                     % Preallocazione del vettore risultato

    for i = 1:length(nn)
        % Selezione dei nodi in base a 'type'
        if type == 0
            xi = linspace(a, b, nn(i));  % nodi equidistanti
        else
            xi = chebyshev(nn(i), a, b); % nodi di Chebyshev
        end
        
        % Calcolo della funzione di Lebesgue (somma delle basi in valore assoluto)
        leb = zeros(1, numPts);
        for j = 1:nn(i)
            leb = leb + abs(lagrangeBase(x, xi, j));
        end
        
        % Assegna la "norma" della funzione di Lebesgue come costante (per default, 2-norm)
        % Se vuoi la definizione standard (massimo = norma infinito),
        % usa: ll(i) = max(leb);
        ll(i) = norm(leb);
    end

    function L = lagrangeBase(x, xi, idx)
        % lagrangeBase Calcola il polinomio di base L_j(x)
        %   x   : vettore di punti in cui valutare la base
        %   xi  : nodi
        %   idx : indice del nodo corrispondente
        L = ones(size(x));
        
        nLocal = length(xi) - 1;
        xii = xi(idx);  
        
        xi_no_idx = xi([1:idx-1, idx+1:nLocal+1]);
        
        for k = 1:nLocal
            L = L .* (x - xi_no_idx(k)) / (xii - xi_no_idx(k));
        end
    end
end