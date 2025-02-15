clc; clear;

% Test 1: Vettore b con dimensione non compatibile con la matrice A
try
    A = [1, 2; 3, 4; 5, 6];
    b = [1; 2];
    [x, nr] = miaqr(A, b);
catch ME
    disp(['Test 1 Errore: ', ME.message]);
end

% Test 2: Matrice con m < n
try
    A = [1, 2, 3; 4, 5, 6];
    b = [1; 2];
    [x, nr] = miaqr(A, b);
catch ME
    disp(['Test 2 Errore: ', ME.message]);
end

% Test 3: Matrice con rank(A) < n
try
    A = [1, 2, 3; 2, 4, 6; 3, 6, 9];
    b = [1; 2; 3];
    [x, nr] = miaqr(A, b);
catch ME
    disp(['Test 3 Errore: ', ME.message]);
end

% Test 4: Caso corretto
try
    A = [1, 2; 3, 4; 5, 6];
    b = [1; 2; 3];
    [x, nr] = miaqr(A, b);
    disp('Test 4 Soluzione x:');
    disp(x);
    disp('Test 4 Norma residuo nr:');
    disp(nr);
catch ME
    disp(['Test 4 Errore: ', ME.message]);
end