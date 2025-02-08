function [root, iter, n_eval] = metodo_newton(f, df, x0, tol, max_iter)
% metodo_newton - Metodo di Newton per trovare uno zero di f.
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
        tol = 1e-6;
    end
    if nargin < 5 || isempty(max_iter)
        max_iter = 100;
    end

    x = x0;
    iter = 0;
    n_eval = 0;
    while iter < max_iter
        fx = f(x); 
        n_eval = n_eval + 1; % valutazione di f
        dfx = df(x);
        n_eval = n_eval + 1; % valutazione di df
        if dfx == 0
            error('La derivata si annulla in x = %f.', x);
        end
        x_new = x - fx/dfx;
        iter = iter + 1;
        if abs(x_new - x) < tol || abs(f(x_new)) < tol
            n_eval = n_eval + 1; % ultima valutazione f(x_new)
            root = x_new;
            return;
        end
        x = x_new;
    end
    root = x;
    warning('Il metodo di Newton non ha convergito in %d iterazioni.', max_iter);
end