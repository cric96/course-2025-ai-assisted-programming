#import "@preview/touying:0.6.1": *
#import "themes/theme.typ": *
#import "@preview/fontawesome:0.6.0": *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly
#import "utils.typ": *

// Pdfpc configuration
// typst query --root . ./example.typ --field value --one "<pdfpc-file>" > ./example.pdfpc
#let pdfpc-config = pdfpc.config(
    duration-minutes: 30,
    start-time: datetime(hour: 14, minute: 10, second: 0),
    end-time: datetime(hour: 14, minute: 40, second: 0),
    last-minutes: 5,
    note-font-size: 12,
    disable-markdown: false,
    default-transition: (
      type: "push",
      duration-seconds: 2,
      angle: ltr,
      alignment: "vertical",
      direction: "inward",
    ),
  )

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

#show: theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(
    // handout: true,
    preamble: pdfpc-config,
    show-bibliography-as-footnote: bibliography(title: none, "bibliography.bib"),
  ),
  config-info(
    title: [AI-assisted Programming],
    subtitle: [Come l'AI sta cambiando il modo di programmare],
    author: author_list(
      (
        (first_author("Gianluca Aguzzi"), "gianluca.aguzzi@unibo.it"),
      )
    ),
    date: datetime.today().display("20 Ottobre 2025"),
    institution: [University of Bologna],
    logo: align(right)[#image("images/disi.svg", width: 55%)],
  ),
)

#set text(font: "Fira Sans", weight: "light", size: 20pt)

#set raw(tab-size: 4)
#show raw: set text(size: 1em)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: (x: 1em, y: 1em),
  radius: 0.7em,
  width: 100%,
)

#show bibliography: set text(size: 0.75em)
#show footnote.entry: set text(size: 0.75em)

// #set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()

// == Outline <touying:hidden>

// #components.adaptive-columns(outline(title: none, indent: 1em))
// == Sommario
== Sommario

#text(size: 1.3em)[
  #components.adaptive-columns(outline(title: none, indent: 1em, depth: 1))
]


== Ciao, Mondo :)
#grid(
  columns: (auto, 1fr),
  column-gutter: 2em,
  align(center + horizon)[
    #let foto = image("images/my-self-compact.png")
    #box(
      foto,
      stroke: 2pt + black,
      height: 150pt,
      radius: 100%,
      clip: true,
    )
  ],
  align(left + horizon)[
    *Gianluca Aguzzi* -- Postdoc & Ricercatore UniBo

    #v(0.5em)

    #text(size: 0.9em)[
      - *Ricerca*: Collective AI, Apprendimento Multi-Agente, Sistemi Auto-Organizzanti
      - *Focus*: LLMs, Sintesi di Programmi, Sviluppo Assistito da AI
      - *Didattica*: Advanced System Design and Modelling (ASDM), Paradigmi di Programmazione
      - *Progetti*: Core developer di [ScaFi](http://scafi.github.io/) (programmazione aggregata in Scala)
    ]


    #text(size: 0.85em, fill: gray)[
      #fa-icon("envelope")\~ gianluca.aguzzi\@unibo.it\ #fa-icon("globe")\~  https://cric96.github.io/
    ]
  ]
)




= AI-assisted Programming

== Cosa sta succedendo?
#figure(image("images/tweet-1.png", width: 100%))

== Cosa sta succedendo?
#figure(image("images/tweet-3.png", width: 100%))

== Cosa sta succedendo?
#figure(image("images/andreji.png", width: 60%))

== Cosa sta succedendo?
#figure(image("images/evolution.png", width: 100%))

== Costa sta succedendo?
#image("images/users.jpeg", width: 100%)

== Che cosa è l'AI-assisted Programming?
#definition-block(
  "Definizione",
  [
    #strong(emph([AI-assisted programming (AIP)])) è l'uso di tecniche di #strong(emph([intelligenza artificiale])) per #underline([assistere]) gli sviluppatori nel processo di #underline([scrittura]), #underline([revisione]) e #underline([manutenzione]) del codice.
  ]
)

#v(1em)

