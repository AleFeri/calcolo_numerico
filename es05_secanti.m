function [root, iter, n_eval] = metodo_secanti(f, x0, x1, tol, max_iter)
% metodo_secanti - Metodo delle secanti per trovare uno zero di f.
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
        tol = 1e-6;
    end
    if nargin < 5 || isempty(max_iter)
        max_iter = 100;
    end

    iter = 0;
    n_eval = 0;
    while iter < max_iter
        f_x0 = f(x0); 
        f_x1 = f(x1);
        n_eval = n_eval + 2;
        if f_x1 == f_x0
            error('Divisione per zero: f(x0)==f(x1) in iterazione %d', iter);
        end
        x_new = x1 - f_x1*(x1 - x0)/(f_x1 - f_x0);
        iter = iter + 1;
        if abs(x_new - x1) < tol || abs(f(x_new)) < tol
            n_eval = n_eval + 1;
            root = x_new;
            return;
        end
        x0 = x1;
        x1 = x_new;
    end
    root = x1;
    warning('Il metodo delle secanti non ha convergito in %d iterazioni.', max_iter);
end