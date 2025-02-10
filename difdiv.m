function df = difdiv(x, f)
%
%	df = difdiv(x, f)
%
%	Calcola le differenze divise sulle coppie (xi, fi)
%
%	Input:
%		x: vettore delle ascisse
%		f: vettore delle ordinate
%	Output:
%		df: vettore delle differenze divise

    n = length(x);
    if length(f) ~= n
	    error('Dati errati');
    end
    n = n-1;
    df = f;
    for j=1:n
	    for i = n+1:-1:j+1
		    df(i) = (df(i) - df(i-1))/(x(i) - x(i-j));
	    end
    end
return