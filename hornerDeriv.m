function [p, dp] = hornerDeriv(x, a, X)
% hornerDeriv - Valuta il polinomio in forma di Newton e la sua derivata
%
%   [p, dp] = hornerDeriv(x, a, X)
%
% Input:
%   x   - Ascissa in cui valutare il polinomio e la sua derivata
%   a   - Vettore dei coefficienti {a0, a1, ..., an} del polinomio in forma di Newton
%   X   - Vettore dei nodi {x0, x1, ..., x_{n-1}} (di lunghezza n-1)
%
% Output:
%   p   - Valore del polinomio p(x)
%   dp  - Valore della derivata p'(x)

    if nargin < 3
        error('Numero di parametri insufficienti');
    end

    n = length(a);
    if length(X) ~= n - 1
        error('La lunghezza di X deve essere pari a n-1, dove n = length(a)');
    end

    p = a(n);
    dp = 0;
    
    for k = n-1:-1:1
        dp = dp * (x - X(k)) + p;
        p = p * (x - X(k)) + a(k);
    end
end