A = [1 2 3; 4 5 6];
b = [1; 2; 3];
x = mialu(A, b);

function x = mialu(A, b)
% MIALU Risolve il sistema lineare Ax = b usando la fattorizzazione LU con pivoting parziale.
%
%   x = mialu(A, b) restituisce il vettore soluzione x del sistema lineare Ax = b,
%   dove A è una matrice quadrata e b un vettore (riga o colonna) compatibile con A.
%
%   La funzione calcola la fattorizzazione LU di A con pivoting parziale,
%   ottenendo una matrice di permutazione P tale che:
%
%       PA = LU,
%
%   e procede risolvendo i sistemi triangolari:
%
%       L * y = P*b      (sostituzione in avanti)
%       U * x = y        (sostituzione all'indietro)
%
%   Se A è singolare oppure se le dimensioni di b non sono compatibili con A,
%   viene generato un messaggio d'errore.

    % Controllo delle dimensioni
    [n, m] = size(A);
    if n ~= m
        error('La matrice A deve essere quadrata.');
    end
    
    if ~(isequal(size(b), [n, 1]) || isequal(size(b), [1, n]))
        error('Il vettore b deve avere dimensione compatibile con A.');
    end
    
    % Se b è una riga, la converto in vettore colonna
    if isrow(b)
        b = b.';
    end
    
    % Inizializzazione di L, U e della matrice di permutazione P
    L = eye(n);
    U = A;
    P = eye(n);
    
    % Fattorizzazione LU con pivoting parziale
    for k = 1:n-1
        % Trova l'indice della riga con il massimo valore assoluto nella colonna k a partire dalla riga k
        [pivot_val, pivot_index] = max(abs(U(k:n, k)));
        pivot_index = pivot_index + k - 1;
        
        if pivot_val == 0
            error('La matrice A è singolare.');
        end
        
        % Se il pivot migliore non è già in posizione k, scambia le righe
        if pivot_index ~= k
            % Scambio righe in U
            temp = U(k, :);
            U(k, :) = U(pivot_index, :);
            U(pivot_index, :) = temp;
            
            % Scambio righe in P
            temp = P(k, :);
            P(k, :) = P(pivot_index, :);
            P(pivot_index, :) = temp;
            
            % Scambio le righe in L per le colonne già determinate (1:k-1)
            if k > 1
                temp = L(k, 1:k-1);
                L(k, 1:k-1) = L(pivot_index, 1:k-1);
                L(pivot_index, 1:k-1) = temp;
            end
        end
        
        % Calcolo dei moltiplicatori e aggiornamento di U e L
        for i = k+1:n
            L(i, k) = U(i, k) / U(k, k);
            U(i, :) = U(i, :) - L(i, k) * U(k, :);
        end
    end
    
    % Controllo finale per singolarità: l'elemento diagonale finale non deve essere zero.
    if U(n, n) == 0
        error('La matrice A è singolare.');
    end
    
    % Calcola Pb
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