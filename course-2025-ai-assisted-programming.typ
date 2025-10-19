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
    institution: [Università di Bologna - DISI],
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
#focus-slide[
  == Obiettivi
  #align(left)[
    - Cos'è #strong(emph([AI-assisted programming])) e perché è #underline([importante])
    - #strong([Soluzioni e strumenti principali]) (focus su #emph([GitHub Copilot]))
    - #strong([Demo pratica]) e discussione sulle #underline([funzionalità])
      - Così da comprendere meglio come l'AI può supportare il lavoro degli sviluppatorie e non.
    - #strong([Limiti]) e #emph([criticità]) dell'AI-assisted programming
  ]
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
      - *Didattica*: Advanced System Design and Modelling (ASDM), Paradigmi di Programmazione e Sviluppo 
     
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
    "Da testo a codice",
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

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: top,
  [
    #concept-block("AI × Software Engineering")[
      #text(size: 0.85em)[
        - *Focus*: Prodotto — potenziare sviluppo e output
        - *Scopo*: supportare sviluppatori (coding, testing, refactoring)
        - *Come*: autocompletamento, test/doc generation, refactoring, bug detection
        - *Esempi*: GitHub Copilot, test generators, code-review assistants
        - *Metriche*: time-to-delivery, defect density, test coverage
      ]
    ]
  ],
  [
    #concept-block("Software Engineering × AI")[
      #text(size: 0.85em)[
        - *Focus*: Processo — infrastruttura e workflow AI in produzione
        - *Scopo*: architetture, pipeline e governance per modelli/agenti
        - *Come*: RAG pipelines, model serving, observability, agentic systems
        - *Esempi*: infrastrutture RAG, MLflow/KFServing, agent orchestrators
        - *Metriche*: latenza, disponibilità, compliance, costo operativo
      ]
    ]
  ]
)

#v(0.6em)

#align(center)[
  #text(size: 0.85em, style: "italic")[AI × SE ottimizza il "cosa" (prodotto), SE × AI definisce il "come" (processo)]
]


== AI-assisted - Anatomia delle Soluzioni
#align(center)[
  #text(size: 1.2em, weight: "bold")[Componenti fondamentali di un tool AI-assisted]
]

#v(0.5em)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1em,
  align: top,
  [
    #text(size: 0.8em)[
      #concept-block("1. Editor/IDE")[
        - Ambiente di sviluppo
        - Contesto locale
        - UI per suggerimenti
        - Feedback real-time
        
        #v(0.2em)
        #text(size: 0.7em, fill: gray, style: "italic")[
          VS Code, IntelliJ, Cursor
        ]
      ]
    ]
  ],
  [
    #text(size: 0.8em)[
      #concept-block("2. Modello AI")[
        - LLM genera codice
        - Milioni di repository
        - Semantica e intento
        - Pattern e best practices
        
        #v(0.2em)
        #text(size: 0.7em, fill: gray, style: "italic")[
          GPT-4, Claude, Codex
        ]
      ]
    ]
  ],
  [
    #text(size: 0.8em)[
      #concept-block("3. Integrazione")[
        - Plugin/API di collegamento
        - Gestione workflow
        - Comunicazione bidirezionale
        - Coordinamento tool
        
        #v(0.2em)
        #text(size: 0.7em, fill: gray, style: "italic")[
          Extension, language server
        ]
      ]
    ]
  ]
)

== AI-assisted - Componenti Tecnici Avanzati

#text(size: 0.75em)[
  #concept-block("4. Context Indexing & Retrieval")[
    #grid(
      columns: (1fr, 1fr),
      gutter: 0.8em,
      [
        *Indicizzazione Progetto*
        - #strong([Parsing e AST]): analisi strutturale
        - #strong([Symbol tables]): funzioni, classi, variabili
        - #strong([Dependency graph]): relazioni moduli
        - #strong([Vector embeddings]): semantica
      ],
      [
        *Context Retrieval*
        - File aperti/attivi nell'editor
        - Codice selezionato dall'utente
        - Ricerca semantica (`#codebase`)
        - Storia modifiche (git history)
      ]
    )
  ]
]

#v(0.3em)

#text(size: 0.7em)[
  #note-block("Perché è importante")[
    L'indexing permette all'AI di "vedere" l'intero progetto. Senza context retrieval, l'AI genererebbe codice generico e disconnesso dalla codebase.
  ]
]

== AI-assisted - Indexing & Retrieval
#align(center)[
  #image("images/embedding.png", width: 80%)
]
- Avete già sentito parlare di #strong[RAG]
- Queste tecniche vengono #strong([utilizzate]) anche (e #strong([soprattutto])) per il #underline([codice])
- Si fa in modo che il nostro modello AI #strong([conosca]) il #underline([contesto del progetto])

== AI-assisted - Tool Use & Agentic Capabilities

#text(size: 0.75em)[
  #concept-block("5. Tool Integration")[
    Maggiori capacità di integrazione = migliore esperienza:
    
    #grid(
      columns: (1fr, 1fr),
      gutter: 0.8em,
      [
        *Tool Passivi (Base)*
        - Completamento codice
        - Suggerimenti inline
        - Chat Q&A
        - Documentazione
      ],
      [
        *Tool Attivi (Agentic)*
        - Esecuzione comandi terminal
        - Navigazione autonoma codebase
        - Web search e fetch
        - Modifiche multi-file coordinate
        - Testing e validazione automatica
      ]
    )
  ]
]

#v(0.3em)

#text(size: 0.7em)[
  #warning-block("Livello di autonomia")[
    I tool avanzati (agent mode) possono pianificare ed eseguire task complessi autonomamente. Vedremo nella prossima lezione l'Agentic AI.
  ]
]


== AI-assisted - Flusso di Lavoro Completo

#align(center)[
  #text(size: 1.1em, weight: "bold")[Come si combinano i componenti]
]

#v(0.8em)

#let flow-box(emoji, label, fill-color, stroke-color, width: 100pt, text-size: 0.75em) = {
  box(
    fill: fill-color,
    stroke: 2pt + stroke-color,
    radius: 5pt,
    inset: 10pt,
    width: width,
    height: 80pt,
    [#align(center + horizon)[#text(size: text-size, weight: "bold")[#emoji\ #label]]]
  )
}

#let arrow = [#text(size: 1.8em)[→]]

#align(center)[
  #grid(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
    gutter: 12pt,
    align: center + horizon,
    
    flow-box("👤", "Sviluppatore", rgb("#dbeafe"), rgb("#3b82f6")),
    arrow,
    flow-box("💻", [Editor/\ IDE], rgb("#e0e7ff"), rgb("#6366f1")),
    arrow,
    flow-box("🔍", [Context\ Indexing &\ Retrieval], rgb("#f3e8ff"), rgb("#a855f7"), width: 110pt, text-size: 0.7em),
    arrow,
    flow-box("🤖", [LLM\ (AI Model)], rgb("#fef3c7"), rgb("#f59e0b")),
    arrow,
    flow-box("✅", [Output &\ Integrazione], rgb("#fed7aa"), rgb("#f97316"), text-size: 0.7em),
  )
]


#align(center)[
  #text(size: 0.7em)[↓ _Agent Mode (opzionale)_ ↓]
  
  #flow-box("⚙️", [Tool Execution: terminal, search, test, refactor], rgb("#d1fae5"), rgb("#10b981"), width: 280pt)
]


#align(center)[
  #text(size: 1.2em)[⤴ #text(size: 0.7em, style: "italic")[Feedback iterativo] ⤴]
]


== AI-assisted - Livelli di assistenza
#figure(image("images/level-of-ai.png", width: 80%))


== Livello 1: Code Completion
#concept-block("L'AI Suggerisce, L'Umano Guida")[
  - L'AI *completa singole righe o blocchi di codice*
  - Basato sul *contesto immediato* della scrittura
  - Lo sviluppatore mantiene il *controllo totale* della direzione
  - L'AI è un *acceleratore per task ripetitivi*
]

