clc; clear;

% Test 1: Matrice non quadrata
try
    A = [1, 0, 2; 0, 0, 2];
    b = [1; 2];
    x = mialdl(A, b);
catch ME
    disp(['Test 1 Errore: ', ME.message]);
end

% Test 2: Vettore b con dimensione non compatibile con la matrice
try
    A = [1, 2; 2, 1];
    b = [1; 2; 3; 4];
    x = mialdl(A, b);
catch ME
    disp(['Test 2 Errore: ', ME.message]);
end

% Test 3: Matrice non definita positiva
try
    A = [2, -1, 0; -1, 0, 1; 0, 1, 3];
    b = [1; 2; 3];
    x = mialdl(A, b);
catch ME
    disp(['Test 3 Errore: ', ME.message]);
end

% Test 4: Matrice non simmetrica
try
    A = [4, 1, 2; 0, 2, 3; 1, 0, 3];
    b = [1; 2; 3];
    x = mialdl(A, b);
catch ME
    disp(['Test 4 Errore: ', ME.message]);
end

% Test 5: Matrice simmetrica e definita positiva
try
    A = [4, 1, 1; 1, 2, 0; 1, 0, 3];
    b = [1; 2; 3];
    x = mialdl(A, b);
    disp('Test 5 Soluzione:');
    disp(x);
catch ME
    disp(['Test 5 Errore: ', ME.message]);
end