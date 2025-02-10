close all; clearvars; clc;

for n = 1:100
    An = ones(n) .* -1 + diag(ones(1, n) * n + 1);
    factorizedA = mialdlt(An);
    plot((1:n), diag(factorizedA));
    hold on;
end
hold off;