#example-block("Esempi")[
  Suggerimenti durante la digitazione, completamento di funzioni standard
]

== Livello 2: Code Creation
#concept-block("L'AI Crea, L'Umano Supervisiona")[
  - L'AI genera *sezioni più ampie di codice*
  - Può *progettare API e correggere codice esistente*
  - Richiede *comprensione del codebase e del contesto*
  - Lo sviluppatore *revisiona e integra* il codice generato
]

#example-block("Esempi")[
  Generazione di classi complete, implementazione di pattern architetturali
]

== Livello 3: Supervised Automation
#concept-block("L'AI Guida, L'Umano Valida")[
  - L'AI *gestisce task multipli* per obiettivi più generali
  - Funziona (idealmente) come un *junior developer autonomo*
  - Può *correggere bug, aggiungere feature, integrare sistemi*
  - Richiede *supervisione* ma non controllo continuo
]

#example-block("Esempi")[
  Implementazione di feature end-to-end con revisione finale umana
]

== Livello 4: Full Automation
#concept-block("L'AI Autonoma, Supervisione Minima - Agentic AI")[
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
  - *Manca* la visione del tuo progetto: quali librerie usi, com'è strutturato il codice, lo stile del team
  - *Ignora* il contesto: se hai già una funzione simile, potrebbe non riutilizzarla e scrivere codice duplicato
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
    #concept-block("IDE")[
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
      - ✅ Comprende la *semantica e intento*
      - ✅ Contesto → *intero progetto*
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
  - *Richiede* la supervisione, revisione critica e decisioni umane
  - *Non comprende* requisiti di business complessi o trade-off architetturali
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

== Sfide, Problemi e Criticità
#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  align: center,
  [
    #figure(
      image("images/current-state.png", width: 100%),

    )
  ],
  [
    #figure(
      image("images/perception.png", width: 100%),
    )
  ]
)

== Sfide, Problemi e Criticità
#figure(image("images/problems.png", width: 80%))

== Sfide, Problemi e Criticità
#figure(image("images/risk.png", width: 60%))


== Sfide, Problemi e Criticità
#figure(image("images/chatgpt-impact.png", width: 50%))

#figure(image("images/cognitive-deload.png", width: 80%))

= Soluzioni Principali

== Panoramica del mercato

#figure(image("images/overview.drawio.png", width: 80%))


== Tipologie di soluzioni AI-assisted
#align(center)[
  #text(size: 1.4em, weight: "bold")[Tre approcci principali]
]

#v(2em)

#align(center)[
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 3em,
    align: center + horizon,
    [
      #text(size: 3em)[🔌]
      #v(0.3em)
      #text(size: 1.2em, weight: "bold")[Plugin/Estensioni]
    ],
    [
      #text(size: 3em)[💻]
      #v(0.3em)
      #text(size: 1.2em, weight: "bold")[IDE Nativi AI]
    ],
    [
      #text(size: 3em)[🌐]
      #v(0.3em)
      #text(size: 1.2em, weight: "bold")[Web-based]
    ]
  )
]

#v(1.5em)

#align(center)[
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 3em,
    align: center,
    [
      #text(size: 0.95em, fill: gray, style: "italic")[
        Si integrano nell'IDE esistente
      ]
    ],
    [
      #text(size: 0.95em, fill: gray, style: "italic")[
        Editor completo AI-first
      ]
    ],
    [
      #text(size: 0.95em, fill: gray, style: "italic")[
        IDE nel browser
      ]
    ]
  )
]

== Approccio 1: Plugin/Estensioni 

#grid(
  columns: (auto, 1fr, 1fr),
  gutter: 1.5em,
  align: (center, top, top),
  [
    #text(size: 4em)[🔌]
    
    #v(0.5em)
    
    #text(size: 0.85em, weight: "bold")[
      Estensioni che si\
      integrano negli\
      IDE esistenti
    ]
  ],
  [
    #text(weight: "bold", size: 0.95em)[📦 Esempi]
    - *GitHub Copilot* (VS Code, JetBrains, Neovim)
    - *Amazon Q Developer* (multi-IDE)
    - *Tabnine* (enterprise-grade)
    - *Codeium* (gratuito)
    
    #v(0.8em)
    
    #text(weight: "bold", size: 0.95em)[⚙️ Come funzionano]
    1. Installi il plugin nel tuo IDE
    2. Configuri account/API key
    3. AI si integra nell'editor
    4. Lo sviluppatore ha la stessa esperienza di prima
  ],
  [
    #text(weight: "bold", size: 0.95em, fill: rgb("#16a34a"))[✅ Vantaggi]
    - IDE full-fledged
    - Non invasivo
    - Ecosistema compatibile
    - Portabilità
    
    #v(0.8em)
    
    #text(weight: "bold", size: 0.95em, fill: rgb("#dc2626"))[⚠️ Svantaggi]
    - Limitato da API IDE
    - Esperienza meno #underline[ergonomica]
      - Tipicamente la parte AI è secondaria
    - Alcune features mancanti
      - Es. modalità agente
  ]
)

== Approccio 2: IDE Nativi AI 

#grid(
  columns: (auto, 1fr, 1fr),
  gutter: 1.5em,
  align: (center, top, top),
  [
    #text(size: 4em)[💻]
    
    #v(0.5em)
    
    #text(size: 0.85em, weight: "bold")[
      Editor completi\
      progettati da zero\
      con AI al centro
    ]
  ],
  [
    #text(weight: "bold", size: 0.95em)[📦 Esempi]
    - *Cursor* (fork VS Code, 2022)
    - *Windsurf* (Codeium, Cascade)
    - *Zed* (velocissimo con AI)
    - *Replit* (cloud + Ghostwriter)
    
    #v(0.8em)
    
    #text(weight: "bold", size: 0.95em)[⚙️ Come funzionano]
    1. L'IDE/editor è progettato per AI
    2. Il codice va tipicamente in #underline[secondo piano]
      - Ci si concentra sulla parte conversazionale
  ],
  [
    #text(weight: "bold", size: 0.95em, fill: rgb("#16a34a"))[✅ Vantaggi]
    - Pensata anche per non esperti in sviluppo software
    - Features avanzate (agent)
    - Zero overhead
    
    #v(0.8em)
    
    #text(weight: "bold", size: 0.95em, fill: rgb("#dc2626"))[⚠️ Svantaggi]
    - Lock-in editor
    - Meno estensioni/linguaggi supportati
    - Meno maturo
      - Sono tipicamente progetti recenti
  ]
)

== Approccio 3: Web-based 

