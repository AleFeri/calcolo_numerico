clc; clearvars; close all;

x0_list = {[0.5; 0.5], [0; 0], [1; 1], [-0.5; -0.5], [2; 2]};

tol = 1e-6;
maxit = 100;

for i = 1:length(x0_list)
    x0 = x0_list{i};
    fprintf('\n-----------------------------\n');
    fprintf('Test con punto iniziale x0 = [%f, %f]\n', x0(1), x0(2));
    
    [sol, iter] = newton2(@myFun, x0, tol, maxit);
    
    fprintf('Numero di iterazioni: %d\n', iter);
    if iter < maxit
        fprintf('Soluzione trovata: x = [%f, %f]\n', sol(1), sol(2));
    else
        fprintf('Il metodo non è convergente entro %d iterazioni.\n', maxit);
    end
end

function [f, J] = myFun(x)
    x1 = x(1);
    x2 = x(2);
    f = [x1^2 + x2^2 - 1; exp(x1) - x2];
    J = [2*x1, 2*x2; exp(x1), -1];
end