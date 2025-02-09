omega = [0.5; 0.5; 0.75; 0.25; 0.25];
B = diag(sqrt(omega));
A = [7 2 1; 8 7 8; 7 0 7; 4 3 3; 7 0 10];
b = [1; 2; 3; 4; 5];
[x, nr] = es08_miaqr(B*A, B*b);

table(x)