#grid(
  columns: (auto, 1fr, 1fr),
  gutter: 1.5em,
  align: (center, top, top),
  [
    #text(size: 4em)[🌐]
    
    #v(0.5em)
    
    #text(size: 0.85em, weight: "bold")[
      IDE completi\
      nel browser\
      con AI e deploy
    ]
  ],
  [
    #text(weight: "bold", size: 0.95em)[📦 Esempi]
    - *Replit* (Ghostwriter AI)
    - *StackBlitz* (WebContainer)
    - *CodeSandbox* (Copilot)
    - *Bolt.new* (AI full-stack)
    
    #v(0.8em)
    
    #text(weight: "bold", size: 0.95em)[⚙️ Come funzionano]
    1. Apri il sito web
    2. Crei/importi progetto
    3. Code + AI + deploy)
    4. Condividi con link
  ],
  [
    #text(weight: "bold", size: 0.95em, fill: rgb("#16a34a"))[✅ Vantaggi]
    - Zero setup
    - Collaborazione real-time
    - Deploy istantaneo
    - Multi-device
    
    #v(0.8em)
    
    #text(weight: "bold", size: 0.95em, fill: rgb("#dc2626"))[⚠️ Svantaggi]
    - Focus su web dev
    - Il codice anche qui è in secondo piano
    - Problemi di privacy
    - Inadatto per progetti grandi
    - Spesso freemium
  ]
)
== Quale approccio scegliere?
#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  align: top,
  [
    #concept-block("Scegli un PLUGIN se...")[
      - Hai già un #strong([IDE preferito]) (VS Code, IntelliJ, etc.)
      - Vuoi #underline([mantenere il tuo workflow esistente])
      - Lavori con #emph([progetti enterprise complessi])
      - Preferisci #strong([stabilità]) e #strong([maturità])
      
      #v(0.5em)
      #text(size: 0.85em, style: "italic")[
        _Ideale per: #strong([professionisti]) con setup consolidato_
      ]
    ]
    
    #v(0.5em)
    
    #concept-block("Scegli WEB-BASED se...")[
      - Vuoi #strong([iniziare subito]) senza installare nulla
      - Lavori su #underline([più dispositivi])
      - Fai #strong([prototipazione rapida])
      - #emph([Insegni]) o #emph([impari]) a programmare
      - Collabori in #underline([tempo reale]) con altri
      
      #v(0.5em)
      #text(size: 0.85em, style: "italic")[
        _Ideale per: #strong([learners]), #strong([educatori]), prototipazione_
      ]
    ]
  ],
  [
    #concept-block("Scegli IDE NATIVO se...")[
      - Vuoi la #strong(underline([migliore esperienza AI possibile]))
      - Vuoi un editor #underline([ottimizzato per AI-first])
      - Sei disposto a #emph([cambiare workflow])
      - Non hai bisogno di #strong([tante estensioni])
      
      #v(0.5em)
      #text(size: 0.85em, style: "italic")[
        _Ideale per: #strong([early adopters]), progetti AI-intensive_
      ]
    ]
    
    #v(0.5em)
    
    #warning-block("⚖️ Considerazioni aggiuntive")[
      - *Budget*: web spesso #strong([gratis]) come modelli freemium
      - *Privacy*: plugin/IDE locali #strong([>]) web cloud
      - *Team*: considera cosa #emph([usa già]) il team
      - *Progetti*: legacy enterprise → #strong([plugin]), greenfield → #strong([IDE nativi])
    ]
  ]
)


= AI-assisted in Practice: GitHub Copilot
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
        - Assistente AI avanzato per la programmazione di GitHub/Microsoft
        - Lanciato nel 2021, #text(weight: "bold")[20M+ sviluppatori attivi]
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
        - Suggerimenti di codice in tempo reale #fa-lightbulb()
        - Assistenza contestuale
        - Integrazione diretta negli IDE 
      ]
    )
  ]
)

== Copilot - Perchè?
#grid(
  columns: (0.8fr, 1fr),
  gutter: 1.5em,
  align: center,
  [
    #figure(image("images/report-github-1.png", width: 100%))
  ],
  [
    #figure(image("images/report-github-2.png", width: 100%))
  ]
)
== Copilot - Perchè?
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: center,
  [
    #figure(image("images/test-quality.png", width: 90%))
  ],
  [
    #figure(image("images/percentage.png", width: 90%))
  ]
)

#align(center)[
  #figure(image("images/line-code-error.png", width: 46%))
]

== Copilot - Perchè?
 #figure(image("images/usage.png", width: 80%))



== Copilot - Modelli d'uso e Prezzi

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: top,
  row-gutter: 0.8em,
  // Free
  block(
    fill: rgb("#f8fafc"),
    width: 100%,
    inset: 0.7em,
    radius: 6pt,
    stroke: (paint: rgb("#64748b"), thickness: 1.5pt),
    [
      #text(size: 0.95em, weight: "bold")[#fa-icon("gift") #h(0.2em) Free]
      #text(size: 1.1em, weight: "bold", fill: rgb("#16a34a"))[Gratis]
      #text(size: 0.75em)[
        - 2000 completamenti/mese
        - 50 msg chat/mese
        - No modelli premium
      ]
    ]
  ),
  // Pro
  block(
    fill: rgb("#f8fafc"),
    width: 100%,
    inset: 0.7em,
    radius: 6pt,
    stroke: (paint: rgb("#64748b"), thickness: 1.5pt),
    [
      #text(size: 0.95em, weight: "bold")[#fa-icon("star") #h(0.2em) Pro]
      #text(size: 1.1em, weight: "bold", fill: rgb("#2563eb"))[\$10/mese]
      #text(size: 0.75em)[
        - Illimitato
        - 300 richieste premium
        - GPT-4, Claude
        - Agente coding
      ]
    ]
  ),
  // Pro+
  block(
    fill: rgb("#f8fafc"),
    width: 100%,
    inset: 0.7em,
    radius: 6pt,
    stroke: (paint: rgb("#64748b"), thickness: 1.5pt),
    [
      #text(size: 0.95em, weight: "bold")[#fa-icon("rocket") #h(0.2em) Pro+]
      #text(size: 1.1em, weight: "bold", fill: rgb("#7c3aed"))[\$39/mese]
      #text(size: 0.75em)[
        - Tutto di Pro
        - 1500 richieste (5x)
        - Tutti i modelli
        - o1-preview
      ]
    ]
  ),
  // Business
  block(
    fill: rgb("#f8fafc"),
    width: 100%,
    inset: 0.7em,
    radius: 6pt,
    stroke: (paint: rgb("#64748b"), thickness: 1.5pt),
    [
      #text(size: 0.95em, weight: "bold")[#fa-icon("users") #h(0.4em) Business]
      #text(size: 1.1em, weight: "bold", fill: rgb("#d97706"))[\$19/user/mese]
      #text(size: 0.75em)[
        - Gestione team
        - Policy aziendali
        - 300 richieste/user
        - Customizzazione
      ]
    ]
  ),
  // Enterprise
  block(
    fill: rgb("#f8fafc"),
    width: 100%,
    inset: 0.7em,
    radius: 6pt,
    stroke: (paint: rgb("#64748b"), thickness: 1.5pt),
    [
      #text(size: 0.95em, weight: "bold")[#fa-icon("building") #h(0.2em) Enterprise]
      #text(size: 1.1em, weight: "bold", fill: rgb("#dc2626"))[\$39/user/mese]
      #text(size: 0.75em)[
        - Tutto di Business
        - 1000 richieste/user
        - Knowledge base
        - Enterprise-grade
      ]
    ]
  ),
  // Schema decisionale
  block(
    fill: rgb("#f8fafc"),
    width: 100%,
    inset: 0.7em,
    radius: 6pt,
    stroke: (paint: rgb("#64748b"), thickness: 1.5pt),
    [
      #text(size: 0.95em, weight: "bold")[#fa-icon("question-circle") #h(0.2em) Quale?]
      #text(size: 0.7em)[
        - Prova → *Free*
        - Individuale → *Pro*
        - Power user → *Pro+*
        - Team → *Business*
        - Azienda → *Enterprise*
      ]
    ]
  )
)

#align(center)[
  #text(size: 0.75em, style: "italic")[
    _LLM-agnostic: funziona con diversi modelli (Codex, GPT-4, Claude, o1)_
  ]
]

== Copilot - Installazione
#align(center)[
  #link(
    "https://docs.github.com/en/copilot/get-started/quickstart",
    "https://docs.github.com/en/copilot/get-started/quickstart"
  )
]
#grid(
  columns: (0.55fr, 1fr),
  gutter: 1em,
  align: center,
  [
    #figure(image("images/get-start-for-free.png", width: 80%))
  ],
  [
    #figure(image("images/github-result.png", width: 100%))
  ]
)

