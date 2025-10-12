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

== Importanza attuale

== Che cosa non è l'AI-assisted Programming? (1/5)
#align(center)[
  #text(size: 1.5em, weight: "bold")[Non è un chatbot generico]
]

#v(1em)

#concept-block("Caratteristiche")[
  - *Non è* semplicemente ChatGPT o altri LLM conversazionali usati senza integrazione
  - *Manca* l'accesso diretto al codice, al contesto del progetto e all'ambiente di sviluppo
  - *Richiede* copia-incolla manuale tra browser e IDE
  - *Non fornisce* feedback in tempo reale durante la scrittura del codice
]

#v(0.5em)

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

#v(0.5em)

#align(center)[
  #text(size: 0.85em, fill: rgb("#666666"))[
    _L'AI-assisted programming sa cosa c'è nel tuo progetto e genera codice già integrato_
  ]
]

== Che cosa non è l'AI-assisted Programming? (3/5)
#align(center)[
  #text(size: 1.5em, weight: "bold")[Non è solo IntelliSense o code snippets]
]

#v(1em)

#concept-block("Caratteristiche")[
  - *Non è* il classico IntelliSense/autocomplete degli IDE (completamento basato su sintassi e tipi)
  - *Non è* limitato a snippet predefiniti (es: `for` → template di ciclo fisso)
  - *Manca* la comprensione semantica: IntelliSense suggerisce metodi disponibili, non cosa vuoi fare
  - *Non impara* dal contesto o dallo stile: ogni volta suggerisce le stesse cose
]

#v(0.5em)

#align(center)[
  #text(size: 0.85em, fill: rgb("#666666"))[
    _L'AI-assisted programming "capisce" l'intento e genera codice contestuale, non solo completa sintassi_
  ]
]

== Che cosa non è l'AI-assisted Programming? (4/5)
#align(center)[
  #text(size: 1.5em, weight: "bold")[Non sostituisce lo sviluppatore]
]

#v(1em)

#concept-block("Caratteristiche")[
  - *Non è* un sistema completamente autonomo che può sviluppare software da solo
  - *Richiede* supervisione, revisione critica e decisioni umane
  - *Non comprende* requisiti di business complessi o trade-off architetturali
  - *Non ha* responsabilità legale o etica sulle decisioni di design
]

#v(0.5em)

#align(center)[
  #text(size: 0.9em, fill: rgb("#666666"))[
    _L'AI-assisted programming è uno strumento che amplifica le capacità dello sviluppatore_
  ]
]

== Che cosa non è l'AI-assisted Programming? (5/5)
#align(center)[
  #text(size: 1.5em, weight: "bold")[Non è Vibe Coding]
]

#v(1em)

#concept-block("Caratteristiche")[
  - *Non è* codice scritto basandosi solo sull'intuizione senza comprensione
  - *Manca* la verifica, il testing e la validazione appropriata
  - *Non garantisce* correttezza, sicurezza o manutenibilità
  - *Promuove* cattive pratiche e debito tecnico
]

#v(0.5em)

#align(center)[
  #text(size: 0.9em, fill: rgb("#666666"))[
    _L'AI-assisted programming supporta best practices, testing e code quality_
  ]
]



== Storia e contesto
- Obiettivo: migliorare la produttività e la qualità del codice

- Anni '80: sistemi di completamento automatico
- Anni '90: IDE con funzionalità
  - Refactoring
  - Analisi statica del codice
- Anni 2000: plugin e estensioni
- Anni 2010: modelli di linguaggio pre-addestrati

== AI-assisted - Cosa?
#feature-block("Autocompletamento del codice")[
  Mentre scrivi, l'AI suggerisce il completamento del codice in tempo reale. 
]

#feature-block("Analisi statica del codice")[
  L'AI esamina il codice per individuare errori, vulnerabilità e potenziali miglioramenti.
]

#feature-block("Generazione automatica di codice")[
  L'AI può generare blocchi di codice basati su descrizioni in linguaggio naturale o specifiche tecniche.
]

#feature-block("Refactoring intelligente")[
  L'AI suggerisce modi per migliorare la struttura del codice senza modificarne il comportamento.
]

#feature-block("Documentazione automatica")[
  L'AI può generare documentazione per il codice esistente, rendendo più facile per gli sviluppatori comprendere e mantenere il codice.
]

#feature-block("Debugging assistito")[
  L'AI aiuta a identificare e risolvere bug nel codice, suggerendo correzioni basate su modelli di errore comuni.
]

== Pre AI-assisted Programming -- IDE e Intellisense
- IDE (Integrated Development Environment)

- Funzionalità di Intellisense
  - Completamento automatico
  - Suggerimenti di codice
  - Navigazione del codice
  - Refactoring di base

- Limitazioni
  - Basato su regole statiche
  - Non comprende il contesto
  - Non impara dall'uso

== AI-assisted - Livelli di assistenza

== AI-assisted - Livello 0
== AI-assisted - Livello 1
== AI-assisted - Livello 2
== AI-assisted - Livello 3

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