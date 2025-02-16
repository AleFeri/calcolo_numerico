function [soluzione, numIterazioni] = secanti(funzione, p0, p1, precisione, maxIterazioni)
% secanti - Calcola un'approssimazione della radice di una funzione
%           utilizzando il metodo delle secanti.
%
%   [soluzione, numIterazioni] = secanti(funzione, p0, p1, precisione, maxIterazioni)
%
% Input:
%   funzione      - Funzione per la quale trovare la radice (handle o funzione anonima).
%   p0, p1        - Due approssimazioni iniziali.
%   precisione    - Tolleranza richiesta (default: 1e-15).
%   maxIterazioni - Numero massimo di iterazioni (default: 1000).
%
% Output:
%   soluzione     - Approssimazione della radice trovata.
%   numIterazioni - Numero di iterazioni eseguite.
%

    if nargin < 3
        error('Numero insufficiente di argomenti in ingresso.');
    end
    if nargin == 3
        precisione    = 1e-15;
        maxIterazioni = 1000;
    elseif nargin == 4
        maxIterazioni = 1000;
    end

    if precisione <= 0
        error('La precisione deve essere un valore positivo.');
    end
    if maxIterazioni <= 0
        error('Il numero massimo di iterazioni deve essere maggiore di zero.');
    end

    f_p0 = funzione(p0);
    f_p1 = funzione(p1);
    
    numIterazioni = 0;
    erroreCorrente = Inf;

    while numIterazioni < maxIterazioni && erroreCorrente >= precisione
        numIterazioni = numIterazioni + 1;
        
        if f_p1 == f_p0
            error('Impossibile proseguire: f(p0) e f(p1) risultano uguali.');
        end
        
        pNuovo = ( f_p1 * p0 - f_p0 * p1 ) / ( f_p1 - f_p0 );
        erroreCorrente = abs(pNuovo - p1);
        
        p0 = p1;
        f_p0 = f_p1;
        p1 = pNuovo;
        f_p1 = funzione(p1);
    end

    if erroreCorrente >= precisione
        error('La radice non è stata trovata entro il numero massimo di iterazioni.');
    end

    soluzione = p1;
end