== Copilot - Installazione (VScode)
#concept-block("Installazione su VS Code")[
  - Come accennato, #strong([Copilot]) è disponibile come estensione per vari IDE.
  - Noi useremo Visual Studio Code :
    1. Scarica e installa #link("https://code.visualstudio.com/", "Visual Studio Code")
    2. Vai su #strong([Extensions]) (`Ctrl+Shift+X`)
    3. Cerca #strong([GitHub Copilot]) e clicca su #underline([Install])
    4. Accedi con il tuo account GitHub
    5. Segui la procedura guidata per attivare la licenza
  - Dopo l'#underline([installazione]), Copilot è subito pronto all'uso! 
]

== Demo - requisiti
#align(left)[
  #text(size: 1.15em, weight: "bold")[Prerequisiti per la demo:]

  - #strong([Git]) installato
  - #strong([Python 3.8+]) installato
  - Scarica il repository: #link("https://github.com/cric96/course-2025-ai-assisted-code")
  - Installa le dipendenze Python:
  
  ```bash
    pip install -r requirements.txt
  ```
  - È possibile anche utilizzare #strong[Codespaces] (IDE nel cloud) per evitare setup locale
]

#focus-slide[
  == AI-assisted Livello 0

  === Autocompletamento 
]

== Copilot - Livello 0 (Autocompletamento di base)
- #strong([Copilot]) fornisce #emph([suggerimenti di codice in tempo reale]) mentre digiti.
- Basato (principalmente) sul #strong([contesto immediato]) del file.
- #emph([Prima feature introdotta nel 2021.])
- #strong([Pro:]) velocizza la scrittura di codice #emph([boilerplate]) e routine comuni.
- #bold([Contro:]) limitato al #emph([contesto locale]), non (sempre) comprende l'#emph([intero progetto]).
#figure(image("images/autocomplete.png", width: 80%))

== Copilot - Livello 0 (alcune funzionalità)
- Puoi #strong([accettare]) il suggerimento con `Tab`
  - O accettare parzialmente con `Ctrl+Right`
- È possibile #strong([scartare]) con `Esc` o continuando a scrivere
- #strong([Vedere alternative]) con `F1` → `GitHub Copilot: Open Completions Panel`
#figure(image("images/alternatives.png", width: 50%))

== Copilot - Livello 0 (Cambiare modello)
- Copilot nasce con Codex (basato su GPT-3)
- Ora è #underline[model-agnostic]: puoi scegliere tra vari modelli LLM
  - GPT-4.1, GPT-5 (mini)
  - Claude (Anthropic)
- Alcuni modelli sono #strong([premium]) (Pro+)
- Cambia modello con `F1` → `GitHub Copilot: Select AI Model`
- Ad oggi, `gpt-41-copilot` è l'unico disponibile per utenti free

// Slide 1: Introduzione al Compito
== Livello 0 - Compito: Introduzione

#concept-block("Obiettivo")[
  - Andate nella folder #strong([level-0])
  - Aprite il file #raw("`main.py`")
  - Trovate una descrizione in linguaggio naturale di cosa fare
  - Il sistema deve #strong([visualizzare le entrate e uscite di un conto bancario]) e #strong([categorizzarle])
]

#note-block("Cosa fare")[
  - Alcune funzioni sono #strong([incomplete])
  - Usate #strong([Copilot]) per completarle
  - Provate a #emph([togliere tutte le funzioni]) e osservate cosa succede
]
== Livello 0 - Risultato delle Funzioni (1/2)

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  row-gutter: 1.5em,
  align: center,
  // plot_expenses_by_category
  block(
    fill: rgb("#f8fafc"),
    width: 100%,
    inset: 1em,
    radius: 8pt,
    stroke: (paint: rgb("#cbd5e0"), thickness: 2pt),
    [
      #align(center)[
        #image("images/exercise-0/plot_expenses_by_category.png", width: 50%)
        #v(0.5em)
        #text(size: 0.9em, weight: "bold")[`plot_expenses_by_category`]
      ]
    ]
  ),
  // plot_expenses_per_day
  block(
    fill: rgb("#f8fafc"),
    width: 100%,
    inset: 1em,
    radius: 8pt,
    stroke: (paint: rgb("#cbd5e0"), thickness: 2pt),
    [
      #align(center)[
        #image("images/exercise-0/plot_expenses_per_day.png", width: 100%)
        #v(0.5em)
        #text(size: 0.9em, weight: "bold")[`plot_expenses_per_day`]
      ]
    ]
  ),
)

== Livello 0 - Risultato delle Funzioni (2/2)

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  row-gutter: 1.5em,
  align: center,
  // plot_incomes
  block(
    fill: rgb("#f8fafc"),
    width: 100%,
    inset: 1em,
    radius: 8pt,
    stroke: (paint: rgb("#cbd5e0"), thickness: 2pt),
    [
      #align(center)[
        #image("images/exercise-0/plot_incomes.png", width: 90%)
        #v(0.5em)
        #text(size: 0.9em, weight: "bold")[`plot_incomes`]
      ]
    ]
  ),
  // plot_monthly_balance
  block(
    fill: rgb("#f8fafc"),
    width: 100%,
    inset: 1em,
    radius: 8pt,
    stroke: (paint: rgb("#cbd5e0"), thickness: 2pt),
    [
      #align(center)[
        #image("images/exercise-0/plot_monthly_balance.png", width: 90%)
        #v(0.5em)
        #text(size: 0.9em, weight: "bold")[`plot_monthly_balance`]
      ]
    ]
  ),
)

== Livello 0 - Compito: Discussione

#note-block("Domande")[
  - In quanti siete riusciti a completare tutto?
  - Cosa succede se togliete tutte le funzioni?
  - Copilot riesce a ricostruire la logica?
]

#v(1em)

#warning-block("Suggerimento")[
  #emph([Sperimentate!]) Provate a cambiare i commenti o aggiungere dettagli per vedere come Copilot si adatta.
]

#focus-slide[
  == AI-assisted Livello 1

  === Chat e Comandi
]

== Copilot - Livello 1 (inline chat)
- Puoi scrivere #strong([commenti in linguaggio naturale]) per descrivere cosa vuoi fare.
- #strong([Copilot genera il codice corrispondente]) in tempo reale.
- Sono disponibili anche #emph([comandi preimpostati]) (via prompt engineering) per azioni rapide.
- Opera sul #strong([contesto locale del file]) ma usa può usare il contesto del progetto.
#figure(image("images/level-1.png", width: 70%))


== Copilot - Livello 1 (inline chat)
- Ad ogni generazione, Copilot offre diverse opzioni di interazione:
  - #strong([Accettare]) il suggerimento con `Tab`
  - #strong([Scartare]) con `Esc` o continuando a scrivere
  - #strong([Rigenerare]) una soluzione alternativa (tramite l'icona di refresh)
  - Scrivere follow-up in linguaggio naturale per #strong([modificare]) il suggerimento
- È possibile #strong([limitare il contesto]) selezionando una porzione di testo e premendo `Shift` + frecce su/giù, per ottenere suggerimenti più mirati.
- È possibile cambiare il modello usato per #underline[ogni] suggerimento.
#figure(image("images/llms.png", width: 70%))

== Copilot - Livello 1 (Comandi)
- Copilot include una serie di #strong([comandi predefiniti]) per operazioni comuni.
- `/doc` → genera documentazione per la funzione selezionata.
- `/tests` → crea test unitari per la funzione selezionata.
- `/explain` → spiega il codice selezionato in linguaggio naturale.
- `/fix` → corregge errori comuni nel codice selezionato.

// put a note block here
#note-block("Nota")[
  - I comandi funzionano solo se #strong([selezioni del codice]) prima
  - Alcuni comandi potrebbero non funzionare in tutti i linguaggi
  - Di fatto, non sono altro che prompt predefiniti
  - Altri esempi: #link(
    "https://docs.github.com/en/copilot/tutorials/copilot-chat-cookbook"
  )
]

== Test D'unità - Richiamo

