function ll = lebesgue(a, b, nn, type)
% lebesgue - Approssima la costante di Lebesgue per l'interpolazione polinomiale
%
%   ll = lebesgue(a, b, nn, type)
%
% Input:
%   a, b    - estremi dell'intervallo
%   nn      - vettore contenente i gradi dei polinomi (es. 1:100)
%   type    - 0: ascisse equidistanti, 1: ascisse di Chebyshev
%
% Output:
%   ll      - vettore delle costanti di Lebesgue per ciascun grado in nn

    numPts = 10001;
    x = linspace(a, b, numPts);
    ll = nn;

    for i = 1:length(nn)
        if type == 0
            xi = linspace(a, b, nn(i));
        else
            xi = chebyshev(nn(i), a, b);
        end
        
        leb = zeros(1, numPts);
        for j = 1:nn(i)
            leb = leb + abs(lagrangeBase(x, xi, j));
        end
        
        ll(i) = norm(leb);
    end
end