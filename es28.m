% testNewtonCotesPesi.m

% Gradi richiesti
degrees = [1, 2, 3, 4, 5, 6, 7, 9];

for n = degrees
    % Calcola i pesi della formula di Newton-Cotes di grado n
    w = newtonCotesPesi(n);
    
    % Stampa
    fprintf('Grado n = %d (n+1 = %d nodi):\n', n, n+1);
    for i = 1:length(w)
        % Stampa il peso come frazione razionale esatta
        % (rats(...) prova a scrivere in forma p/q)
        fprintf('  w_%d = %s\n', i-1, rats(w(i)));
    end
    fprintf('--------------------------------\n');
end