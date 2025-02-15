function YQ = spline0(X, Y, XQ)
% spline0 - Spline cubica naturale interpolante.
%
%   YQ = spline0(X, Y, XQ)
%
% Input:
%   X   - vettore delle ascisse (nodi), ordinato in modo crescente.
%   Y   - vettore dei valori corrispondenti.
%   XQ  - (opzionale) vettore dei punti in cui valutare la spline.
%
% Output:
%   YQ  - se vengono passati 2 argomenti, out è la struttura pp;
%         se vengono passati 3 argomenti, out contiene i valori della spline in xq.

    if nargin < 2
        error('Numero insufficiente di argomenti.');
    end
    if length(X) ~= length(Y)
        error('I vettori X e Y devono avere la stessa lunghezza.');
    end

    X = X(:);
    Y = Y(:);
    n = length(X);
    
    if n < 2
        error('Occorrono almeno 2 punti per l''interpolazione.');
    end

    nseg = n - 1;
    
    h = diff(X);
    d = diff(Y) ./ h;
    
    N = n - 2; 
    A = zeros(N, N);
    rhs = zeros(N, 1);
    
    for i = 1:N
        if i == 1
            A(i, i) = 2 * (h(1) + h(2));
            if N > 1
                A(i, i+1) = h(2);
            end
        elseif i == N
            A(i, i-1) = h(N);
            A(i, i) = 2 * (h(N) + h(N+1));
        else
            A(i, i-1) = h(i);
            A(i, i) = 2 * (h(i) + h(i+1));
            A(i, i+1) = h(i+1);
        end
        rhs(i) = 6 * (d(i+1) - d(i));
    end

    m = zeros(n, 1);
    if N > 0
        m(2:n-1) = A \ rhs;
    end

    coefs = zeros(nseg, 4);
    for i = 1:nseg
        a_i = (m(i+1) - m(i)) / (6 * h(i));
        b_i = m(i) / 2;
        c_i = d(i) - h(i) * (2*m(i) + m(i+1)) / 6;
        d_i = Y(i);
        coefs(i, :) = [a_i, b_i, c_i, d_i];
    end

    pp.form = 'pp';
    pp.breaks = X';
    pp.coefs = coefs;
    pp.pieces = nseg;
    pp.order = 4;
    pp.dim = 1;

    if nargin < 3
        YQ = pp;
    else
        YQ = ppval(pp, XQ);
    end
end