== Test di unità (breve)
#concept-block("Cosa sono e perché usarli")[
  - I *test di unità* verificano il comportamento di singole unità di codice (funzioni/metodi) in isolamento.
  - Sono veloci, piccoli, e servono come documentazione eseguibile del comportamento atteso.
  - Esempio minimo (pytest): `assert add(2,3) == 5` → testa la funzione `add` senza dipendenze esterne.
]


== Copilot - Se volessi cambiare lo stile?
- Spesso i team adottano #strong([linee guida di stile]) precise per il codice.
  - Ad esempio, l'uso di tool come `black`, `prettier`, `eslint` per la formattazione automatica.
- Puoi #strong([chiedere a Copilot]) di rispettare queste regole direttamente nei prompt.
- Esempi pratici:
  - `# Format this code according to PEP8 guidelines`
  - `# Use prettier to format this JavaScript code`
- Copilot tenterà di #strong([adattare le sue risposte]) alle tue richieste di stile (zero-shot learning).
- Per applicare uno stile di progetto a tutto il codebase, puoi aggiungere un file `github-instructions.md` nella root del progetto con le regole desiderate.

== Copilot - Livello 1 (Demo)
Su `level-1` useremo Copilot sfruttando `inline-chat`.
1. *Generazione guidata con chat inline* (`Ctrl+I`):
     - Descrivi l'obiettivo generale e genera il programma completo
     - Itera e correggi errori usando la chat
  
  2. *Comandi predefiniti su `kanban`*:
     - `/explain` → comprendi il codice esistente
     - `/doc` → genera documentazione per classi in `models`
     - `/test` → crea test per `Project`
     - `/fix` → correggi test falliti
     - Refactoring del main via chat
  
  3. *Personalizzazione stile con `.github/copilot-instructions.md`*:
     - Genera `draw_flower.py` prima e dopo le istruzioni custom
     - Osserva come cambiano stile, librerie e struttura del codice

== Livello 1 - Discussione post-demo

#warning-block("Domande aperte")[
  - Quali modelli hanno funzionato meglio per quali task?
  - Il codice generato era direttamente utilizzabile o ha richiesto modifiche?
  - Come è cambiato lo stile del codice con `.github/copilot-instructions.md`?
  - Avete incontrato #strong([allucinazioni]) o suggerimenti errati?
  - Quanto è stato difficile #underline([validare]) il codice generato?
]

== Copilot = Livello 1.1 (Chat Completa)
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    - Copilot include una #strong([chat completa]) per interazioni più complesse.
    - Si apre con `F1` → `GitHub Copilot: Open Chat`
    - Puoi #strong([fare domande]), #strong([chiedere spiegazioni])
    - La chat comprende il #underline([contesto del progetto])
    - Supporta #emph([conversazioni multi-turno])
  ],
  [
    #figure(image("images/full-chat.png", width: 90%))
  ]
)

== Chat Completa - Gestione del Contesto

#concept-block("Come Copilot gestisce il contesto")[
  *Contesto Implicito (automatico)*:
  - Testo selezionato nell'editor attivo
  - Nome del file o notebook corrente
  - File attivo incluso automaticamente in #strong([ask mode]) / #strong([edit mode])
  - In #strong([agent mode]), gli strumenti decidono autonomamente quale contesto aggiungere
    - Ne parleremo meglio dopo e nella prossima lezione
]

== Chat Completa - \#-mentions

#text(size: 0.9em)[
  #concept-block("Riferimenti espliciti con #")[
    - Scrivi `#` nella chat per vedere i contesti disponibili
    - #strong([\#file]) / #strong([\#folder]) → aggiungi file/cartelle specifiche
    - #strong([\#symbol]) → riferisci simboli del codice (classi, funzioni)
    - #strong([\#changes]) → diffs dei file modificati
    - #strong([\#codebase]) → ricerca semantica nell'intero workspace
    - #strong([\#fetch:<url>]) → recupera contenuti da una pagina web
  ]
]

== Chat Completa - \#-mentions

#text(size: 0.85em)[
  #example-block("Esempi di #-mentions")[
    ```
    Explain how authentication works in #codebase
    
    Where is the database connection string configured? #codebase
    
    What are the highlights of VS Code 1.100 #fetch https://code.visualstudio.com/updates/v1_100
    
    How does routing work in next.js #githubRepo vercel/next.js
    
    Update the asp.net app to .net 9 #fetch https://learn.microsoft.com/en-us/aspnet/core/migration/80-90
    ```
  ]
]

== Chat Completa - Aggiungere File come Contesto

#text(size: 0.8em)[
  #concept-block("Modi per aggiungere file alla chat")[
    *Tre metodi disponibili*:
    
    1. *\#-mention*: scrivi `#` + nome del file/cartella/simbolo
       - Per simboli, apri prima il file che li contiene
    2. *Drag & Drop*: trascina file/cartelle da Explorer/Search/Editor nella Chat
    
    3. *Add Context button*: usa il pulsante nella Chat view
       - Seleziona _Files & Folders_ o _Symbols_
  ]
]

#text(size: 0.8em)[
  #note-block("Dimensioni del contesto")[
    - Se possibile, viene incluso il #strong([file completo])
    - Se troppo grande, viene incluso un #underline([outline]) (funzioni senza implementazione)
    - Se anche l'outline è troppo grande, il file #emph([non viene incluso])
  ]
]


== Chat Completa - Cronologia Conversazioni

#text(size: 0.9em)[
  #concept-block("Multi-turn Conversations")[
    - La chat in VS Code è progettata per #strong([conversazioni multi-turno])
    - La #underline([cronologia]) viene usata come contesto per i prompt successivi
    - Puoi fare #emph([domande di follow-up]) senza ripetere il contesto
    - Per iniziare un nuovo argomento: usa il pulsante #strong([New Chat]) (`+`) o `Ctrl+N`
    - Utile per evitare che il contesto precedente influenzi la nuova richiesta
  ]
]

#v(0.8em)

#text(size: 0.85em)[
  #note-block("Best Practice")[
    - Mantieni conversazioni separate per #strong([argomenti diversi])
    - Inizia una nuova chat quando cambi completamente contesto
    - Usa la cronologia per #underline([iterazioni incrementali]) sullo stesso problema
  ]
]

#focus-slide[
  == Prompt Engineering -- Best Practices
]

== Copilot - Livello 1 (Prompt engineering)

#align(center)[
  #text(size: 1.2em, weight: "bold")[Come scrivere prompt efficaci per Copilot Chat]
]

#v(1em)

#text(size: 0.9em)[
  #concept-block("Obiettivo")[
    Applicare strategie di #strong([prompt engineering]) per ottenere risposte #underline([migliori]), #underline([più precise]) e #underline([più utili]) da GitHub Copilot Chat.
  ]
]

#text(size: 0.9em)[
  #note-block("Cosa vedremo")[
    - 8 consigli pratici per scrivere prompt efficaci
    - Esempi concreti e best practices
  ]
]


== Consiglio 1 — Parti generale, poi dettaglia

#text(size: 0.9em)[
  #concept-block("Strategia: Top-Down")[
    1. Inizia con una #strong([descrizione ampia]) dell'obiettivo
    2. Poi aggiungi i #underline([requisiti specifici]) uno alla volta
    3. Questo aiuta l'AI a capire il #emph([contesto generale]) prima dei dettagli
  ]
]

#text(size: 0.9em)[
  #example-block("Esempio: Funzione Numero Primo")[
    ```
    Write a JavaScript function that tells me if a number is prime
    
    The function should take an integer and return true if the integer is prime
    
    The function should error if the input is not a positive integer
    ```
  ]
]


== Consiglio 2 — Fornisci esempi

#text(size: 0.8em)[
  #concept-block("Strategia: Few-Shot Learning")[
    - Fornisci #strong([esempi concreti]) di input/output attesi
    - Mostra #underline([casi d'uso reali])
    - I #emph([test unitari]) sono ottimi esempi: chiedi prima i test, poi l'implementazione
  ]
]


