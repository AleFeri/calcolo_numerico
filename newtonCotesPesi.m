function w = newtonCotesPesi(n)
% NEWTONCOTESPESI Restituisce i pesi della formula di Newton-Cotes di grado n.
%
%   w = newtonCotesPesi(n) restituisce un vettore colonna di dimensione (n+1)x1,
%   i cui elementi sono i pesi della formula di quadratura chiusa su [0,n]:
%
%       ∫₀ⁿ f(x) dx ≈ ∑_{i=0}ⁿ w(i+1)*f(i)
%
%   I nodi usati sono: x₀=0, x₁=1, ..., xₙ=n.

    % Dichiarazione della variabile simbolica
    syms x;
    
    % Inizializzo il vettore dei pesi come simbolico
    w = sym(zeros(n+1,1));
    
    % Definisco i nodi: 0, 1, 2, ..., n
    nodes = sym(0:n);
    
    % Calcolo dei pesi: per ciascun nodo i calcolo il polinomio di Lagrange L_i(x)
    % e ne calcolo l'integrale in [0,n].
    for i = 1:n+1
        L = sym(1);
        for j = 1:n+1
            if j ~= i
                L = L * (x - nodes(j)) / (nodes(i) - nodes(j));
            end
        end
        % Integriamo L_i(x) su [0,n]
        w(i) = int(L, x, 0, n);
        % Semplifichiamo per ottenere il risultato come numero razionale
        w(i) = simplify(w(i));
    end
end