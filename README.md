# Analisi di Sistemi tramite Funzione di Trasferimento in MATLAB

Questo script MATLAB consente di analizzare un sistema lineare tempo-invariante (LTI) rappresentato da una **funzione di trasferimento**.
L'utente può inserire la funzione di trasferimento in diverse modalità e ottenere una varietà di informazioni e grafici relativi alla risposta in frequenza, stabilità e luogo delle radici.

## 📌 Funzionalità Principali

- Inserimento della funzione di trasferimento:
  - Come rapporto **Numeratore/Denominatore**
  - Come **espressione simbolica F(s)**
  - Esempio predefinito per test rapidi
- Calcolo automatico di:
  - Poli e zeri del sistema
  - Guadagno di margine (Gm), fase di margine (Pm)
  - Frequenze di attraversamento della fase e dell’ampiezza
  - Costante Kpc per risposta armonica
  - Differenza tra numero di poli e zeri (n−m)
  - Baricentro del luogo delle radici
  - Punti doppi del luogo delle radici
- Generazione grafica di:
  - Diagramma di **Bode**
  - Diagramma di **Nyquist**
  - **Luogo delle radici** con baricentro, asintoti e punti doppi evidenziati

## ▶️ Come Usarlo

1. Avvia lo script in MATLAB.
2. Alla richiesta iniziale, seleziona il metodo di inserimento della funzione di trasferimento:
   - `0` → Inserimento tramite vettori [numeratore] e [denominatore]
   - `1` → Inserimento come espressione simbolica `F(s)`
   - `-1` → Visualizzazione di un esempio dimostrativo

3. Osserva i grafici e i risultati stampati nella console.

## 📈 Output Grafici

- **Bode plot**: Mostra la risposta in frequenza (modulo e fase)
- **Nyquist plot**: Analisi della stabilità del sistema
- **Root Locus**: Analisi delle radici in funzione del guadagno

## 🧮 Output Numerici

Al termine dell'esecuzione vengono visualizzati:
- Frequenze caratteristiche (`ωc`, `ωt`)
- Guadagni `Kc` e `Kpc`
- Baricentro `Xs` e punti doppi del luogo delle radici

## 🛠 Requisiti

- MATLAB con il **Control System Toolbox**
- Nessuna dipendenza esterna

## 📋 Note

- I punti doppi vengono calcolati come radici dell’equazione simbolica ottenuta dalla differenza tra le somme degli inversi delle distanze di poli e zeri.

---
