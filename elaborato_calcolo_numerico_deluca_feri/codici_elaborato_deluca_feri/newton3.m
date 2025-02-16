function YQ = newton3(X, Y, XQ)
% newton3 - Interpolazione polinomiale di Newton
%
%	YQ = newton3(X, Y, XQ)
%
% Input:
%   X  - Vettore dei nodi di interpolazione
%   Y  - Vettore dei valori corrispondenti ai nodi
%   XQ - Vettore di punti nei quali valutare l'interpolazione
%
% Output:
%   yy - Vettore contenente i valori interpolati in xx

    if length(X) ~= length(Y) || length(X) <= 0
	    error('I vettori X e Y devono avere la stessa dimensione e non essere vuoti.');
    end
    
    if length(unique(X)) ~= length(X)
	    error('Le ascisse in X devono essere distinte.');
    end
    df = difdiv(X, Y);
    n = length(df) - 1;
    YQ = df(n+1) * ones(size(XQ));
    for i = n:-1:1
	    YQ = YQ.*(XQ - X(i)) + df(i);
    end
return
