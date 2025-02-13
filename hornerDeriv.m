function dP = hornerDeriv(x, a, X)
% HORNERDERIV Valuta il polinomio in forma di Newton e la sua derivata
%
%  [pval, pder] = hornerDeriv(x, a, X)
%
%  Input:
%     x   - ascissa in cui valutare polinomio e derivata
%     a   - coefficienti {a_0, a_1, ..., a_n} del polinomio in base di Newton
%     X   - nodi {x_0, x_1, ..., x_{n-1}} (lunghezza n)
%
%  Output:
%     pval - valore del polinomio p(x)
%     pder - valore della derivata p'(x)

    if nargin < 3
        error("Numero di parametri insufficienti");
    end
    n = length(a);
    if n ~= length(x)
        error("Dimensione degli input errata");
    end
    P = a(n);
    dP = 0;
    for k = n-1:-1:1
	    dP = dP .* (X - x(k)) + P;
	    P = P .* (X - x(k)) + a(k);
    end
end