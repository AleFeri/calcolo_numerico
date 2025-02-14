function [root, iter, n_eval] = newton(f, df, x0, tol, max_iter)
% newton - Metodo di Newton per trovare uno zero di f.
%
%   [root, iter, n_eval] = newton(f, df, x0, tol, max_iter)
%
% Input:
%   f       - handle della funzione (es. @(x) x.^2-2)
%   df      - handle della derivata di f (es. @(x) 2*x)
%   x0      - approssimazione iniziale
%   tol     - tolleranza per la convergenza (default 1e-6)
%   max_iter- numero massimo di iterazioni (default 100)
%
% Output:
%   root    - l'approssimazione dello zero
%   iter    - numero di iterazioni eseguite
%   n_eval  - numero totale di valutazioni della funzione f (e di df se necessario)

    if nargin < 4 || isempty(tol)
        tol = 10e-16;
    end
    if nargin < 5 || isempty(max_iter)
        max_iter = 1000;
    end

    root = x0;
    n_eval = 0;
    for iter = 1:max_iter
        fx = f(root);
        n_eval = n_eval + 1;
        dfx = df(root);
        n_eval = n_eval + 1;
        if dfx == 0
            error('La derivata si annulla in x = %f.', x);
        end
        root = root - fx/dfx;
        if abs(root - x0) <= tol * (1 + abs(x0))
            return;
        else
            x0 = root;
        end
    end
    warning('Il metodo di Newton non ha convertito in %d iterazioni.', max_iter);
return