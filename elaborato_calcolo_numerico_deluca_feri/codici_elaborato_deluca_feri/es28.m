gradi = [1, 2, 3, 4, 5, 6, 7, 9];

for n = gradi
    w = newtonCotesPesi(n);
    
    fprintf('Grado n = %d (n+1 = %d nodi):\n', n, n+1);
    for i = 1:length(w)
        fprintf('  w_%d = %s\n', i-1, rats(w(i)));
    end
    fprintf('--------------------------------\n');
end