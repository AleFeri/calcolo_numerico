% Esempio per il metodo delle secanti:
[root_secant, iter_secant] = metodo_secanti(f, 1, 2, 1e-6, 100);
fprintf('Metodo delle secanti: radice = %.8f trovata in %d iterazioni\n', root_secant, iter_secant);

function [root, iter] = metodo_secanti(f, x0, x1, tol, max_iter)
% METODO_SECANTI: Applica il metodo delle secanti per trovare uno zero di una funzione.
%
% Sintassi:
%   [root, iter] = metodo_secanti(f, x0, x1, tol, max_iter)
%
% Input:
%   f       - handle della funzione (es. @(x) x.^2-2)
%   x0, x1  - due valori iniziali (due approssimazioni iniziali)
%   tol     - tolleranza per la convergenza (default 1e-6)
%   max_iter- numero massimo di iterazioni (default 100)
%
% Output:
%   root    - l'approssimazione dello zero di f
%   iter    - numero di iterazioni eseguite
%
% Esempio:
%   f = @(x) x.^2 - 2;
%   [r, n] = metodo_secanti(f, 1, 2, 1e-6, 100);
%
% La formula iterativa usata è:
%   x_new = x1 - f(x1)*(x1 - x0)/(f(x1) - f(x0))
%
if nargin < 4 || isempty(tol)
    tol = 1e-6;
end
if nargin < 5 || isempty(max_iter)
    max_iter = 100;
end

iter = 0;
while iter < max_iter
    f_x0 = f(x0);
    f_x1 = f(x1);
    if f_x1 == f_x0
        error('Divisione per zero: f(x0) == f(x1) in iterazione %d', iter);
    end
    x_new = x1 - f_x1*(x1 - x0)/(f_x1 - f_x0);
    iter = iter + 1;
    % Controllo sulla convergenza: differenza tra iterazioni o valore della funzione
    if abs(x_new - x1) < tol || abs(f(x_new)) < tol
        root = x_new;
        return;
    end
    x0 = x1;
    x1 = x_new;
end

root = x1;
warning('Il metodo delle secanti non ha convertito in %d iterazioni.', max_iter);
end