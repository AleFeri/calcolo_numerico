function yy = hermite(xi, fi, f1i, xx)
% hermite - funzione che calcola il polinomio interpolante di Hermite
%
%   yy = hermite(xi, fi, f1i, xx)
% 
% Input:
%   xi  - vettore dei punti dati
%   fi  - valori della funzione in xi
%   f1i - valori delle derivate in xi
%   xx  - punti di valutazione
% 
% Output:
%   yy  - valori interpolati in xx

    if length(fi) ~= length(xi) || length(xi) <= 0 || length(xi) ~= length(f1i)
        error("Dimensioni errate");
    end

    if length(unique(xi)) ~= length(xi)
        error("Ascisse non distinte")
    end
    
    fi = repelem(fi, 2);
    for i = 1:length(f1i)
        fi(i*2) = f1i(i);
    end
    df = difdivHermite(xi, fi);
    n = length(df) - 1;
    yy = df(n+1) * ones(size(xx));
    for i = n:-1:1
        yy = yy.*(xx - xi(round(i/2))) + df(i);
    end
end