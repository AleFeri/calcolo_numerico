function out = spline0(x, y, xq)
% SPLINE0  Spline cubica naturale interpolante.
%
%   PP = SPLINE0(X, Y) calcola la spline cubica naturale (con seconda derivata
%   nulla agli estremi) che interpola i punti (X, Y) e restituisce la struttura
%   in forma piecewise polynomial (pp).
%
%   YQ = SPLINE0(X, Y, XQ) restituisce i valori della spline valutata nei punti XQ.
%
%   Input:
%       x  - vettore delle ascisse (nodi), ordinato in modo crescente.
%       y  - vettore dei valori corrispondenti.
%       xq - (opzionale) vettore dei punti in cui valutare la spline.
%
%   Output:
%       out - se vengono passati 2 argomenti, out è la struttura pp;
%             se vengono passati 3 argomenti, out contiene i valori della spline in xq.

    % Verifica input
    if nargin < 2
        error('Numero insufficiente di argomenti.');
    end
    if length(x) ~= length(y)
        error('I vettori x e y devono avere la stessa lunghezza.');
    end
    
    x = x(:);  % rendi colonna
    y = y(:);
    n = length(x);
    if n < 2
        error('Occorrono almeno 2 punti.');
    end

    % Numero di intervalli
    nseg = n - 1;
    
    % Calcolo degli intervalli
    h = diff(x);  % vettore di lunghezze: h(i) = x(i+1)-x(i)
    
    % Calcolo delle differenze prime
    d = diff(y)./h;
    
    % Costruzione del sistema lineare per le seconde derivate m
    % Il sistema (per i = 2,.., n-1) è:
    %    h(i-1)*m(i-1) + 2*(h(i-1)+h(i))*m(i) + h(i)*m(i+1) = 6*(d(i)-d(i-1))
    % Con le condizioni naturali: m(1) = m(n) = 0.
    N = n - 2;  % numero di incognite (m(2)...m(n-1))
    A = zeros(N, N);
    rhs = zeros(N,1);
    for i = 1:N
        if i == 1
            A(i,i) = 2*(h(1) + h(2));
            if N > 1
                A(i,i+1) = h(2);
            end
        elseif i == N
            A(i,i-1) = h(N);
            A(i,i) = 2*(h(N) + h(N+1));
        else
            A(i,i-1) = h(i);
            A(i,i)   = 2*(h(i) + h(i+1));
            A(i,i+1) = h(i+1);
        end
        rhs(i) = 6*(d(i+1) - d(i));
    end
    
    m = zeros(n,1);
    if N > 0
        m(2:n-1) = A\rhs;
    end
    % m(1) e m(n) restano 0 (condizioni naturali)

    % Calcolo dei coefficienti dei polinomi su ciascun intervallo
    % La formula classica per la spline in [x(i), x(i+1)] è:
    %
    %  S_i(x) = m(i)/(6*h(i))*(x(i+1)-x)^3 + m(i+1)/(6*h(i))*(x-x(i))^3 ...
    %           + ((y(i) - m(i)*h(i)^2/6)*(x(i+1)-x) + (y(i+1) - m(i+1)*h(i)^2/6)*(x-x(i)))/h(i)
    %
    % Espressa nella forma polinomiale locale in z = (x-x(i)):
    %  S_i(x) = a_i*z^3 + b_i*z^2 + c_i*z + d_i,    z = x-x(i)
    %
    % Dove:
    %  a_i = (m(i+1) - m(i))/(6*h(i))
    %  b_i = m(i)/2
    %  c_i = (y(i+1)-y(i))/h(i) - h(i)*(2*m(i)+m(i+1))/6
    %  d_i = y(i)
    %
    coefs = zeros(nseg, 4);
    for i = 1:nseg
        a_i = (m(i+1) - m(i))/(6*h(i));
        b_i = m(i)/2;
        c_i = (y(i+1)-y(i))/h(i) - h(i)*(2*m(i)+m(i+1))/6;
        d_i = y(i);
        coefs(i,:) = [a_i, b_i, c_i, d_i];
    end

    % Costruzione della struttura pp (piecewise polynomial)
    pp.form   = 'pp';
    pp.breaks = x';
    pp.coefs  = coefs;   % ogni riga corrisponde a un intervallo
    pp.pieces = nseg;
    pp.order  = 4;
    pp.dim    = 1;
    
    % Se viene richiesto solo la spline in forma pp, restituisci la struttura
    if nargin < 3
        out = pp;
    else
        % Altrimenti, valuta la spline nei punti xq usando la funzione built-in ppval.
        out = ppval(pp, xq);
    end

end