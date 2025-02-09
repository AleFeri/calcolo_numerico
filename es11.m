results = zeros(15, 2);

for n = 1:15
    fprintf('\nn = %d\n', n);

    [A, b] = genera_matrice_vettore(n);

    display(b);
    
    % Soluzione teorica
    x_exact = ones(n, 1);
    
    % Soluzione calcolata con mialu
    x_computed = es08_mialu(A, b);
    
    % Calcolo dell'errore
    error = norm(x_computed - x_exact);
    results(n, :) = [n, error];
    
    fprintf('Errore ||x_computed - x_exact|| = %.2e\n', error);
end

% Tabulazione dei risultati
disp('Risultati finali:');
disp(' n   Errore');
disp('---------------');
for i = 1:15
    fprintf('%2d  %.2e\n', results(i, 1), results(i, 2));
end

function [A, b] = genera_matrice_vettore(n)
    % Creazione della matrice A_n
    A = zeros(n, n);
    for i = 1:n
        for j = 1:n
            A(i, j) = 10^max(i - j, 0);
        end
    end
    % Creazione del vettore b_n
    b = zeros(n, 1);
    for i = 1:n
        b(i) = n - i + (10^i - 1) / 9;
    end
end