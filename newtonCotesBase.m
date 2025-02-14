function w = newtonCotesBase(k)
% NEWTONCOTESBASE  Calcola i pesi della formula di Newton-Cotes chiusa di grado k
% su [0,k] con nodi 0,1,2,...,k (passo=1).
%
% Ritorna un vettore riga di lunghezza (k+1).

    w = zeros(1, k+1);
    for i = 0:k
        altri = [0:(i-1) (i+1):k];
        denom = prod(i - altri);

        p = poly(altri);

        pInt = [p ./ (k+1:-1:1), 0];

        valK = polyval(pInt, k);
        val0 = polyval(pInt, 0);
        integ = valK - val0;

        w(i+1) = integ / denom;
    end
end