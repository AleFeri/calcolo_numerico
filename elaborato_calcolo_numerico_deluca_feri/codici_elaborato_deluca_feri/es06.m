clearvars; close all; clc
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
results = {};
for tol = tol_list
   % Metodo della Bisezione
   [root_bis, iter_bis] = bisezione(f, a0, b0, tol, max_iter);
   results = [results; {'Bisezione', tol, root_bis, iter_bis}];
  
   % Metodo di Newton
   [root_newton, iter_newton, n_eval_newton] = newton(f, df, x0_newton, tol, max_iter);
   results = [results; {'Newton', tol, root_newton, iter_newton}];
  
   % Metodo delle Secanti
   [root_sec, iter_sec] = secanti(f, x0_sec, x1_sec, tol, max_iter);
   results = [results; {'Secanti', tol, root_sec, iter_sec}];
end
fprintf('Metodo      \tTolleranza\tRadice\t\t\tIterazioni\n');
fprintf('----------------------------------------------------------------------------------------------\n');
for i = 1:size(results,1)
   fprintf('%-10s\t%1.0e\t\t%1.6e\t\t%3d\n', ...
       results{i,1}, results{i,2}, results{i,3}, results{i,4});
end
