I_esatto = (exp(3) - 1) / 3;

kVals = [1, 2, 3, 6];
n = 12;

fprintf('   k    Appross        Errore (If - esatto)   Err stima\n');
for k = kVals
    [If, errStima] = composita(@(x) exp(3*x), 0, 1, k, n);
    errVero = abs(If - I_esatto);
    fprintf(' %3d  %12.6f  %18.3e  %12.3e\n', k, If, errVero, errStima);
end