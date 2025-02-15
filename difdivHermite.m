function df = difdivHermite(X, Y)
% difdivHermite - Calcola le differenze divise di Hermite sulle coppie (xi, fi)
%
%	df = difdivHermite(X, Y)
%
% Input:
%   X   - vettore delle ascisse
%	Y   - vettore delle ordinate e delle derivate della forma [f(0) f'(0) f(1)...]
%
% Output:
%	df  - vettore delle differenze divise di Hermite
%
    n = length(X)-1;
    df = Y;
    for i = (2*n+1):-2:3
	    df(i) = (df(i)-df(i-2))/(X((i+1)/2)-X((i-1)/2));
    end
    for j = 2:2*n+1
	    for i = (2*n+2):-1:j+1
		    df(i) = (df(i)-df(i-1))/(X(round(i/2))-X(round((i-j)/2)));
	    end
    end
end