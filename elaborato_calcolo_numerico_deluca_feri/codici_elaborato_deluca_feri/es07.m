clearvars; close all; clc

f  = @(x) exp(x) - cos(x) + sin(x) - x.*(x+2);
df = @(x) exp(x) + sin(x) + cos(x) - (2*x + 2);  % derivata di f(x)

tol_list = [1e-3, 1e-6, 1e-9, 1e-12];
max_iter = 200;

% Dati iniziali:
a0 = -0.1;      % Bisezione: estremo sinistro
b0 = 1;         % Bisezione: estremo destro
x0_newton = 1;  % Newton: approssimazione iniziale
x0_sec = 1;     % Secanti: primo punto
x1_sec = 0.9;   % Secanti: secondo punto
x0_newt_mod = 1;% Newton modificato: approssimazione iniziale
m_newt_mod = 5; % Newton modificato: molteplicità della radice

results = {};

for tol = tol_list
    % Metodo della Bisezione
    try
        [root_bis, iter_bis] = bisezione(f, a0, b0, tol);
        results = [results; {'Bisezione', tol, root_bis, iter_bis}];
    catch ME
        disp(['Err: ', ME.message]);
        results = [results; {'Bisezione', tol, "Non Converge", "-"}];
    end

    % Metodo di Newton
    try
        [root_newton, iter_newton, n_eval_newton] = newton(f, df, x0_newton, tol, max_iter);
        results = [results; {'Newton', tol, root_newton, iter_newton}];
    catch ME
        disp(['Err: ', ME.message]);
        results = [results; {'Newton', tol, "Non Converge", "-"}];
    end

    % Metodo delle Secanti
    try
        [root_sec, iter_sec] = secanti(f, x0_sec, x1_sec, tol, max_iter);
        results = [results; {'Secanti', tol, root_sec, iter_sec}];
    catch ME
        disp(['Err: ', ME.message]);
        results = [results; {'Secanti', tol, "Non Converge", "-"}];
    end

    % Metodo di Newton Modificato
    try
        [root_newt_mod, iter_newt_mod, n_eval_newt_mod] = newton_mod(f, m_newt_mod, df, x0_newt_mod, tol, max_iter);
        results = [results; {'Newton Modificato', tol, root_newt_mod, iter_newt_mod, n_eval_newt_mod}];
    catch ME
        disp(['Err: ', ME.message]);
        results = [results; {'Newton Modificato', tol, "Non Converge", "-"}];
    end
end

fprintf('Metodo            \tTolleranza\tRadice\t\tIterazioni\n');
fprintf('----------------------------------------------------------------------------------------------\n');
for i = 1:size(results,1)
    metodo = results{i,1};
    toll   = results{i,2};
    radice = results{i,3};
    iterazioni = results{i,4};

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

    fprintf('%-18s\t%1.0e\t\t%-15s\t%-15s\n', metodo, toll, radice_str, iter_str);
end