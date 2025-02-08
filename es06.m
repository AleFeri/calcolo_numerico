% Script per confrontare i metodi della bisezione, di Newton e delle secanti
% per trovare la radice di f(x) = exp(x) - cos(x) a diverse tolleranze.
% Vengono riportati per ciascun metodo:
%   Metodo, Tolleranza, Radice, Numero di Iterazioni, Numero di Valutazioni Funzionali

clearvars; close all; clc

% Definizione della funzione e della derivata
f = @(x) exp(x) - cos(x);
df = @(x) exp(x) + sin(x);

% Parametri iniziali per ciascun metodo:
tol_list = [1e-3, 1e-6, 1e-9, 1e-12];
max_iter = 100;

% Per il metodo della bisezione, usiamo l'intervallo iniziale [-0.1, 1]
a0 = -0.1;
b0 = 1;

% Per il metodo di Newton: x0 = 1
x0_newton = 1;

% Per il metodo delle secanti: x0 = 1 e x1 = 0.9
x0_sec = 1;
x1_sec = 0.9;

% Inizializza una cell array per memorizzare i risultati
% Ogni riga avrà la forma:
% {Metodo, Tolleranza, Radice, Numero Iterazioni, Numero Valutazioni Funzionali}
results = {};

% Ciclo sulle tolleranze
for tol = tol_list
    % Metodo della Bisezione (file es04.m)
    [root_bis, iter_bis, n_eval_bis] = es04_bisezione(f, a0, b0, tol, max_iter);
    results = [results; {'Bisezione', tol, root_bis, iter_bis, n_eval_bis}];
    
    % Metodo di Newton (file es05_newton.m)
    [root_newton, iter_newton, n_eval_newton] = es05_newton(f, df, x0_newton, tol, max_iter);
    results = [results; {'Newton', tol, root_newton, iter_newton, n_eval_newton}];
    
    % Metodo delle Secanti (file es05_secanti.m)
    [root_sec, iter_sec, n_eval_sec] = es05_secanti(f, x0_sec, x1_sec, tol, max_iter);
    results = [results; {'Secanti', tol, root_sec, iter_sec, n_eval_sec}];
end

% Stampa la tabella dei risultati
fprintf('Metodo      \tTolleranza\tRadice\t\t\tIterazioni\tValutazioni Funzionali\n');
fprintf('----------------------------------------------------------------------------------------------\n');
for i = 1:size(results,1)
    % Usa %-10s per allineare il nome del metodo, %1.0e per la tolleranza,
    % %1.6e per la radice, %3d per iterazioni e valutazioni.
    fprintf('%-10s\t%1.0e\t\t%1.6e\t\t%3d\t\t\t%3d\n', ...
        results{i,1}, results{i,2}, results{i,3}, results{i,4}, results{i,5});
end