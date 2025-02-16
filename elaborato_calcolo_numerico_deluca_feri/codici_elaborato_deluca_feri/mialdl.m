function x = mialdl(A, b)
% mialdl - Risolve il sistema lineare Ax = b per una matrice A simmetrica e definita positiva utilizzando la fattorizzazione LDL^T (senza pivoting).
%
%   x = mialdl(A, b)
%
% Input:
%   A   - matrice n x n (simmetrica, definita positiva)
%   b   - vettore colonna di dimensione n
%
% Output:
%   x   - soluzione del sistema lineare Ax = b

    [n, m] = size(A);
    if n ~= m
        error('La matrice A deve essere quadrata.');
    end
    if ~isequal(A, A')
        error('La matrice A non e'' simmetrica.');
    end
    if ~isequal(size(b), [n, 1])
        error('Il vettore b deve essere colonna e avere dimensione compatibile con A.');
    end

    L = eye(n);
    D = zeros(n, 1);

    for k = 1:n
        somma = 0;
        for j = 1:k-1
            somma = somma + L(k,j)^2 * D(j);
        end
        D(k) = A(k,k) - somma;

        if D(k) <= 0
            error('La matrice A non e'' definita positiva (valore diagonale <= 0).');
        end

        for i = k+1:n
            somma = 0;
            for j = 1:k-1
                somma = somma + L(i,j)*L(k,j)*D(j);
            end
            L(i,k) = (A(i,k) - somma) / D(k);
        end
    end

    y = zeros(n,1);
    for i = 1:n
        s = 0;
        for j = 1:i-1
            s = s + L(i,j)*y(j);
        end
        y(i) = (b(i) - s);
    end

    z = y ./ D;

    x = zeros(n,1);
    for i = n:-1:1
        s = 0;
        for j = i+1:n
            s = s + L(j,i)*x(j);
        end
        x(i) = (z(i) - s);
    end
end