#text(size: 0.8em)[
  #example-block("Esempio: Estrazione Date")[
    ```
    Write a function that extracts dates from a string
    
    Example:
    findDates("I have a dentist appointment on 11/14/2023 and book club on 12-1-23")
    
    Returns: ["11/14/2023", "12-1-23"]
    ```
  ]
]


== Consiglio 3 — Spezza i task complessi

#text(size: 0.9em)[
  #concept-block("Strategia: Divide et Impera")[
    - Suddividi #strong([compiti grandi]) in #underline([sotto-task più piccoli])
    - Chiedi a Copilot di risolvere #emph([un problema alla volta])
    - Poi combina le soluzioni in un sistema finale
  ]
]


#text(size: 0.9em)[
  #example-block("Esempio: Word Search Game")[
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      [
        #text(weight: "bold", fill: rgb("#dc2626"))[❌ Troppo complesso]
        ```
        Crea un gioco word search
        completo con UI e logica
        ```
      ],
      [
        #text(weight: "bold", fill: rgb("#16a34a"))[✅ Suddiviso]
        ```
        1. Genera una griglia NxN
        2. Inserisci parole nella griglia
        3. Funzione per cercare parole
        4. Combina tutto
        ```
      ]
    )
  ]
]

== Consiglio 4 — Evita ambiguità

#text(size: 0.9em)[
  #concept-block("Strategia: Sii Esplicito")[
    - Usa #strong([nomi e riferimenti chiari])
    - Evita pronomi vaghi (#emph(["questo"]), #emph(["quello"]), #emph(["esso"]))
    - Specifica #underline([librerie]) e #underline([versioni]) se rilevanti
    - Definisci termini tecnici se poco comuni
  ]
]

#text(size: 0.9em)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      #text(weight: "bold", fill: rgb("#dc2626"))[❌ Ambiguo]
      #v(0.3em)
      _"Aggiungi questo alla funzione"_
      
      _"Usa quella libreria per fare questo"_
      
      _"Implementa il pattern standard"_
    ],
    [
      #text(weight: "bold", fill: rgb("#16a34a"))[✅ Esplicito]
      #v(0.3em)
      _"Aggiungi la gestione errori a `validateEmail()`"_
      
      _"Usa `pandas` per leggere il CSV"_
      
      _"Implementa il pattern Singleton"_
    ]
  )
]

== Consiglio 5 — Indica il codice rilevante

#text(size: 0.8em)[
  #concept-block("Strategia: Fornisci Contesto")[
    - Apri i #strong([file rilevanti]) nell'IDE prima di chiedere
    - #underline([Evidenzia il codice]) che vuoi che Copilot consideri
    - Usa tag speciali in Copilot Chat:
      - `@workspace` → contesto dell'intero progetto
      - `#file:nome.py` → riferimento a file specifico
      - `#selection` → codice selezionato
  ]
]

#text(size: 0.8em)[
  #example-block("Esempio con Tag")[
    ```
    @workspace How does authentication work in this project?
    #file:auth.py Refactor the login function to use async/await
    #selection Add error handling to this code block
    ```
  ]
]

== Consiglio 6 — Sperimenta e itera

#text(size: 0.8em)[
  #concept-block("Strategia: Approccio Iterativo")[
    - La prima risposta #strong([non è sempre perfetta])
    - #underline([Modifica il prompt]) e riprova
    - Nella chat, #emph([riferisciti alla risposta precedente]):
      - _"Rigenera usando async/await"_
      - _"Aggiungi type hints alla soluzione precedente"_
      - _"Semplifica il codice che hai generato"_
  ]
]


#text(size: 0.9em)[
  #note-block("Pro Tip")[
    Copilot mantiene la #strong([cronologia della conversazione]). Puoi costruire soluzioni complesse #underline([incrementalmente]) attraverso iterazioni successive.
  ]
]

== Consiglio 7 — Mantieni la cronologia rilevante

#text(size: 0.9em)[
  #concept-block("Strategia: Gestione Contesto")[
    - Usa #strong([thread separati]) per task differenti
    - #underline([Cancella messaggi irrilevanti]) per evitare confusione
    - Troppo contesto non correlato può #emph([degradare la qualità]) delle risposte
    - Inizia una #strong([nuova conversazione]) per topic completamente nuovi
  ]
]


#text(size: 0.9em)[
  #warning-block("Attenzione")[
    Se Copilot inizia a dare risposte #underline([inconsistenti]) o #underline([fuori topic]), probabilmente la cronologia è troppo lunga o mescolata. #strong([Pulisci e riparti!])
  ]
]

== Consiglio 8 — Segui le buone pratiche di codice

#text(size: 0.9em)[
  #concept-block("Strategia: Qualità del Codebase")[
    Copilot funziona #strong([meglio]) se il tuo codice è già #underline([leggibile]) e #underline([ben strutturato]):
    
    - #fa-check() #strong([Nomi variabili chiari]) e descrittivi
    - #fa-check() #strong([Stile coerente]) nel progetto
    - #fa-check() #strong([Commenti utili]) per logica complessa
    - #fa-check() #strong([Test unitari]) come documentazione
  ]
]


#text(size: 0.9em)[
  #note-block("Importante")[
    Se il codebase è disordinato, chiedi a Copilot stesso:
    - _"Aggiungi commenti esplicativi a questa funzione"_
    - _"Refactoring di questo codice per migliorare leggibilità"_
  ]
]

== Prompt engineering — Anatomia di un prompt efficace

#text(size: 0.8em)[
  #concept-block("Il Framework Input-Processo-Output")[
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 1em,
      [
        #text(weight: "bold", size: 0.95em)[📥 Input]
        - Obiettivo chiaro
        - Requisiti funzionali
        - Esempi input/output
        - File rilevanti
        - Vincoli tecnici
      ],
      [
        #text(weight: "bold", size: 0.95em)[⚙️ Processo]
        - Linguaggio/framework
        - Stile di codice
        - Pattern da usare
        - Best practices
        - Gestione errori
      ],
      [
        #text(weight: "bold", size: 0.95em)[📤 Output]
        - Implementazione funzionante
        - Test unitari (opzionale)
        - Documentazione
        - Note su limitazioni
        - Suggerimenti uso
      ]
    )
  ]
]


#text(size: 0.8em)[
  #warning-block("Error Modes da Considerare")[
    - Input non valido o malformato
    - Dipendenze mancanti o versioni incompatibili  
    - Ambiguità nei requisiti
    - Edge cases non gestiti
  ]
]

== Esempi di prompt completi e ben strutturati

#text(size: 0.9em)[
  #example-block("Esempio 1: Testing")[
    ```
    Scrivi una funzione Python che valida un indirizzo email usando regex.
    
    Requisiti:
    - Supporta email standard (user@domain.com)
    - Gestisci sottodomini (user@mail.company.com)
    - Restituisci True/False
    - Solleva ValueError per input non stringa
    
    Includi 6 test unitari con pytest che coprano casi validi, invalidi ed edge cases.
    ```
  ]
]

#v(1em)

#text(size: 0.9em)[
  #example-block("Esempio 2: Documentazione")[
    ```
    #file:orders.py
    Genera documentazione completa per la funzione process_orders():
    - Docstring con parametri, return value, eccezioni
    - Sezione README.md con esempi d'uso
    - Note su performance e limitazioni
    ```
  ]
]

== Prompt engineering — Quick reference

#text(size: 0.9em)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      #concept-block("✅ DO")[
        - Generale → dettagliato
        - Fornisci 2-3 esempi concreti
        - Spezza task complessi
        - Usa nomi espliciti
        - Indica file/codice rilevanti
        - Itera e raffina
        - Mantieni il contesto pulito
        - Il codice deve essere leggibile
      ]
    ],
    [
      #warning-block("❌ DON'T")[
        - Prompt vaghi o troppo brevi
        - Mancanza di esempi
        - Task monolitici troppo grandi
        - Pronomi ambigui
        - Ignorare il contesto
        - Aspettarsi perfezione al primo colpo
        - Cronologia chat disordinata
        - Codebase caotico
      ]
    ]
  )
]

