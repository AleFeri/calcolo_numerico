function [If, err] = composita(fun, a, b, k, n)
% composita - Applica la formula composta di Newton-Cotes di grado k 
% per approssimare ∫[a,b] fun(x) dx.
%
%   [If, err] = composita(fun, a, b, k, n)
%
% Input:
%   fun - handle alla funzione da integrare, accetta input vettoriali.
%   a   - estremo di integrazione a > b
%   b   - estremo di integrazione b >= a
%   k   - grado della formula di Newton-Cotes chiusa (k+1 nodi).
%   n   - numero di sottointervalli (deve essere multiplo di k).
%         l'intervallo [a,b] è diviso in n parti di uguale ampiezza.
%
% Output:
%   If   - approssimazione dell'integrale di fun su [a,b].
%   err  - stima dell'errore di quadratura (basata su un semplice 
%          confronto di Richardson, se possibile).

    % Controlli di validità sugli ingressi
    if a > b
        error("Estremi intervallo non validi (a deve essere <= b).");
    end
    if k < 1
        error("Grado k errato: deve essere >= 1.");
    end

    % Parametri di tolleranza e fattore per la stima dell'ordine
    tolleranza = 1e-3;
    ordineShift = 1 + mod(k,2);  % mu = 1 + mod(k,2)

    % Calcolo dei coefficienti della formula di Newton-Cotes di grado k
    coeffs = calcolaCoefficientiGrado(k);

    % Discretizzazione iniziale in n sottointervalli
    xx = linspace(a, b, n+1);
    fx = feval(fun, xx);
    h = (b - a) / n;

    % Prima approssimazione dell'integrale
    IfOld = h * sum( fx(1 : k+1) .* coeffs(1 : k+1) );

    % Inizializzo l'errore a un valore > tolleranza
    err = tolleranza + eps;

    % Ciclo di raddoppio di n finché l'errore stimato non è sotto tolleranza
    while tolleranza < err
        % Raddoppio del numero di sottointervalli
        n = n * 2;
        xx = linspace(a, b, n+1);

        % Riciclo i valori noti di fx e calcolo i nuovi (per i punti intermedi)
        fx(1 : 2 : n+1) = fx(1 : 1 : n/2 + 1);
        fx(2 : 2 : n)   = fun(xx(2 : 2 : n));

        % Nuovo passo
        h = (b - a) / n;

        % Calcolo dell'integrale con la formula composita aggiornata
        IfNew = 0;
        for i = 1 : (k+1)
            % Somma i valori fx nei punti corrispondenti
            IfNew = IfNew + h * sum(fx(i : k : n)) * coeffs(i);
        end
        % Aggiungo il termine corrispondente all'ultimo nodo
        IfNew = IfNew + h * fx(n+1) * coeffs(k+1);

        % Stima dell'errore (formula tipo Richardson)
        fattore = 2^(k + ordineShift) - 1;
        err = abs(IfNew - IfOld) / fattore;

        % Aggiorno la vecchia approssimazione
        IfOld = IfNew;
    end

    % Restituisco l'ultima approssimazione e l'errore stimato
    If = IfOld;
end


function coef = calcolaCoefficientiGrado(n)
% CALCOLACOEFFICIENTIGRADO  Restituisce i coefficienti di Newton-Cotes
% di grado n in un vettore colonna di dimensione (n+1) x 1.

    if n <= 0
        error('Valore del grado di Newton-Cotes non valido (n > 0 richiesto).');
    end

    coef = zeros(n+1, 1);

    % Caso n pari
    if mod(n,2) == 0
        for i = 0 : (n/2 - 1)
            coef(i+1) = calcolaCoefficienti(i, n);
        end
        % Coefficiente "centrale"
        coef(n/2 + 1) = n - 2 * sum(coef);

        % Rifletto la prima metà nella seconda
        coef((n/2)+1 : n+1) = coef((n/2)+1 : -1 : 1);

    else
        % Caso n dispari
        for i = 0 : (round(n/2,0) - 2)
            coef(i+1) = calcolaCoefficienti(i, n);
        end
        coef(round(n/2,0)) = (n - 2*sum(coef)) / 2;

        % Simmetria
        coef(round(n/2,0) + 1 : n+1) = coef(round(n/2,0) : -1 : 1);
    end
end


function cVal = calcolaCoefficienti(i, n)
% CALCOLACOEFFICIENTI  Calcola un singolo coefficiente della formula
% di Newton-Cotes di grado n, corrispondente al nodo i.

    % Denominatore = prodotto(i - j) per j != i
    diffVect = i - [0 : i-1, i+1 : n];
    denom = prod(diffVect);

    % Polinomio p(x) = ∏(x - radici), radici = [0, ..., i-1, i+1, ..., n]
    p = poly([0 : i-1, i+1 : n]);

    % Integra p(x) (grado n) su [0,n] => divisione dei coeff. per (n+1:-1:1)
    p = [ p ./ ((n+1):-1:1), 0 ];

    % Valore del polinomio integrato in x=n
    num = polyval(p, n);

    % Rapporto finale
    cVal = num / denom;
end