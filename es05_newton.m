% Esempio per il metodo di Newton:
f = @(x) x.^2 - 2;
df = @(x) 2*x;
[root_newton, iter_newton] = metodo_newton(f, df, 1, 1e-6, 100);
fprintf('Metodo di Newton: radice = %.8f trovata in %d iterazioni\n', root_newton, iter_newton);

function [root, iter] = metodo_newton(f, df, x0, tol, max_iter)
% METODO_NEWTON: Applica il metodo di Newton per trovare uno zero di una funzione.
%
% Sintassi:
%   [root, iter] = metodo_newton(f, df, x0, tol, max_iter)
%
% Input:
%   f       - handle della funzione (es. @(x) x.^2-2)
%   df      - handle della derivata di f (es. @(x) 2*x)
%   x0      - approssimazione iniziale
%   tol     - tolleranza per la convergenza (default 1e-6)
%   max_iter- numero massimo di iterazioni (default 100)
%
% Output:
%   root    - l'approssimazione dello zero di f
%   iter    - numero di iterazioni eseguite
%
% Esempio:
%   f = @(x) x.^2 - 2;
%   df = @(x) 2*x;
%   [r, n] = metodo_newton(f, df, 1, 1e-6, 100);
%
% Il metodo itera con la formula:
%   x_new = x - f(x)/df(x)
%
if nargin < 4 || isempty(tol)
    tol = 1e-6;
end
if nargin < 5 || isempty(max_iter)
    max_iter = 100;
end

x = x0;
iter = 0;
while iter < max_iter
    fx = f(x);
    dfx = df(x);
    if dfx == 0
        error('La derivata si annulla in x = %f. Metodo di Newton non applicabile.', x);
    end
    x_new = x - fx/dfx;
    iter = iter + 1;
    % Criteri di arresto: differenza tra iterazioni o valore della funzione piccolo
    if abs(x_new - x) < tol || abs(f(x_new)) < tol
        root = x_new;
        return;
    end
    x = x_new;
end

root = x;
warning('Il metodo di Newton non ha convertito in %d iterazioni.', max_iter);
end