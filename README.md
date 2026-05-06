# MyKayak

[![Flutter](https://img.shields.io/badge/Flutter-v3.11.0+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Licenza: MIT](https://img.shields.io/badge/Licenza-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Cos'é MyKayak
MyKayak é un'applicazione che consente di visualizzare i risultati delle gare di canoa e kayak cronometrate dalla FICr usando gli endpoint dell'API [MyKayak/api](https://github.com/MyKayak/api), che a sua volta si appoggia all'API della Federazione Italiana Cronometristi stessa.

## Funzionalitá
Oltre a tutte le funzionalitá offerte dal sito della FICr, MyKayak offre diverse analisi aggiuntive, tra cui le seguenti:
- Medaglieri delle società, sia per il singolo evento che per stagione
- Classifiche degli atleti basate sulla media dei loro tre migliori tempi.
- Pagine dedicate alle societá con tutti i titoli da loro vinti.
- Pagine dedicate agli atleti con:
    - Record personali
    - Progressione dei tempi
- Ricerca di atleti e società

## Roadmap
- Migliorare l'interfaccia utente per quanto riguarda la visualizzazione di gare e batterie.
- Aggiungere lo spostamento da batteria a semifinale e finale.
- Aggiungere l'analisi statistica del vantaggio basato sulla corsia (Utile per i campi gara sui fiumi)
- Rifare in backend in Go o Rust, per sostenere il  carico di picco.
- Redis?

## Stack
L'applicazione è fatta in flutter, le principali librerie usate sono:
- Objectbox per la persistenza
    - Per la semplicitá dell'utilizzo e per la velocitá.
- Riverpod per la gestione degli stati
    - Perché è il de-facto successore di Provider e perché nelle chiamate alla mia API mi costringe a trattare gli stati di caricamento ed errore.
- Go Router per la gestione delle schermate
    - Perché l'ho trovato comodo fin da subito, funziona perfettamente per la mia struttura e salva lo stato delle pagine principali.
- Fl Chart per i grafici
    - Perché consente di creare grafici visivamente apprezzabili senza eccessivo sforzo.

## Struttura progetto
Il progetto ha una struttura feature-first: il codice condiviso é nella cartella `core`, mentre il codice delle funzionalitá individuali é distribuito nelle apposite cartelle dentro a `features`.
```
lib
├── core
│   ├── api
│   ├── db
│   ├── router
│   ├── theme
│   ├── utils
│   └── widgets
├── features
│   ├── athletes
│   ├── auth
│   ├── medal_table
│   ├── meets
│   ├── rankings
│   ├── search
│   ├── settings
│   └── teams
├── main.dart
└── objectbox.g.dart
```
A loro volta le funzionalitá hanno diverse cartelle per separare i modelli (`models`), i gestori dello stato (`providers`), i widget (`widgets`) e le schermate (`view`).

## Iniziare

### Prerequisiti
- Flutter SDK (versione definita in `.fvmrc`)

### Consigli
- FVM (flutter version manager) per tenere piú versioni dell'SDK Flutter installate.

### Installazione
1. Clona la repo:
   ```bash
   git clone https://github.com/MyKayak/mobile
   cd mobile
   ```
2. Installa le dipendenze:
   ```bash
   fvm flutter pub get
   ```
3. Genera il codice necessario (Objectbox e Riverpod):
   ```bash
   fvm flutter pub run build_runner build --delete-conflicting-outputs
   ```
4. Avvia l'applicazione:
   ```bash
   fvm flutter run
   ```

## Licenza
Questo progetto è distribuito sotto la licenza MIT.