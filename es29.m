f = @(x) sin(x);
a = 0;
b = pi;
k = 2;
n = 10;

[If, err] = composita(f, a, b, k, n);

disp(['Approssimazione con n=', num2str(n), ' sottointervalli: ', num2str(If)]);
disp(['Stima errore: ', num2str(err)]);
disp(['Valore esatto: 2, differenza effettiva: ', num2str(abs(2 - If))]);