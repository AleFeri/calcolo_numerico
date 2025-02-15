function [If, err] = composita(fun, a, b, k, n)
% composita - Applica la formula composta di Newton-Cotes di grado k 
% per approssimare ∫[a,b] fun(x) dx.
%
%   [If, err] = composita(fun, a, b, k, n)
%
% Input:
%   fun - handle alla funzione da integrare, accetta input vettoriali.
%   a   - estremo di integrazione a < b
%   b   - estremo di integrazione b >= a
%   k   - grado della formula di Newton-Cotes chiusa (k+1 nodi).
%   n   - numero di sottointervalli (deve essere multiplo di k).
%         l'intervallo [a,b] è diviso in n parti di uguale ampiezza.
%
% Output:
%   If   - approssimazione dell'integrale di fun su [a,b].
%   err  - stima dell'errore di quadratura (basata su un semplice 
%          confronto di Richardson, se possibile).

    if a > b
        error("Estremi intervallo non validi (a deve essere <= b).");
    end
    if k < 1
        error("Grado k errato: deve essere >= 1.");
    end

    tolleranza = 1e-3;
    ordineShift = 1 + mod(k,2);

    coeff = calcolaCoeffGrad(k);

    xx = linspace(a, b, n+1);
    fx = feval(fun, xx);
    h = (b - a) / n;

    IfO = h * sum( fx(1 : k+1) .* coeff(1 : k+1) );

    err = tolleranza + eps;

    while tolleranza < err
        n = n * 2;
        xx = linspace(a, b, n+1);

        fx(1 : 2 : n+1) = fx(1 : 1 : n/2 + 1);
        fx(2 : 2 : n)   = fun(xx(2 : 2 : n));

        h = (b - a) / n;

        IfN = 0;
        for i = 1 : (k+1)
            IfN = IfN + h * sum(fx(i : k : n)) * coeff(i);
        end
        IfN = IfN + h * fx(n+1) * coeff(k+1);

        fattore = 2^(k + ordineShift) - 1;
        err = abs(IfN - IfO) / fattore;

        IfO = IfN;
    end

    If = IfO;
end


function coef = calcolaCoeffGrad(n)
% calcolaCoeffGrad - Restituisce i coefficienti di Newton-Cotes
% di grado n in un vettore colonna di dimensione (n+1) x 1.

    if n <= 0
        error('Valore del grado di Newton-Cotes non valido (n > 0 richiesto).');
    end

    coef = zeros(n+1, 1);

    if mod(n,2) == 0
        for i = 0 : (n/2 - 1)
            coef(i+1) = calcolaCoeff(i, n);
        end
        coef(n/2 + 1) = n - 2 * sum(coef);

        coef((n/2)+1 : n+1) = coef((n/2)+1 : -1 : 1);

    else
        for i = 0 : (round(n/2,0) - 2)
            coef(i+1) = calcolaCoeff(i, n);
        end
        coef(round(n/2,0)) = (n - 2*sum(coef)) / 2;

        coef(round(n/2,0) + 1 : n+1) = coef(round(n/2,0) : -1 : 1);
    end
end


function cVal = calcolaCoeff(i, n)
% calcolaCoeff - Calcola un singolo coefficiente della formula
% di Newton-Cotes di grado n, corrispondente al nodo i.

    diffVect = i - [0 : i-1, i+1 : n];
    denom = prod(diffVect);

    p = poly([0 : i-1, i+1 : n]);

    p = [ p ./ ((n+1):-1:1), 0 ];

    num = polyval(p, n);

    cVal = num / denom;
end