== Note finali — Prompt engineering come skill

#align(center)[
  #text(size: 1.3em, weight: "bold")[
    Il prompt engineering è una #strong([competenza]) che si #underline([affina con la pratica])
  ]
]

#v(2em)

#align(center)[
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 1.5em,
    [
      #align(center)[
        #text(size: 2.5em)[🎯]
        #v(0.3em)
        #text(size: 0.9em, weight: "bold")[Sii Conciso ma Completo]
        #v(0.3em)
        #text(size: 0.8em)[
          Prompt brevi ma con tutte le info necessarie
        ]
      ]
    ],
    [
      #align(center)[
        #text(size: 2.5em)[🧠]
        #v(0.3em)
        #text(size: 0.9em, weight: "bold")[Fornisci Contesto]
        #v(0.3em)
        #text(size: 0.8em)[
          Più contesto = risposte più precise
        ]
      ]
    ],
    [
      #align(center)[
        #text(size: 2.5em)[🔍]
        #v(0.3em)
        #text(size: 0.9em, weight: "bold")[Valuta Criticamente]
        #v(0.3em)
        #text(size: 0.8em)[
          Verifica sempre il codice generato
        ]
      ]
    ]
  )
]

#focus-slide[
  == AI-assisted Livello 2

  === Modalità Agente
]

== Copilot - Livello 2 (Modalità Agente)

#feature-block("Coding Agent Mode")[
  #emph[With chat agent mode in Visual Studio Code, you can use natural language to specify a #underline[high-level task], and let AI #underline[autonomously] reason about the request, plan the work needed, and apply the changes to your codebase. Agent mode uses a combination of #underline[code editing] and #underline[tool invocation] to accomplish the task you specified. As it processes your request, it monitors the outcome of edits and tools, and iterates to resolve any issues that arise.]
]
- Con i tool precendenti, la chat è reattiva
- La modalità agente è #strong([proattiva])
  - Può #strong([eseguire comandi]) autonomamente
  - Può #strong([navigare il codebase]) da sola
  - Può #strong([usare strumenti esterni]) (terminal, web search, ecc.)

== Agent vs Tools 
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: top,
  [
    #example-block("Coding Agent")[
      - Riceve un #strong([compito ad alto livello])
      - Pianifica i #underline([passi necessari])
      - Esegue #underline([modifiche al codice])
      - Usa #underline([strumenti esterni]) se necessario
      - Monitora e #underline([corregge errori]) autonomamente
    ]
  ],
  [
    #example-block("Coding Tools")[
      - Rispondono a #strong([richieste specifiche])
      - Operano su #underline([contesto fornito])
      - Non pianificano autonomamente
      - Non eseguono modifiche senza input
      - Non usano strumenti esterni
    ]
  ]
)
- Sono concetti collegati ad agentic AI
- Li vedremo più in dettaglio nella prossima lezione

#focus-slide[
  == Context Engineering

  === Fornire il giusto contesto all'AI
]

== Context Engineering - Introduzione

#align(center)[
  #text(size: 1.2em, weight: "bold")[Come fornire il giusto contesto all'AI]
]

#v(0.5em)

#definition-block("Context Engineering")[
  È un approccio sistematico per fornire agli agenti AI informazioni mirate sul progetto, migliorando la qualità e l'accuratezza del codice generato.
]

#v(0.5em)

#text(size: 0.85em)[
  #concept-block("Perché è importante")[
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      [
        *Senza Context Engineering*
        - L'AI genera codice generico
        - Non rispetta convenzioni progetto
        - Ignora architettura esistente
        - Suggerimenti inconsistenti
      ],
      [
        *Con Context Engineering*
        - Codice allineato al progetto
        - Rispetta pattern e convenzioni
        - Decisioni architetturali coerenti
        - Conoscenza persistente
      ]
    )
  ]
]

== Contenxt Engineering - Introduzione
#align(center)[
  #image("images/result-context-eng.png")
]
== Context Engineering - Workflow
#figure(image("images/context-engineering-workflow.png", width: 50%))
== Context Engineering - Workflow

#text(size: 0.75em)[
  #concept-block("Asserzione Chiave")[
    #align(center)[
      #text(size: 0.95em, style: "italic")[
        _"Il contesto è il ponte tra l'intento del programmatore e l'azione dell'AI. Senza contesto curato, l'AI genera soluzioni generiche; con contesto mirato, diventa un collaboratore che comprende il progetto."_
      ]
    ]
  ]
]

#let ce-box(emoji, label, fill-color, stroke-color, width: 140pt, height: 80pt) = {
  box(
    fill: fill-color,
    stroke: 2pt + stroke-color,
    radius: 5pt,
    inset: 8pt,
    width: width,
    height: height,
    [#align(center + horizon)[#text(size: 0.7em, weight: "bold")[#emoji\ #label]]]
  )
}

#let ce-arrow = [#text(size: 1.5em)[→]]
#let ce-arrow-down = [#text(size: 1.5em)[↓]]

#align(center)[
  #grid(
    columns: (auto, auto, auto, auto, auto),
    gutter: 10pt,
    align: center + horizon,
    
    ce-box("📚", [Curate\ Project Context], rgb("#e0e7ff"), rgb("#6366f1")),
    ce-arrow,
    ce-box("📝", [Generate\ Implementation\ Plan], rgb("#f3e8ff"), rgb("#a855f7")),
    ce-arrow,
    ce-box("💻", [Generate\ Implementation\ Code], rgb("#d1fae5"), rgb("#10b981")),
  )
]

#align(center)[
  #ce-arrow-down
  #v(0.2em)
  #box(
    fill: rgb("#fef3c7"),
    stroke: 2pt + rgb("#f59e0b"),
    radius: 5pt,
    inset: 10pt,
    width: 500pt,
    [#align(center)[#text(size: 0.7em, weight: "bold")[🔄 Feedback Loop: Itera, Raffina, Migliora]]]
  )
  #v(0.2em)
]

== Context Engineering - Step 1: Project Context

#text(size: 0.75em)[
  #concept-block("Documentazione Chiave")[
    Crea file Markdown nella repository per documentare aspetti critici:
    
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.8em,
      [
        *ARCHITECTURE.md*
        - Architettura generale
        - Design patterns
        - Principi di design
        - Dipendenze chiave
      ],
      [
        *PRODUCT.md*
        - Visione prodotto
        - Obiettivi business
        - Funzionalità core
        - User personas
      ],
      [
        *CONTRIBUTING.md*
        - Linee guida sviluppo
        - Code style
        - Best practices
        - Workflow collaborativo
      ]
    )
  ]
]

#v(0.5em)

#text(size: 0.7em)[
  #note-block("Perché funziona")[
    L'AI *potrebbe* trovare queste info nel codebase, ma sono sparse in commenti e file multipli. Un summary conciso assicura che il contesto critico sia sempre disponibile.
  ]
]

== Context Engineering - Step 1: Esempio

#text(size: 0.75em)[
  #example-block("`.github/copilot-instructions.md`")[
    ```markdown
    # [Project Name] Guidelines
    
    * [Product Vision](../PRODUCT.md): High-level vision and objectives
    * [Architecture](../ARCHITECTURE.md): System design and patterns
    * [Contributing](../CONTRIBUTING.md): Developer guidelines
    
    Suggest updates to these docs if you find gaps or conflicts.
    ```
  ]
]

#v(0.5em)

#text(size: 0.7em)[
  #note-block("Pro Tip")[
    - *Start small*: contesto conciso, solo info più critiche
    - *Focus on high-level*: architettura e principi, non dettagli implementativi
    - *Living document*: aggiorna quando AI fa errori ripetuti
    - Se hai codebase esistente, usa AI per generare questi file (poi revisiona!)
  ]
]

