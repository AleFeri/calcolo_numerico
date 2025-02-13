function ll = lebesgue(a, b, nn, type)
% LEBESGUE Approssima la costante di Lebesgue per l'interpolazione polinomiale
%
%   ll = lebesgue(a, b, nn, type) restituisce un vettore ll, in cui ciascun
%   elemento corrisponde all'approssimazione della costante di Lebesgue per 
%   il polinomio interpolante di grado n (con n+1 nodi), calcolata sull'intervallo [a,b].
%
%   Input:
%      a, b  - estremi dell'intervallo
%      nn    - vettore contenente i gradi dei polinomi (es. 1:100)
%      type  - 0: ascisse equidistanti, 1: ascisse di Chebyshev
%
%   Output:
%      ll    - vettore delle costanti di Lebesgue per ciascun grado in nn

    % Genera una griglia di valutazione con 10001 punti equispaziati in [a,b]
    xgrid = linspace(a, b, 10001)';  % colonna per agevolare il broadcasting
    ll = zeros(size(nn));
    
    for k = 1:length(nn)
        n = nn(k); % grado del polinomio (ricorda: n+1 nodi)
        
        % Scelta dei nodi: equidistanti o di Chebyshev
        if type == 0
            % nodi equidistanti in [a,b]
            X = linspace(a, b, n+1);
        else
            % nodi di Chebyshev mappati in [a,b]
            % Formula: X_i = (a+b)/2 + ((b-a)/2)*cos((2*i+1)*pi/(2*(n+1))), i=0,...,n
            i = 0:n;
            X = (a+b)/2 + (b-a)/2 * cos((2*i+1)*pi/(2*(n+1)));
        end
        
        % Calcolo dei pesi barycentrici:
        % w(i) = 1/prod_{j~=i} (X(i)-X(j))
        Nnodes = n+1;
        w = zeros(1, Nnodes);
        for i = 1:Nnodes
            prod_val = 1;
            for j = 1:Nnodes
                if j ~= i
                    prod_val = prod_val * (X(i) - X(j));
                end
            end
            w(i) = 1/prod_val;
        end
        
        % Calcolo dei valori delle basi di Lagrange sulla griglia (formula barycentrica)
        % Per ogni punto x della griglia, calcoliamo:
        %     L_i(x) = (w(i)/(x - X(i))) / sum_{j} (w(j)/(x - X(j)))
        % Attenzione: se x coincide con un nodo X(i) allora L_i(x)=1 e L_j(x)=0, j~=i.
        diff = xgrid - X;   % matrice di dimensione (10001 x Nnodes)
        tol = 1e-12;
        exact = abs(diff) < tol;  % elementi in cui x coincide (virtualmente) con un nodo
        % Inizializzo la matrice delle basi
        L = zeros(size(diff));
        
        % Gestione dei punti NON in corrispondenza dei nodi
        idx_no_exact = find(~any(exact,2));  % indici delle righe in cui NON c'è corrispondenza
        if ~isempty(idx_no_exact)
            Nmat = (ones(length(idx_no_exact),1) * w) ./ diff(idx_no_exact, :);
            D = sum(Nmat, 2);
            L(idx_no_exact, :) = Nmat ./ D;
        end
        
        % Gestione dei punti in cui x coincide con un nodo
        idx_exact_rows = find(any(exact,2));
        for r = idx_exact_rows'
            % Trova l'indice del nodo corrispondente
            j0 = find(exact(r,:), 1);
            L(r,:) = 0;
            L(r, j0) = 1;
        end
        
        % Funzione di Lebesgue: somma delle basi in valore assoluto
        lambda = sum(abs(L), 2);
        % Costante di Lebesgue per il grado corrente = massimo su xgrid
        ll(k) = max(lambda);
    end
end