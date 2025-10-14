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
#focus-slide[
  == Obiettivi
  #align(left)[
    - Cos'è #strong(emph([AI-assisted programming])) e perché è #underline([importante])
    - #strong([Soluzioni e strumenti principali]) (focus su #emph([GitHub Copilot]))
    - #strong([Demo pratica]) e discussione #underline([funzionalità])
    - #strong([Limiti]), #emph([criticità]) ed #underline([etica]) dell'AI-assisted
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
#concept-block("AI Autonoma, Supervisione Minima - Agentic AI")[
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
  - Noi useremove Visual Studio Code :
    1. Scarica e installa #link("https://code.visualstudio.com/", "Visual Studio Code")
    2. Vai su #strong([Extensions]) (`Ctrl+Shift+X`)
    3. Cerca #strong([GitHub Copilot]) e clicca su #underline([Install])
    4. Accedi con il tuo account GitHub
    5. Segui la procedura guidata per attivare la licenza
  - Dopo l'#underline([installazione]), Copilot è subito pronto all'uso! 
]

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