== Context Engineering - Step 2: Implementation Plan

#text(size: 0.75em)[
  #concept-block("Planning Persona con Chat Mode")[
    Crea un processo iterativo per generare piani di implementazione:
    
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      [
        *Chat Mode Dedicato*
        - `.github/chatmodes/plan.chatmode.md`
        - Persona specializzata in planning
        - Tool specifici (fetch, search, usages)
        - No implementazione, solo pianificazione
      ],
      [
        *Plan Template*
        - `plan-template.md` per struttura consistente
        - Metadata (titolo, data, versione)
        - Architecture & design
        - Task breakdown (checklist)
        - Open questions
      ]
    )
  ]
]

#v(0.5em)

#text(size: 0.7em)[
  #note-block("Workflow")[
    1. Analizza requisiti e contesto codebase
    2. Struttura piano usando template
    3. Pausa per review e feedback iterativo
  ]
]

== Context Engineering - Step 2: Esempio Chat Mode

#text(size: 0.5em)[
  #example-block("`.github/chatmodes/plan.chatmode.md`")[
    ```markdown
    ---
    description: 'Architect and planner for implementation plans.'
    tools: ['fetch', 'githubRepo', 'search', 'usages']
    ---
    # Planning Mode
    
    You are an architect creating detailed implementation plans.
    
    ## Workflow
    1. Analyze and understand: gather context from codebase
    2. Structure the plan: use [plan-template.md](plan-template.md)
    3. Pause for review: iterate based on feedback
    ```
  ]
]


#text(size: 0.7em)[
  #example-block("Uso")[
    - Seleziona `plan` mode nella Chat view
    - Prompt: `Add user authentication with email and password`
    - Oppure: `Implement feature from issue #43` (fetch automatico issue)
  ]
]

== Context Engineering - Step 2: Plan Template

#text(size: 0.7em)[
  #example-block("`plan-template.md` - Struttura")[
    ```markdown
    ---
    title: [Short descriptive title]
    date_created: [YYYY-MM-DD]
    last_updated: [YYYY-MM-DD]
    ---
    # Implementation Plan: <feature>
    [Brief description of requirements and goals]
    
    ## Architecture and design
    Describe high-level architecture and design considerations.
    
    ## Tasks
    - [ ] Task 1: Description
    - [ ] Task 2: Description
    
    ## Open questions
    1. Question needing clarification
    2. Another open question
    ```
  ]
]

== Context Engineering - Step 3: Implementation

#text(size: 0.75em)[
  #concept-block("Da Piano a Codice")[
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      [
        *Task Piccoli*
        - Prompt diretto con il piano
        - `implement #<my-plan>.md`
        - Iterazione veloce in chat
        - Review manuale del codice
      ],
      [
        *Task Complessi*
        - Usa *Agent Mode*
        - Salva piano su file o GitHub issue
        - Multi-step execution autonoma
        - Testing e validazione automatica
      ]
    )
  ]
]

#v(0.5em)

#text(size: 0.7em)[
  #note-block("Pro Tip")[
    - Agent Mode è ottimizzato per task multi-step
    - Basta fornire il plan file: `implement #<my-plan>.md`
    - L'agent pianifica autonomamente come raggiungere l'obiettivo
    - Per fresh perspective: nuova chat → chiedi review del codice vs piano
  ]
]

== Context Engineering - Step 3: Esempio TDD Mode

#text(size: 0.7em)[
  #example-block("`.github/chatmodes/tdd.chatmode.md`")[
    ```markdown
    ---
    description: 'Execute plan as test-driven developer.'
    ---
    # TDD Implementation Mode
    Expert TDD developer generating tested, maintainable code.
    
    ## Test-driven development
    1. Write/update tests first to encode acceptance criteria
    2. Implement minimal code to satisfy test requirements
    3. Run targeted tests immediately after each change
    4. Run full test suite to catch regressions
    5. Refactor while keeping all tests green
    
    ## Core principles
    * Incremental Progress: small, safe steps
    * Test-Driven: tests guide and validate behavior
    * Quality Focus: follow existing patterns
    ```
  ]
]

== Context Engineering - Best Practices

#text(size: 0.7em)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    align: top,
    [
      #concept-block("✅ DO")[
        - *Start small*: contesto minimo, poi itera
        - *Keep fresh*: aggiorna docs regolarmente
        - *Progressive context*: high-level → dettagli
        - *Separate concerns*: chat diverse per task diversi
        - *Living documents*: raffina in base a errori
        - *Version control*: traccia modifiche al setup
      ]
    ],
    [
      #warning-block("❌ DON'T")[
        - *Context dumping*: troppo info non focalizzata
        - *Inconsistent guidance*: docs contrastanti
        - *No validation*: assumere che AI capisca
        - *One-size-fits-all*: stessa config per tutti
        - *Stale context*: docs obsoleti
        - *No feedback loops*: non validare comprensione
      ]
    ]
  )
]

== Context Engineering - Metriche di Successo

#text(size: 0.75em)[
  #concept-block("Come misurare l'efficacia")[
    Un setup efficace di context engineering produce:

    - #text(fill: rgb("#16a34a"))[✓] *Reduced back-and-forth*: meno correzioni necessarie
    - #text(fill: rgb("#16a34a"))[✓] *Consistent code quality*: pattern e convenzioni rispettati
    - #text(fill: rgb("#16a34a"))[✓] *Faster implementation*: meno tempo a spiegare contesto
    - #text(fill: rgb("#16a34a"))[✓] *Better decisions*: soluzioni allineate a obiettivi progetto
  ]
]


#text(size: 0.7em)[
  #note-block("Scaling")[
    - *Team*: condividi setup via git, stabilisci convenzioni
    - *Large projects*: gerarchia di contesto (project-wide, module-specific, feature-specific)
    - *Long-term*: cicli di review regolari per docs
    - *Multiple projects*: template riutilizzabili
  ]
]

== Copilot - Github
- Copilot si integra perfettamente con #strong([GitHub])
- Puoi usare Copilot Chat direttamente su #strong([GitHub Codespaces])
- Puoi usare Copilot in #strong([Pull Requests]) per:
  - Generare descrizioni PR
  - Suggerire modifiche al codice
  - Creare test automatici per le PR
- Puoi usare Copilot in #strong([Issues]) per:
  - Riassumere discussioni
  - Suggerire soluzioni
  - Generare template per bug report


== Copilot - Possibilità di Estensioni
- Abbiamo visto che Copilot supporta vari modelli LLM
- Puoi anche #strong([integrare modelli custom]) tramite API
  - Noi vedremo ollama nella prossima lezione
- Puoi #strong([creare tool personalizzati]) per estendere le capacità di Copilot
  - Ad  esempio, tool per interagire con applicativi specifici
- Puoi #strong([configurare flussi di lavoro]) personalizzati usando Copilot
  - Ad esempio, pipeline di CI/CD con automazioni AI
  - Questo è più AI per DevOps


== Conclusioni
- this

== Riferimenti 
- 🔗 #link("https://code.visualstudio.com/docs/copilot/overview") - Documentazione ufficiale di GitHub Copilot per VS Code
- 🔗 #link("https://github.com/features/copilot") - Sito ufficiale di GitHub Copilot
- 🔗 #link("https://docs.github.com/en/copilot/tutorials/copilot-chat-cookbook") - Copilot Chat Cookbook
- 🔗 #link("https://docs.github.com/en/copilot/tutorials/coding-agent/get-the-best-results") - Best Practices per Coding Agent
- 📚 #link("https://www.oreilly.com/library/view/generative-ai-for/9781098162269/") - Generative AI for Software Development — O'Reilly Media, 2024
- 📚 #link("https://www.oreilly.com/library/view/ai-assisted-programming/9781098164553/") - AI-Assisted Programming — O'Reilly Media, 2024
