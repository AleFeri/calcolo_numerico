function [root, iter, n_eval] = secanti(f, x0, x1, tol, max_iter)
% secanti - Metodo delle secanti per trovare uno zero di f.
%
%   [root, iter, n_eval] = secanti(f, x0, x1, tol, max_iter)
%
% Input:
%   f       - handle della funzione (es. @(x) x.^2-2)
%   x0, x1  - due valori iniziali (due approssimazioni iniziali)
%   tol     - tolleranza per la convergenza (default 1e-6)
%   max_iter- numero massimo di iterazioni (default 100)
%
% Output:
%   root    - l'approssimazione dello zero
%   iter    - numero di iterazioni eseguite
%   n_eval  - numero totale di valutazioni della funzione f

    if nargin < 4 || isempty(tol)
        tol = 10e-16;
    end
    if nargin < 5 || isempty(max_iter)
        max_iter = 1000;
    end

    n_eval = 0;
    for iter = 1:max_iter
        f_x0 = f(x0); 
        f_x1 = f(x1);
        n_eval = n_eval + 2;
        if f_x1 == f_x0
            error('Divisione per zero: f(x0)==f(x1) in iterazione %d', iter);
        end
        root = (f_x1 * x0 - f_x0 * x1) / (f_x1 - f_x0);
        if abs(root - x1) < tol || abs(f(root)) < tol
            n_eval = n_eval + 1;
            return;
        end
        x0 = x1;
        x1 = root;
    end
    warning('Il metodo delle secanti non ha convertito in %d iterazioni.', iter);
end