# Analisi di Sistemi tramite Funzione di Trasferimento in MATLAB

Questo script MATLAB consente di analizzare un sistema lineare tempo-invariante (LTI) rappresentato da una **funzione di trasferimento**. L'utente può inserire la funzione in diverse modalità e ottenere una gamma completa di informazioni e grafici relativi alla risposta in frequenza, stabilità e luogo delle radici.

## Funzionalità Principali

- Inserimento della funzione di trasferimento in tre modalità:
  - `-1`: Visualizzazione di un **esempio predefinito**
  - `0`: Inserimento tramite **coefficienti del numeratore e denominatore**
  - `1`: Inserimento tramite **espressioni simboliche N(s) / D(s)**
  - `2`: Generazione random **[WIP]**
- Calcolo automatico di:
  - Poli e zeri del sistema
  - Guadagno di Bode `K` (con valore in dB) e guadagno di Evans `Kp`
  - Guadagno di margine `Kc`, costante armonica `Kpc`
  - Margine di fase e frequenze caratteristiche `ωc`, `ωt`
  - Differenza `n − m` tra il numero di poli e zeri
  - Baricentro del luogo delle radici
  - Punti doppi del luogo delle radici
- Generazione automatica dei seguenti grafici:
  - **Diagramma di Bode**
  - **Diagramma di Nyquist**
  - **Luogo delle radici** con:
    - Baricentro evidenziato
    - Asintoti tracciati dinamicamente in base al segno di `Kp`
    - Punti doppi calcolati simbolicamente

## Come Utilizzarlo

1. Esegui lo script in MATLAB.
2. Alla richiesta iniziale, scegli il metodo di inserimento:
   - `-1` → Visualizza un esempio dimostrativo con input precompilati
   - `0` → Inserisci i vettori dei coefficienti `[N]`, `[D]`
   - `1` → Inserisci le espressioni simboliche `N(s)` e `D(s)`
   - `2` → Funzione di trasferimento random [WIP]

3. Osserva i grafici generati e i risultati numerici stampati nella console.

## Output Grafici

- **Diagramma di Bode**: visualizza modulo e fase in funzione della frequenza
- **Diagramma di Nyquist**: utile per l’analisi della stabilità
- **Luogo delle radici**: analizza la posizione delle radici al variare del guadagno, con indicazione di:
  - Baricentro (rosso)
  - Asintoti (linee tratteggiate blu o nere)
  - Punti doppi (quadrati rossi)

## Output Numerici

I risultati stampati includono:

- Guadagni a ciclo aperto:
  - `K`: guadagno di Bode (basse frequenze)
  - `KdB`: guadagno espresso in decibel
  - `Kp`: guadagno di Evans (alte frequenze)
- Risposta armonica:
  - Frequenza di attraversamento in ampiezza `ωc`
  - Frequenza di attraversamento in fase `ωt`
  - Guadagno di margine `Kc`
  - Costante armonica `Kpc`
- Luogo delle radici:
  - Differenza `n−m`
  - Baricentro `Xs`
  - Punti doppi reali (se presenti)

## Requisiti

- MATLAB con il **Control System Toolbox**
- Supporto per simboli (Symbolic Math Toolbox) per l'inserimento e la risoluzione simbolica

## Note

- I coefficienti simbolici inseriti in modalità `1` vengono convertiti automaticamente in vettori polinomiali tramite `sym2poly`.
- I punti doppi vengono calcolati come soluzioni dell'equazione ottenuta sottraendo le somme degli inversi delle distanze ai poli e zeri.
- La direzione degli asintoti nel luogo delle radici dipende sia da `n−m` che dal segno di `Kp`.

## Contatti

Per domande o suggerimenti, contattare lo sviluppatore del codice.
