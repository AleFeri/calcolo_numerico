close all; clearvars; clc;

%% Definizione della funzione e dei parametri
% Definisci la funzione di cui cercare lo zero come function handle.
f = @(x) x.^3 - x - 2;  

% Definisci l'intervallo [a, b] in cui la funzione cambia segno.
a = 1;
b = 2;

% Parametri per il metodo di bisezione
tol = 1e-6;      % Tolleranza per la condizione di arresto

%% Chiamata alla funzione bisection
[root, iter] = bisezione(f, a, b, tol);

% Visualizza il risultato
fprintf('La radice approssimata è %f trovata in %d iterazioni\n', root, iter);

%% Funzione di bisezione
function [root, iter] = bisezione(f, a, b, tol)
% bisezione - Metodo di bisezione per il calcolo di uno zero di f.
%
% Sintassi:
%   [root, iter] = bisezione(f, a, b, tol)
%
% Input:
%   f       - handle della funzione (esempio: @(x) x.^2 - 4)
%   a, b    - estremi dell'intervallo [a, b] in cui f cambia segno (deve essere f(a)*f(b) < 0)
%   tol     - tolleranza per la condizione di arresto (default: 1e-6)
%
% Output:
%   root    - approssimazione della radice
%   iter    - numero di iterazioni eseguite

    % Controllo preliminare: a deve essere minore di b.
    if a >= b
        error('L''estremo ''a'' deve essere minore dell''estremo ''b''.');
    end

    % Controllo preliminare: f deve cambiare segno in [a, b].
    if f(a) * f(b) >= 0
        error('La funzione f deve cambiare segno nell''intervallo [a, b].');
    end

    % Imposto una tolleranza di default se non specificata
    if nargin < 4 || isempty(tol)
        tol = 1e-6;
    end

    % Calcolo il massimo delle iterazioni.
    maxiter = ceil(log2(b-a)-log2(tol));

    iter = 0;

    % Ciclo principale del metodo di bisezione:
    % continua fino a che la metà della lunghezza dell'intervallo è
    % maggiore della tolleranza o non sono state raggiunte le iterazioni massime.
    while (b - a) / 2 > tol && iter < maxiter
        % Calcolo il punto medio dell'intervallo
        c = (a + b) / 2;
        
        % Se f(c) è esattamente zero, la radice è stata trovata
        if f(c) == 0
            root = c;
            return;
        end
        
        % Determina in quale sottointervallo si verifica il cambio di segno
        if f(a) * f(c) < 0
            % La radice si trova nell'intervallo [a, c]
            b = c;
        else
            % La radice si trova nell'intervallo [c, b]
            a = c;
        end
        
        % Incrementa il contatore delle iterazioni
        iter = iter + 1;
    end

    % Approssimazione finale della radice: il punto medio dell'intervallo finale
    root = (a + b) / 2;
end