function A = mialdlt(A)
    [m, n] = size(A);
    if m ~= n
	    error('La matrice non è quadrata!');
    end
    
    if A(1,1) <= 0
     error('Matrice non sdp');
    end
    
    A(2:n, 1) = A(2:n, 1) / A(1,1);
    for j = 2:n
	    v = (A(j, 1:j-1).') .* diag(A(1:j-1, 1:j-1));
	    A(j, j) = A(j, j) - A(j, 1:j-1) * v;
	    if A(j, j) <= 0
		    error('Matrice non sdp');
	    end
	    A(j+1:n, j) = (A(j+1:n, j) - A(j+1:n, 1:j-1) * v) / A(j, j);
    end
end