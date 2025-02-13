function p = lagrange_baricentrica(x, X, F)
    % x:  vettore dei punti in cui valutare
    % X:  nodi (colonna o riga)
    % F:  valori della funzione sui nodi (stessa dimensione di X)
    
    x = x(:).';      % forziamo x come riga
    X = X(:).';      % nodi come riga
    F = F(:).';      % valori come riga
    
    n = length(X);
    w = ones(1,n);
    % Calcolo dei pesi barycentrici w(i) = 1 / prod_{j!=i}(X(i)-X(j))
    for i = 1:n
        denom = 1;
        for j = 1:n
            if j ~= i
                denom = denom*(X(i)-X(j));
            end
        end
        w(i) = 1/denom;
    end
    
    % Preallocazione risultato
    p = zeros(size(x));
    
    % Per ogni punto x(k), valutiamo l’interpolante
    for k = 1:length(x)
        xx = x(k);
        
        % Se xx coincide con un nodo X(i), p(xx) = F(i)
        jCoincide = find(abs(xx - X) < 1e-14, 1);
        if ~isempty(jCoincide)
            p(k) = F(jCoincide);
        else
            % Calcolo formula barycentrica
            num = 0; 
            den = 0;
            for i = 1:n
                temp = w(i)/(xx - X(i));
                num = num + temp*F(i);
                den = den + temp;
            end
            p(k) = num/den;
        end
    end
end