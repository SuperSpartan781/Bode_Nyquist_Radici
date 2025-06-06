% --- Aquisizione dati e creazione della funzione di trasferimento ---
fprintf('-1 = esempio; \n0 = coeffs(N) / coeffs(D); \n1 = N(s) / D(s); \n2 = random [WIP]; \n');
MODE = input('Scegli come inserire la fdT: \n');
if(isa(MODE, "numeric"))
    if(MODE == -1)
        fprintf('--- 0: \nInserisci i coefficienti del numeratore: \n[1 5 6] \nInserisci i coefficienti del denominatore: \n[1 3 3 0] \n\n')
        fprintf('--- 1: \nInserisci N(s): \n5*s + 1 \nInserisci D(s): \n(s + 10)*(s + 1) \n\n');
        return
    elseif(MODE == 0)
        N = input('Inserisci i coefficienti del numeratore: ');
        D = input('Inserisci i coefficienti del denominatore: ');
        G = tf(N, D);
    elseif(MODE == 1)
        syms s;
        N = sym2poly(input('Inserisci N(s): '));
        D = sym2poly(input('Inserisci D(s): '));
        G = tf(N, D);
    elseif(MODE == 2)
        m = input('Inserisci il numero di zeri desiderato: [0 - 10] \n');
        Z = randi([-5 5], 1, m);
        n = input('Inserisci il numero di poli desiderato: [0 - 10] \n');
        P = randi([-5 5], 1, n);
        G = zpk(Z, P, randi([-10 10]));
        [N, D] = tfdata(tf(zpk(G)), 'v');
    else
        fprintf('Mode [%d] is not implemented.\n', MODE);
        return
    end
else
    fprintf('Specified value is not an integer.\n');
    return
end
display(G);

% --- Calcolo di guadagni, zeri, poli, margini e molteplicita' ---
if(D(numel(D)) == 0)
    K = N(numel(N)) / D(numel(D) - 1);
else
    K = N(numel(N)) / D(numel(D));
end
Kp = N(1) / D(1);
Z = zero(G);
P = pole(G);
[Gm, Pm, Wcg, Wcp] = margin(G);
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
plot(-1/Gm, 0, 'ro');
hold off

% --- Luogo delle radici ---
figure;
rlocus(G, 'b', -G, 'k');
grid on;
title('Luogo delle radici');

% --- Baricentro, asintoti e punti doppi ---
hold on;
plot(Xs, 0, 'rdiamond');

alpha = -180;
theta = 180 / abs(n_m);
if(mod(n_m, 2) == 0)
    isPos = true;
else
    isPos = false;
end
if(Kp < 0)
    isPos = ~isPos;
end

for i = 1:2 * abs(n_m) - 1
    alpha = alpha + theta;
    x1 = Xs + 10 * max(xlim) * cos(deg2rad(alpha));
    y1 = 10 * max(ylim) * sin(deg2rad(alpha));
    if(abs(alpha) ~= 180 && abs(alpha) ~= 0)
        if(isPos)
            plot([Xs x1], [0 y1], 'b--');
        else
            plot([Xs x1], [0 y1], 'k--');
        end
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
fprintf('\n--- Guadagni ---\n');
fprintf('K = %.2f = %.2fdB\n', K, mag2db(abs(K)));
fprintf('Kp = %.2f\n', Kp);

fprintf('\n--- Margini ---\n');
fprintf('mg = %.2f = %.2fdB [@ %cc = %.2frad/s]\n', Gm, mag2db(Gm), 969, Wcg);
fprintf('m%c = %.2f° [@ %ct = %.2frad/s]\n', 966, Pm, 969, Wcp);

fprintf('\n--- Luogo delle Radici ---\n');
fprintf('n-m = %d\n', n_m);
fprintf('Xs = %.2f\n', Xs);
fprintf('Punti doppi: [');
for i = 1:numel(P_doppi)
    if(isreal(P_doppi(i)))
        fprintf(' Xd%d = %.2f ', i, P_doppi(i));
    end
end
fprintf(']\n');
