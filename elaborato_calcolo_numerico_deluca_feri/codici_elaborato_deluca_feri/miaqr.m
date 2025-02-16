function [x, nr] = miaqr(A, b)
% miaqr - Risolve il sistema lineare Ax = b nel senso dei minimi quadrati utilizzando la fattorizzazione QR con Householder. Restituisce la norma del residuo.
%
%   [x, nr] = miaqr(A, b)
%
% Input:
%   A : matrice m x n, con m >= n e rank(A) = n.
%   b : vettore colonna di lunghezza m.
%
% Output:
%   x  : soluzione in minimi quadrati di Ax = b.
%   nr : norma del vettore residuo, ||b - A*x||.

    [m, n] = size(A);
    if length(b) ~= m
        error('Dimensione del vettore b non compatibile con la matrice A.');
    end
    if m < n
        error('La matrice A deve avere m >= n per la fattorizzazione QR.');
    end
    if rank(A) < n
        error('rank(A) < n: impossibile eseguire la fattorizzazione QR per un sistema ben determinato.');
    end

    R = A;
    Q = eye(m);

    for k = 1:n
        x = R(k:m, k);
        alpha = norm(x, 2);

        if x(1) < 0
            alpha = -alpha;
        end

        v = x;
        v(1) = v(1) + alpha;

        if norm(v, 2) > 0
            v = v / norm(v, 2);

            Hk = eye(m);
            Hk(k:m, k:m) = Hk(k:m, k:m) - 2*(v * v');

            R = Hk * R;
            Q = Q * Hk';
        end
    end

    R_upper = R(1:n, 1:n);

    Qt_b = Q' * b;
    y = Qt_b(1:n);

    x = R_upper \ y;

    r = b - A*x;
    nr = norm(r);
end