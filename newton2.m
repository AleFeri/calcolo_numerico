function [x, nit] = newton2(fun, x0, tol, maxit)
% NEWTON - Risolve un sistema di equazioni non lineari f(x)=0
%          tramite il metodo di Newton multivariato.
%
% Sintassi:
%   [x, nit] = newton(fun, x0, tol, maxit)
%
% Input:
%   fun   - funzione che, dato x, restituisce [f, J]
%           dove f è il vettore delle equazioni, J la Jacobiana
%   x0    - vettore colonna iniziale (condizione iniziale)
%   tol   - tolleranza per il criterio di arresto (default 1e-6)
%   maxit - numero massimo di iterazioni (default 100)
%
% Output:
%   x     - soluzione approssimata
%   nit   - numero di iterazioni effettuate

    if nargin < 3 || isempty(tol)
        tol = 1e-6; 
    end
    if nargin < 4 || isempty(maxit)
        maxit = 100; 
    end
    
    x0 = x0(:);
    nit = maxit;
    
    for k = 1:maxit
        [fval, J] = fun(x0);
        delta = mialum(J, -fval);
        x = x0 + delta;
        if norm(delta ./ (1 + abs(x0)), inf) <= tol
            nit = i;
            break
        end
    end
    warning('Il metodo di Newton non è convergente entro %d iterazioni.', maxit);
end 