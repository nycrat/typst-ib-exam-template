#let ib-indent = 0.4in
#let s = state("session-number", [0000-0000])


#let conf(doc, session-number: [0000-0000]) = {
  set page(
    "us-letter",
    margin: (left: 1in - ib-indent, right: 1in - ib-indent),
    header: [
      #text(white)[
        0525-0420
      ]
      #h(1fr)
      #context [
        – #counter(page).display() –
      ]
      #h(1fr) #session-number
    ],
  )
  set par(spacing: 0.25in, leading: 0.25in)
  set text(11pt, font: "Arial")
  set table(inset: 0em, stroke: none)

  s.update(session-number)

  counter("question").update(1)

  doc
}

#let title-page(
  subject: "No Subject",
  level: "Standard Level",
  paper: "Paper 1",
  max-marks: 0,
) = page(
  header: none,
  margin: (left: 1in, right: 1in, top: 0.40in),
  background: [#align(right + bottom, image("footer.png", width: 50%))],
)[
  #align(right, image("ib.png", width: 30%))
  #par(leading: 0.5em, spacing: 1.2em)[
    #set text(13pt)
    #strong(subject)\
    #strong(level)\
    #strong(paper)\
  ]
  #v(1em)

  May 2025

  #v(-0.5em)

  *Zone A* afternoon | *Zone B* morning | *Zone C* afternoon

  // #v(-0.5em)

  #table(
    columns: (1fr, 1fr),
    align(bottom)[65 minutes],
    [
      #set par(spacing: 0.5em)
      #align(center)[Candidate name]
      #box(width: 100%, height: 2em, stroke: 0.5pt)],
  )

  #v(-0.5em)

  #line(length: 100%)

  #v(-0.5em)

  *Instructions to candidates*

  #set par(spacing: 1em, leading: 0.5em)

  - Write your name in the box above.
  - Do not open this examination paper until instructed to do so.
  - Answer all the questions.
  // - For each question, choose the answer you consider to be the best and indicate your choice on the answer sheet provided.
  - For each multiple choice question, choose the answer you consider to be the best and indicate your choice by circling your answer.
  - Responses to short answer questions must be written within the answer boxes provided.
  - The maximum mark for this examination paper is [#max-marks marks].

  #align(
    bottom,
    columns(2)[
      \
      #context { counter(page).at(<end>).at(0) } pages

      #colbreak()
      #set align(right)
      #set text(10pt)

      #context s.get() \
      // #session-number\
      #sym.copyright Some Organization 2025
    ],
  )
]


#let indent-table(indent: 1, layer: 0, ..args) = {
  if indent == 1 {
    table(
      columns: (
        ib-indent,
        8.5in - 2in + ib-indent - ib-indent * layer,
      ),
      ..args
    )
  } else {
    table(
      columns: (
        ib-indent,
        8.5in - 2in + ib-indent,
      ),
      [], indent-table(indent: indent - 1, layer: layer + 1, ..args),
    )
  }
}


#let mcq(question, a, b, c, d) = {
  indent-table(
    context [*#counter("question").display().*],
    [
      #question

      #v(-0.125in)
      #indent-table(
        layer: 1,
        inset: (y: 0.125in, x: 0pt),
        [A.],
        a,
        [B.],
        b,
        [C.],
        c,
        [D.],
        d,
      )
    ],
  )

  counter("question").step()
}

#let saq(question-context, ..questions) = {
  indent-table(
    layer: 1,
    [*#context {counter("question").display()}.*],
    {
      set par(leading: 0.5em)
      question-context
    },
  )

  set par(leading: 0.5em)
  counter("question-sub").update(0)


  for q in questions.pos() {
    let question-letter = context str.from-unicode(
      97 + counter("question-sub").get().at(0),
    )

    let has-context = q.at("question-context", default: none) != none
    if has-context {
      indent-table(
        indent: 2,
        layer: 1,
        // special table inside table case
        // maybe implement as default behavior later
        [(#question-letter)],
        q.at("question-context"),
      )
    }

    indent-table(
      indent: 2,
      if not has-context [(#question-letter)],
      table(
        columns: (1fr, 0.5in),
        q.at("question"), align(right + bottom)[[#q.points]],
      ),
    )

    v(-0.5em)

    box(
      stroke: 0.5pt + black,
      width: 100%,
      inset: (right: 0.5in, left: 0.5in, top: 0.3in, bottom: 0.3in),
    )[
      #set par(leading: 0em, spacing: 0.3in)
      #for _ in range(q.at("lines")) {
        line(
          stroke: (thickness: 1.5pt, dash: (array: ("dot", 5pt))),
          length: 100%,
        )
      }
    ]

    counter("question-sub").step()
  }


  counter("question").step()
  pagebreak(weak: true)
}

