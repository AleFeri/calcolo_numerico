function x = chebyshev(n, a, b)
% CHEBYSHEV Calcola le ascisse di Chebyshev per l'interpolazione polinomiale
%
%   x = chebyshev(n, a, b) restituisce un vettore x contenente le ascisse
%   di Chebyshev, mappate sull'intervallo [a, b], per il polinomio interpolante 
%   di grado n (ossia, n+1 nodi).
%
%   Input:
%      n - grado del polinomio interpolante (vengono calcolati n+1 nodi)
%      a - estremo sinistro dell'intervallo
%      b - estremo destro dell'intervallo
%
%   Output:
%      x - vettore (1 x n+1) contenente le ascisse di Chebyshev

    % Indici da 0 a n
    k = 0:n;
    
    % Calcolo dei nodi di Chebyshev su [-1, 1]
    % Formula: x_k = cos((2k+1)*pi/(2*(n+1)))
    x_cheb = cos((2*k + 1)*pi/(2*(n+1)));
    
    % Mappatura dell'intervallo [-1, 1] su [a, b]
    x = ((b - a) / 2) * x_cheb + (a + b) / 2;
end