#note-block(
  "Obiettivo",
  [
    *Migliorare* #underline([produttività]) e #underline([qualità del codice]) attraverso #underline([suggerimenti intelligenti]), #underline([riduzione di task ripetitivi]), e #underline([identificazione proattiva]) di bug e vulnerabilità.
  ]
)

== AI-assisted - Cosa?

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  row-gutter: 0.8em,
  feature-card(
    fa-keyboard(),
    "Autocompletamento",
    "Scrive codice mentre digiti",
    rgb("#dbeafe"), rgb("#eff6ff"),
    rgb("#3b82f6"),
    rgb("#1e40af")
  ),
  feature-card(
    fa-search(),
    "Analisi",
    "Trova errori e vulnerabilità",
    rgb("#f3e8ff"), rgb("#faf5ff"),
    rgb("#a855f7"),
    rgb("#7c3aed")
  ),
  feature-card(
    fa-code(),
    "Generazione",
    "Da italiano a codice",
    rgb("#d1fae5"), rgb("#ecfdf5"),
    rgb("#10b981"),
    rgb("#059669")
  ),
  feature-card(
    fa-wrench(),
    "Refactoring",
    "Migliora il codice",
    rgb("#fecaca"), rgb("#fee2e2"),
    rgb("#ef4444"),
    rgb("#dc2626")
  ),
  feature-card(
    fa-file-text(),
    "Documentazione",
    "Genera guide automatiche",
    rgb("#bfdbfe"), rgb("#dbeafe"),
    rgb("#3b82f6"),
    rgb("#2563eb")
  ),
  feature-card(
    fa-bug(),
    "Debugging",
    "Risolve bug velocemente",
    rgb("#fed7aa"), rgb("#ffedd5"),
    rgb("#f97316"),
    rgb("#ea580c")
  )
)

== Che cosa non è l'AI-assisted Programming? (1/5)
#align(center)[
  #text(size: 1.5em, weight: "bold")[Non è un chatbot generico]
]


#concept-block("Caratteristiche")[
  - *Non è* semplicemente ChatGPT o altri LLM conversazionali usati senza integrazione
  - *Manca* l'accesso diretto al codice, al contesto del progetto e all'ambiente di sviluppo
  - *Richiede* copia-incolla manuale tra browser e IDE
  - *Non fornisce* feedback in tempo reale durante la scrittura del codice
]


#align(center)[
  #text(size: 0.9em, fill: rgb("#666666"))[
    _L'AI-assisted programming è integrato nell'IDE, non un servizio esterno separato_
  ]
]

== Che cosa non è l'AI-assisted Programming? (2/5)
#align(center)[
  #text(size: 1.5em, weight: "bold")[Non è un generatore di codice "one-shot"]
]

#v(1em)

#concept-block("Caratteristiche")[
  - *Non è* un tool web che genera codice da un prompt e basta (es: "crea una REST API")
  - *Manca* la visione del tuo progetto: quali librerie usi, come è strutturato il codice, lo stile del team
  - *Ignora* il contesto: se hai già una classe `User`, potrebbe crearne un'altra incompatibile
  - *Genera* codice "generico" che poi devi adattare manualmente al tuo progetto
]

#align(center)[
  #text(size: 0.85em, fill: rgb("#666666"))[
    _L'AI-assisted programming sa cosa c'è nel tuo progetto e genera codice già integrato_
  ]
]

== Che cosa non è l'AI-assisted Programming? (3/5)
#align(center)[
  #text(size: 1.5em, weight: "bold")[Non è solo IntelliSense o code snippets]
]

#concept-block("Caratteristiche")[
  - *Non è* il classico IntelliSense/autocomplete degli IDE (completamento basato su sintassi e tipi)
  - *Non è* limitato a snippet predefiniti (es: `for` → template di ciclo fisso)
  - *Manca* la comprensione semantica: IntelliSense suggerisce metodi disponibili, non cosa vuoi fare
  - *Non impara* dal contesto o dallo stile: ogni volta suggerisce le stesse cose
]

#align(center)[
  #text(size: 0.85em, fill: rgb("#666666"))[
    _L'AI-assisted programming "capisce" l'intento e genera codice contestuale, non solo completa sintassi_
  ]
]

