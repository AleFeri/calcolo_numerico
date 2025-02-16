function x = mialum(A, b)
% mialum - Risolve il sistema lineare Ax = b con fattorizzazione LU senza
% pivoting parziale
%
%   x = mialum(A, b)
%
% Input:
%   A   - matrice n x n
%   b   - vettore termini noti
%
% Output:
%   x   - soluzione del sistema lineare Ax = b

    [n, m] = size(A);
    if n ~= m
        error('La matrice A deve essere quadrata.');
    end
    if size(b, 1) ~= n || size(b, 2) ~= 1
        error('Il vettore b deve essere colonna e avere dimensione compatibile con A.');
    end

    for i = 1:n-1
        if A(i, i) == 0
            error("La matrice è singolare")
        end
        for j = i+1:n
            A(j, i) = A(j, i) / A(i, i);
            A(j, i+1:n) = A(j, i+1:n) - A(j, i) * A(i, i+1:n);
        end
    end

    x = b(:);
    for i = 2:n
        x(i:n) = x(i:n) - A(i:n, i - 1) * x(i-1);
    end
    for i = n:-1:1
        x(i) = x(i) / A(i, i);
        x(1:i-1) = x(1:i-1) - A(1:i-1, i) * x(i);
    end
end