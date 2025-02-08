function [root, iter, n_eval] = newton_mod(f, m, df, x0, tol, max_iter)
% newton - Metodo di Newton per trovare uno zero di f.
%
% Input:
%   f       - handle della funzione (es. @(x) x.^2-2)
%   m       - molteplicità della radice
%   df      - handle della derivata di f (es. @(x) 2*x)
%   x0      - approssimazione iniziale
%   tol     - tolleranza per la convergenza (default 1e-6)
%   max_iter- numero massimo di iterazioni (default 100)
%
% Output:
%   root    - l'approssimazione dello zero
%   iter    - numero di iterazioni eseguite
%   n_eval  - numero totale di valutazioni della funzione f (e di df se necessario)

    if nargin < 5 || isempty(tol)
        tol = 10e-16;
    end
    if nargin < 6 || isempty(max_iter)
        max_iter = 1000;
    end

    if m < 1
        error('La molteplicità della radice deve essere maggiore di 0')
    end

    root = x0;
    n_eval = 0;
    for iter = 1:max_iter
        fx = f(root);
        dfx = df(root);
        n_eval = n_eval + 2;
        if dfx == 0
            error('La derivata si annulla in x = %f.', root);
        end
        root = root - m*fx/dfx;
        if abs(root - x0) <= tol * (1 + abs(x0))
            return;
        else
            x0 = root;
        end
    end
    warning('Il metodo di Newton non ha convertito in %d iterazioni.', iter);
return