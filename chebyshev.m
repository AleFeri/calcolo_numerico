function x = chebyshev(n, a, b)
% chebyshev - Calcola le ascisse di Chebyshev per l'interpolazione polinomiale
%
%   x = chebyshev(n, a, b)
%
% Input:
%   n   - grado del polinomio interpolante (vengono calcolati n+1 nodi)
%   a   - estremo sinistro dell'intervallo
%   b   - estremo destro dell'intervallo
%
% Output:
%   x   - vettore (1 x n+1) contenente le ascisse di Chebyshev

    k = 0:n;

    x_cheb = cos((2*k + 1)*pi/(2*(n+1)));
    
    x = ((b - a) / 2) * x_cheb + (a + b) / 2;
end