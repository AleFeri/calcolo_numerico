function yy = lagrange(x, y, xx)
% lagrange - Interpolazione polinomiale di Lagrange
%
%   yy = lagrange(x, y, xx)
%
% Input:
%   x  - Vettore dei nodi di interpolazione
%   y  - Vettore dei valori corrispondenti ai nodi
%   xx - Vettore di punti nei quali valutare l'interpolazione
%
% Output:
%   yy - Vettore contenente i valori interpolati in xx

    n = length(x);
    L = ones(n, length(xx));
    
    for i = 1:n
        for j = 1:n
            if i ~= j
                L(i, :) = L(i, :) .* (xx - x(j)) / (x(i) - x(j));
            end
        end
    end

    yy = sum(y(:) .* L, 1);
    
    yy = reshape(yy, size(xx));
end