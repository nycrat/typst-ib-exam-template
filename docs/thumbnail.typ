#import "/src/lib.typ": *

#let font = sys.inputs.at("font", default: "Libertinus Serif")
#set text(font: font)

#show: conf.with(exam-id: [0000-0000])

#title-page()
