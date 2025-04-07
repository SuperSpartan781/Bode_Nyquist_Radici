% --- Aquisizione dati e creazione della funzione di trasferimento ---
MODE = input('Scegli come inserire la fdT: (0 = N/D; 1 = F(s), -1 = esempio)');
if(isa(MODE, "numeric"))
    if(MODE == -1)
        fprintf('N/D: \nInserisci i coefficienti del numeratore: \n[1 5 6] \nInserisci i coefficienti del denominatore: \n[1 3 3 0] \n\n')
        fprintf('F(s): \nInserisci la funzione di trasferimento:\n(5*s + 1)/((s + 10)*(s + 1))');
        return
    elseif(MODE == 0)
        N = input('Inserisci i coefficienti del numeratore: ');
        D = input('Inserisci i coefficienti del denominatore: ');
        G = tf(N, D);
    elseif(MODE == 1)
        s = tf('s');
        G = input('Inserisci la funzione di trasferimento: ');
    else
        fprintf('Mode [%d] is not implemented.\n', MODE);
        return
    end
else
    fprintf('Specified value is not an integer.\n');
    return
end
display(G);

% --- Calcolo di zeri, poli, margini e molteplicita' ---
Z = zero(G);
P = pole(G);
[Gm, Pm, Wcg, Wcp] = margin(G);
Kpc = 1;
for i = 1:numel(P)
    Kpc = Kpc * sqrt(P(i)^2 + Wcg^2);
end
for i = 1:numel(Z)
    Kpc = Kpc / sqrt(Z(i)^2 + Wcg^2);
end
n_m = numel(P) - numel(Z);

% --- Calcolo di baricentro e punti doppi ---
Xs = real((sum(P)-sum(Z))/n_m);
syms s_sym; eq = 0;
for i = 1:numel(P)
    eq = eq + 1/(s_sym - P(i));
end
for i = 1:numel(Z)
    eq = eq - 1/(s_sym - Z(i));
end
P_doppi = vpasolve(eq, s_sym);

% --- Diagramma di Bode ---
figure;
margin(G);
grid on;
title('Diagramma di Bode');

% --- Diagramma di Nyquist ---
figure;
nyquist(G);
grid on;
title('Diagramma di Nyquist');

hold on
plot(1/Gm, 0, 'ro');
hold off

% --- Luogo delle radici ---
figure;
rlocus(G, 'b', -G, 'k');
grid on;
title('Luogo delle radici');

% --- Baricentro, asintoti e punti doppi ---
hold on;
plot(Xs, 0, 'rdiamond');

L = 100; % Lunghezza asintoti (arbitraria)
alpha = -pi;
theta = pi / n_m;
if(mod(n_m, 2) == 0)
    isPos = true;
else
    isPos = false;
end

for i = 0:2 * n_m
    alpha = alpha + theta;
    x1 = Xs + L * cos(alpha);
    y1 = L * sin(alpha);
    if(isPos)
        plot([Xs x1], [0 y1], 'b--');
    else
        plot([Xs x1], [0 y1], 'k--');
    end
    isPos = ~isPos;
end

for i = 1:numel(P_doppi)
    if(isreal(P_doppi(i)))
        plot(P_doppi(i), 0, 'rsquare');
    end
end
hold off;

% --- Stampa dei risultati ---
fprintf('\n--- Riposta Armonica ---\n');
fprintf('%cc = %.2f\n', 969, Wcg);
fprintf('%ct = %.2f\n', 969, Wcp);
fprintf('Kc = %.2f\n', Gm);
fprintf('Kpc = %.2f\n', Kpc);

fprintf('\n--- Luogo delle Radici ---\n');
fprintf('n-m = %d\n', n_m);
fprintf('Xs = %.2f\n', Xs);
fprintf('Punti doppi: [');
for i = 1:numel(P_doppi)
    if(isreal(P_doppi(i)))
        fprintf(' %.2f ', P_doppi(i));
    end
end
fprintf(']\n');