== Pre AI: IDE e IntelliSense
#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  align: top,
  [
    #definition-block("IDE")[
      *Integrated Development Environment*
      - Editor + Compilatore + Debugger
      - Version control integration
      - Build automation
      
      #text(size: 0.8em, fill: gray)[VS Code, IntelliJ, Eclipse, PyCharm]
    ]
  ],
  [
    #concept-block("IntelliSense")[
      *Autocomplete intelligente*
      - Suggerimenti basati su *sintassi e tipi*
      - Analisi statica del codice (AST)
      - Documentazione inline
      - Quick fixes e import automatici
    ]
  ]
)

== Come Funziona IntelliSense?
#concept-block("Meccanismo")[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      *Analisi del Codice*
      - Parsing e costruzione AST
      - Type inference
      - Conosce API delle librerie
    ],
    [
      *Suggerimenti*
      - Filtra per tipo compatibile
      - Mostra firma dei metodi
      - Basato su regole fisse
    ]
  )
]

#v(0.5em)

#example-block("Esempio")[
  Digitando `list.` → mostra solo metodi di `List`: `add()`, `remove()`, `size()`
]

== Limitazioni: IntelliSense vs AI-Assisted
#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  align: top,
  [
    #warning-block("IntelliSense")[
      - ❌ Non comprende l'*intento*
      - ❌ Contesto *limitato* al file
      - ❌ Non *genera logica*
      - ❌ Regole *fisse*, non impara
      
      #v(0.5em)
      #text(size: 0.85em)[_Completa sintassi, non implementa algoritmi_]
    ]
  ],
  [
    #concept-block("AI-Assisted")[
      - ✅ Comprende *semantica e intento*
      - ✅ Contesto *intero progetto*
      - ✅ Genera *implementazioni complete*
      - ✅ *Apprende* da milioni di repository
      
      #v(0.5em)
      #text(size: 0.85em)[_Scrive codice funzionante, non solo suggerisce_]
    ]
  ]
)

== Che cosa non è l'AI-assisted Programming? (4/5)
#align(center)[
  #text(size: 1.5em, weight: "bold")[Non sostituisce lo sviluppatore]
]

#concept-block("Caratteristiche")[
  - *Non è* un sistema completamente autonomo che può sviluppare software da solo
  - *Richiede* supervisione, revisione critica e decisioni umane
  - *Non comprende* requisiti di business complessi o trade-off architetturali
  - *Non ha* responsabilità legale o etica sulle decisioni di design
]

#align(center)[
  #text(size: 0.9em, fill: rgb("#666666"))[
    _L'AI-assisted programming è uno strumento che amplifica le capacità dello sviluppatore_
  ]
]

== Che cosa non è l'AI-assisted Programming? (5/5)
#align(center)[
  #text(size: 1.5em, weight: "bold")[Non è Vibe Coding]
]
#concept-block("Caratteristiche")[
  - *Sviluppo guidato solo da linguaggio naturale* senza mai leggere o analizzare il codice generato
  - *Iterazioni chat-based*: descrivi problema → AI genera codice → esegui → se non funziona, ridescivi
  - *Nessuna ispezione del codice*: il programmatore non legge, non capisce, non valida quello che viene scritto
  - *Approccio "black-box"*: il codice è un mistero, si valuta solo se "funziona" o "non funziona"
]


#align(center)[
  #text(size: 0.85em, fill: rgb("#666666"))[
    _L'AI-assisted programming richiede comprensione, revisione critica e best practices_
  ]
]

== AI-assisted - Livelli di assistenza
#figure(image("images/level-of-ai.png", width: 80%))


== Livello 1: Code Completion
#concept-block("AI Suggerisce, Umano Guida")[
  - L'AI *completa singole righe o blocchi di codice*
  - Basato sul *contesto immediato* della scrittura
  - Lo sviluppatore mantiene il *controllo totale* della direzione
  - L'AI è un *acceleratore per task ripetitivi*
]

#example-block("Esempi")[
  Suggerimenti durante la digitazione, completamento di funzioni standard
]

