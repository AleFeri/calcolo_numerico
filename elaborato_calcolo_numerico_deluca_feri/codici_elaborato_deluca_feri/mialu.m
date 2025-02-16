function x = mialu(A, b)
% mialu - Risolve il sistema lineare Ax = b usando la fattorizzazione LU con pivoting parziale.
%
%   x = mialu(A, b)
%
% Input:
%   A   - matrice n x n
%   b   - vettore termini noti
%
% Output:
%   x   - soluzione del sistema lineare Ax = b

    [n, m] = size(A);
    if n == 1
        x = b / A;
        return;
    end
    if n ~= m
        error('La matrice A deve essere quadrata.');
    end
    if size(b, 1) ~= n || size(b, 2) ~= 1
        error('Il vettore b deve essere colonna e avere dimensione compatibile con A.');
    end

    L = eye(n);
    U = A;
    P = eye(n);
    
    for k = 1:n-1
        [pivot_val, pivot_index] = max(abs(U(k:n, k)));
        pivot_index = pivot_index + k - 1;
        
        if pivot_val == 0
            error('La matrice A è singolare.');
        end

        if pivot_index ~= k
            U([k, pivot_index], :) = U([pivot_index, k], :);
            P([k, pivot_index], :) = P([pivot_index, k], :);
            if k > 1
                L([k, pivot_index], 1:k-1) = L([pivot_index, k], 1:k-1);
            end
        end

        L(k+1:n, k) = U(k+1:n, k) / U(k, k);
        U(k+1:n, :) = U(k+1:n, :) - L(k+1:n, k) * U(k, :);
    end

    if U(n, n) == 0
        error('La matrice A è singolare.');
    end

    b_perm = P * b;
    
    y = zeros(n, 1);
    for i = 1:n
        y(i) = b_perm(i) - L(i, 1:i-1) * y(1:i-1);
    end
    
    x = zeros(n, 1);
    for i = n:-1:1
        x(i) = (y(i) - U(i, i+1:n) * x(i+1:n)) / U(i, i);
    end
end