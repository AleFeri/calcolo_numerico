function [radice, iterazioni] = bisezione(funzione, estremoSx, estremoDx, tolleranza, maxIter)
% bisezione - Approssima la radice di una funzione mediante il metodo della bisezione.
%
%   [radice, iterazioni] = bisezione(funzione, estremoSx, estremoDx, tolleranza, maxIter)
%
% Input:
%   funzione     - Funzione di cui cercare la radice (accetta vettori)
%   estremoSx    - Estremo sinistro dell'intervallo (deve essere < estremoDx)
%   estremoDx    - Estremo destro dell'intervallo
%   tolleranza   - Precisione richiesta (default: 1e-6)
%   maxIter      - Numero massimo di iterazioni (default: ceil(log2(estremoDx-estremoSx)-log2(tolleranza)))
%
% Output:
%   radice       - Approssimazione della radice
%   iterazioni   - Numero di iterazioni effettuate

    if nargin < 3
        error('Sono necessari almeno 3 argomenti.');
    end
    if nargin < 4 || isempty(tolleranza)
        tolleranza = 1e-6;
    end
    if nargin < 5 || isempty(maxIter)
        maxIter = ceil(log2(estremoDx - estremoSx) - log2(tolleranza));
    end

    if estremoSx >= estremoDx
        error('Intervallo non valido: l''estremo sinistro deve essere minore di quello destro.');
    end
    if tolleranza <= 0
        error('La tolleranza deve essere positiva.');
    end

    fSx = funzione(estremoSx);
    fDx = funzione(estremoDx);

    if fSx == 0
        radice = estremoSx;
        iterazioni = 0;
        return;
    end
    if fDx == 0
        radice = estremoDx;
        iterazioni = 0;
        return;
    end

    if fSx * fDx > 0
        error('La funzione non cambia segno nell''intervallo fornito.');
    end

    iterazioni = 0;  
    radice = (estremoSx + estremoDx) / 2;

    while iterazioni < maxIter
        iterazioni = iterazioni + 1;
        radice = (estremoSx + estremoDx) / 2;
        fRadice = funzione(radice);

        derivataAppross = abs(fDx - fSx) / (estremoDx - estremoSx);

        if abs(fRadice) / abs(derivataAppross) <= tolleranza
            break;
        end

        if fSx * fRadice > 0
            estremoSx = radice;
            fSx = fRadice;
        else
            estremoDx = radice;
            fDx = fRadice;
        end
    end
end