function [pval, pder] = hornerDeriv(x, a, X)
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

    n = length(a) - 1;   % grado del polinomio
    pval = a(end);       % P_n(x) = a_n
    pder = 0;            % P_n'(x) = 0 all'inizio

    % Ciclo di Horner 'rovesciato', che include la derivata
    for i = n:-1:1
        pder = (x - X(i)) * pder + pval;
        pval = a(i) + (x - X(i)) * pval;
    end
end