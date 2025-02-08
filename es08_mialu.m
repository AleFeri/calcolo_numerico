function x = mialu(A, b)
% MIALU Risolve il sistema lineare Ax = b usando la fattorizzazione LU con pivoting parziale.
%
% Input:
%   A   - matrice n x n
%   b   - vettore termini noti
%
% Output:
%   x   - soluzione del sistema lineare Ax = b

    % Controllo delle dimensioni
    [n, m] = size(A);
    if n ~= m
        error('La matrice A deve essere quadrata.');
    end
    if size(b, 1) ~= n || size(b, 2) ~= 1
        error('Il vettore b deve essere colonna e avere dimensione compatibile con A.');
    end

    % Inizializzazione di L, U e della matrice di permutazione P
    L = eye(n);
    U = A;
    P = eye(n);
    
    % Fattorizzazione LU con pivoting parziale
    for k = 1:n-1
        % Trova l'indice della riga con il massimo valore assoluto nella colonna k
        [pivot_val, pivot_index] = max(abs(U(k:n, k)));
        pivot_index = pivot_index + k - 1;
        
        if pivot_val == 0
            error('La matrice A è singolare.');
        end

        % Scambio delle righe se necessario
        if pivot_index ~= k
            U([k, pivot_index], :) = U([pivot_index, k], :);
            P([k, pivot_index], :) = P([pivot_index, k], :);
            if k > 1
                L([k, pivot_index], 1:k-1) = L([pivot_index, k], 1:k-1);
            end
        end
        
        % Calcolo dei moltiplicatori e aggiornamento di U e L
        L(k+1:n, k) = U(k+1:n, k) / U(k, k);
        U(k+1:n, :) = U(k+1:n, :) - L(k+1:n, k) * U(k, :);
    end
    
    % Controllo per la singolarità
    if U(n, n) == 0
        error('La matrice A è singolare.');
    end
    
    % Calcolo Pb
    b_perm = P * b;
    
    % Risoluzione del sistema triangolare inferiore L*y = P*b (sostituzione in avanti)
    y = zeros(n, 1);
    for i = 1:n
        y(i) = b_perm(i) - L(i, 1:i-1) * y(1:i-1);
    end
    
    % Risoluzione del sistema triangolare superiore U*x = y (sostituzione all'indietro)
    x = zeros(n, 1);
    for i = n:-1:1
        x(i) = (y(i) - U(i, i+1:n) * x(i+1:n)) / U(i, i);
    end
end