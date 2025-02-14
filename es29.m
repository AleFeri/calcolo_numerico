f = @(x) sin(x);
a = 0; 
b = pi;
k = 2;
n = 10;
[If, err] = composita(f, a, b, k, n);

disp(['Approssimazione integrale: ', num2str(If)]);
disp(['Stima errore: ', num2str(err)]);