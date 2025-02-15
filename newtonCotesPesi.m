function w = newtonCotesPesi(n)
% newtonCotesPesi - Restituisce i pesi della formula di Newton-Cotes di grado n.
%
%   w = newtonCotesPesi(n)
%
% Input:
%   n   - grado compreso tra 1 e 9 con 8 escluso
%
% Output:
%   W   - pesi della formula di Newton-Cotes di grado n

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