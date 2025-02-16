function L = lagrangeBase(x, xi, idx)
% lagrangeBase - Calcola il polinomio di base L_j(x)
%
%   L = lagrangeBase(x, xi, idx)
%
% Input:
%   x   - vettore di punti in cui valutare la base
%   xi  - nodi
%   idx - indice del nodo corrispondente
%
% Output:
%   L   - polinomio di base

    L = ones(size(x));
    
    nLocal = length(xi) - 1;
    xii = xi(idx);  
    
    xi_no_idx = xi([1:idx-1, idx+1:nLocal+1]);
    
    for k = 1:nLocal
        L = L .* (x - xi_no_idx(k)) / (xii - xi_no_idx(k));
    end
end