close all; clearvars; clc;

x0 = [0.5; 0.5];
[sol, iter] = newton2(@myFun, x0);

function [f, J] = myFun(x)
    x1 = x(1);
    x2 = x(2);
    f = [x1^2 + x2^2 - 1; exp(x1) - x2];
    J = [2*x1, 2*x2; exp(x1), -1];
end