== Livello 2: Code Creation
#concept-block("AI Crea, Umano Supervisiona")[
  - L'AI genera *sezioni più ampie di codice*
  - Può *progettare API e correggere codice esistente*
  - Richiede *comprensione del codebase e del contesto*
  - Lo sviluppatore *revisiona e integra* il codice generato
]

#example-block("Esempi")[
  Generazione di classi complete, implementazione di pattern architetturali
]

== Livello 3: Supervised Automation
#concept-block("AI Guida, Umano Valida")[
  - L'AI *gestisce task multipli* per obiettivi più ampi
  - Funziona come un *junior developer autonomo*
  - Può *correggere bug, aggiungere feature, integrare sistemi*
  - Richiede *supervisione* ma non controllo continuo
]

#example-block("Esempi")[
  Implementazione di feature end-to-end con revisione finale umana
]

== Livello 4: Full Automation
#concept-block("AI Autonoma, Supervisione Minima")[
  - L'AI gestisce *task complessi in completa autonomia*
  - *Non richiede approvazione umana* per ogni modifica
  - Opera come un *senior engineer fidato*
  - *Monitora proattivamente* il codice e risolve problemi
]

#example-block("Esempi")[
  Manutenzione continua, ottimizzazioni automatiche, gestione della qualità
]

== Livello 5: AI-Led Full Autonomy
#concept-block("AI Autonoma e Strategica")[
  - L'AI *definisce i propri obiettivi* e strategie
  - Non segue solo istruzioni, ma *opera su reward function*
  - *Interagisce con altri agenti AI* in modo indipendente
  - Scenario *futuristico ma plausibile* dato il progresso attuale
]

#example-block("Esempi")[
  Sistemi AI che evolvono autonomamente architetture e strategie di sviluppo
]


== Storia e contesto
- Obiettivo: migliorare la produttività e la qualità del codice

- Anni '80: sistemi di completamento automatico
- Anni '90: IDE con funzionalità
  - Refactoring
  - Analisi statica del codice
- Anni 2000: plugin e estensioni
- Anni 2010: modelli di linguaggio pre-addestrati


== AI-assisted vs Vibe Coding
- Claims
- Definizione
- Cosa c'era prima?
- Storia e contesto
- Importanza attuale
- Applicazioni principali
- Sfide e opportunità
- Implicazioni etiche

= Soluzioni Principali

== Tipologie di soluzioni
- Obiettivo generale

- Web based
- IDE
- Plugins

= Github Copilot
== Introduzione
== Copilot (Github)
#align(center)[
  #image("images/copilot-logo.png", width: 15%)
  
  #link("https://github.com/features/copilot")
]
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    #block(
      fill: rgb("#f7fafc"),
      width: 100%,
      inset: 1em,
      radius: 8pt,
      height: 50%,
      stroke: (paint: rgb("#cbd5e0"), thickness: 1pt),
      [
        #align(center)[#text(weight: "bold", size: 20pt)[Overview]]
        #v(0.5em)
        - Advanced AI coding assistant by GitHub/Microsoft
        - Released 2021, #text(weight: "bold")[20M+ active developers]
      ]
    )
  ],
  [
    #block(
      fill: rgb("#f0f9ff"),
      width: 100%,
      inset: 1em,
      radius: 8pt,
      height: 50%,
      stroke: (paint: rgb("#bae6fd"), thickness: 1pt),
      [
        #align(center)[#text(weight: "bold", size: 20pt)[Key Features #fa-code()]]
        #v(0.5em)
        - Real-time code suggestions #fa-lightbulb()
        - Context-aware assistance #fa-brain()
        - IDE integration (VS Code, JetBrains)
      ]
    )
  ]
)


== Copilot (Github)


- Cos'è
- Quando è stato rilasciato
- Come funziona
- Claims
- Come si installa
- presso
- Modalità d'uso: autocompletamento
- Pro e contro
- Modalità d'uso: chat inline
- Pro e contro
- Modalità d'uso: chat
- Pro e contro
- modalità di uso: agentic
- Pro e contro

== Demo Copilot

== Limitazioni e Criticità

= Conclusioni