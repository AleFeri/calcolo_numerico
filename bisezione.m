function [root, iter, n_eval] = bisezione(f, a, b, tol, max_iter)
% bisezione - Metodo di bisezione per il calcolo di uno zero di f.
%
%   [root, iter, n_eval] = bisezione(f, a, b, tol, max_iter)
%
% Input:
%   f           - handle della funzione (esempio: @(x) x.^2 - 4)
%   a, b        - estremi dell'intervallo [a, b] in cui f cambia segno (deve essere f(a)*f(b) < 0)
%   tol         - tolleranza per la condizione di arresto (default: 1e-16)
%   max_iter    - iterazioni massime (default 1000)
%
% Output:
%   root    - approssimazione della radice
%   iter    - numero di iterazioni eseguite
%   n_eval  - numero totale di valutazioni della funzione f

    if a >= b
        error('L''estremo ''a'' deve essere minore dell''estremo ''b''.');
    end

    if f(a) * f(b) >= 0
        error('La funzione f deve cambiare segno nell''intervallo [a, b].');
    end

    if nargin < 4 || isempty(tol)
        tol = 1e-16;
    end
    if nargin < 5 || isempty(max_iter)
        max_iter = 1000;
    end

    iter = 0;
    n_eval = 0;

    while (b - a)/2 > tol && iter < max_iter
        c = (a + b) / 2;
        n_eval = n_eval + 1;
        fc = f(c);
        if fc == 0
            root = c;
            return;
        end

        if f(a) * fc < 0
            b = c;
        else
            a = c;
        end

        iter = iter + 1;
    end
    root = (a + b)/2;
end