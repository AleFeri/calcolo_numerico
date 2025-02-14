function w = newtonCotesPesi(n)
% NEWTONCOTESPESI Restituisce i pesi della formula di Newton-Cotes di grado n.
%
%   w = newtonCotesPesi(n) restituisce un vettore colonna di dimensione (n+1)x1,
%   i cui elementi sono i pesi della formula di quadratura chiusa su [0,n]:
%
%       ∫₀ⁿ f(x) dx ≈ ∑_{i=0}ⁿ w(i+1)*f(i)
%
%   I nodi usati sono: x₀=0, x₁=1, ..., xₙ=n.
%
%   L'argomento n deve essere compreso tra 1 e 9, con l'esclusione di n=8.

    if (n < 1) || (n > 9) || (n == 8)
        error("Grado errato: n deve essere in [1..9] e diverso da 8.");
    end

    w = zeros(1, n+1);

    nodi = 0:n;
    for iNodo = nodi
        altriNodi = [nodi(1:iNodo), nodi(iNodo+2:end)];

        diffVals = iNodo - altriNodi;
        denom = prod(diffVals);

        pCoeffs = poly(altriNodi);

        pCoeffs = [pCoeffs ./ ((n+1):-1:1), 0];

        pVal = polyval(pCoeffs, n);

        w(iNodo+1) = pVal / denom;
    end
end