close all; clearvars; clc;

for dim = 1:100
    A = -ones(dim) + diag(ones(1, dim) * dim + 1);
    
    LDT = mialdlt(A);
    
    plot(1:dim, diag(LDT), 'LineWidth', 1.5);
    hold on;
end
hold off;