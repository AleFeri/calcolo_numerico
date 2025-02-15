clc; clear;

% Test 1: Matrice non quadrata
try
    A = [1, 2, 3; 0, 0, 1];
    b = [1; 2];
    x = mialu(A, b);
catch ME
    disp(['Test 1 Errore: ', ME.message]);
end

% Test 2: Matrice singolare
try
    A = [2, 4, 8; 1, 2, 4; 3, 6, 12];
    b = [1; 2; 3];
    x = mialu(A, b);
catch ME
    disp(['Test 2 Errore: ', ME.message]);
end

% Test 3: Vettore b non compatibile
try
    A = [1, 2, 3; 4, 5, 6; 7, 8, 9];
    b = [5; 6; 7; 8];
    x = mialu(A, b);
catch ME
    disp(['Test 3 Errore: ', ME.message]);
end

% Test 4: Caso valido
try
    A = [2, 1, 3; 4, 5, 6; 7, 8, 10];
    b = [3; 2; 1];
    x = mialu(A, b);
    disp('Test 4 Soluzioni:');
    disp(x);
catch ME
    disp(['Test 4 Errore: ', ME.message]);
end