x = [0 1 2 3 4];
y = [1 3 2 5 4];
xq = linspace(0,4,100);
yq = spline0(x, y, xq);
plot(x, y, 'ro', xq, yq, 'b-');