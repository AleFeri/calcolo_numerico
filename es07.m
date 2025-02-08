% Confronto dei metodi di Bisezione, Newton, Secanti e Newton Modificato
% per trovare la radice della funzione
%
%   f(x) = exp(x) - cos(x) + sin(x) - x*(x+2)
%
% Vengono calcolate le radici per tolleranze:
%   tol = 1e-3, 1e-6, 1e-9, 1e-12
%
% I dati iniziali sono:
%   - Bisezione: intervallo iniziale [a0, b0] = [-0.1, 1]
%   - Newton: x0 = 1
%   - Secanti: x0 = 1 e x1 = 0.9
%   - Newton Modificato: x0 = 1
%
% La tabella finale mostra per ogni metodo:
%   Metodo, Tolleranza, Radice, Numero di Iterazioni, Numero di Valutazioni Funzionali

clearvars; close all; clc

% Definizione della funzione e della sua derivata
f  = @(x) exp(x) - cos(x) + sin(x) - x.*(x+2);
df = @(x) exp(x) + sin(x) + cos(x) - (2*x + 2);  % derivata di f(x)

% Parametri:
tol_list = [1e-3, 1e-6, 1e-9, 1e-12];
max_iter = 100;

% Dati iniziali:
a0 = -0.1;      % Bisezione: estremo sinistro
b0 = 1;         % Bisezione: estremo destro
x0_newton = 1;  % Newton: approssimazione iniziale
x0_sec = 1;     % Secanti: primo punto
x1_sec = 0.9;   % Secanti: secondo punto
x0_newt_mod = 1;% Newton modificato: approssimazione iniziale
m_newt_mod = 5; % Newton modificato: molteplicità della radice

% Preallocazione dei risultati in una cell array.
% Ogni riga conterrà: {Metodo, Toll, Radice, Iterazioni, Valutazioni Funzionali}
results = {};

for tol = tol_list
    % Metodo della Bisezione (funzione es04.m)
    try
        [root_bis, iter_bis, n_eval_bis] = es04_bisezione(f, a0, b0, tol);
        results = [results; {'Bisezione', tol, root_bis, iter_bis, n_eval_bis}];
    catch ME
        disp(['Err: ', ME.message]);
        results = [results; {'Bisezione', tol, "Non Converge", "-", "-"}];
    end

    % Metodo di Newton (funzione es05_newton.m)
    try
        [root_newton, iter_newton, n_eval_newton] = es05_newton(f, df, x0_newton, tol, max_iter);
        results = [results; {'Newton', tol, root_newton, iter_newton, n_eval_newton}];
    catch ME
        disp(['Err: ', ME.message]);
        results = [results; {'Newton', tol, "Non Converge", "-", "-"}];
    end

    % Metodo delle Secanti (funzione es05_secanti.m)
    try
        [root_sec, iter_sec, n_eval_sec] = es05_secanti(f, x0_sec, x1_sec, tol, max_iter);
        results = [results; {'Secanti', tol, root_sec, iter_sec, n_eval_sec}];
    catch ME
        disp(['Err: ', ME.message]);
        results = [results; {'Secanti', tol, "Non Converge", "-", "-"}];
    end

    % Metodo di Newton Modificato (funzione es06_newton_modificato.m)
    try
        [root_newt_mod, iter_newt_mod, n_eval_newt_mod] = es07_newton_mod(f, m_newt_mod, df, x0_newt_mod, tol, max_iter);
        results = [results; {'Newton Modificato', tol, root_newt_mod, iter_newt_mod, n_eval_newt_mod}];
    catch ME
        disp(['Err: ', ME.message]);
        results = [results; {'Newton Modificato', tol, "Non Converge", "-", "-"}];
    end
end

fprintf('Metodo            \tTolleranza\tRadice\t\tIterazioni\tValutazioni Funzionali\n');
fprintf('----------------------------------------------------------------------------------------------\n');
for i = 1:size(results,1)
    metodo = results{i,1};
    toll   = results{i,2};
    radice = results{i,3};
    iterazioni = results{i,4};
    valutazioni = results{i,5};

    if isnumeric(radice)
        radice_str = sprintf('%1.6e', radice);
    else
        radice_str = radice;
    end

    if isnumeric(iterazioni)
        iter_str = sprintf('%d', iterazioni);
    else
        iter_str = iterazioni;
    end

    if isnumeric(valutazioni)
        valutazioni_str = sprintf('%d', valutazioni);
    else
        valutazioni_str = valutazioni;
    end

    fprintf('%-18s\t%1.0e\t\t%-15s\t%-15s\t%-15s\n', metodo, toll, radice_str, iter_str, valutazioni_str);
end