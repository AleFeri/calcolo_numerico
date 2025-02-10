x = [0, 1, 2, 3];
y = [1, 2, 0, 2];
xx = linspace(0, 3, 100);
yy = newton3(x, y, xx);

plot(x, y, 'ro', 'MarkerFaceColor', 'r');
hold on;
plot(xx, yy, 'b-', 'LineWidth', 1.5);
hold off;
xlabel('x');
ylabel('Interpolazione di Newton');
title('Interpolazione polinomiale con la forma di Newton');
grid on;