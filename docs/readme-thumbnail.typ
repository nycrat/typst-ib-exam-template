#import "/src/lib.typ": *

#show: conf.with(exam-id: [0000-0000])

#let font = sys.inputs.at("font", default: "Libertinus Serif")
#set text(font: font)

#title-page()

#mcq(
  [What is the capital of Canada?],
  [Toronto],
  [Ottawa],
  [Vancouver],
  [Montreal],
)

#mcq(
  [Which planet is known as the Red Planet?],
  [Earth],
  [Mars],
  [Jupiter],
  [Venus],
)

#saq(
  [A city has recently implemented a smart traffic management system that uses real-time data from sensors and cameras to optimize traffic flow. The system also collects and stores driver movement data to improve future predictions.],
  (
    question: [What are two potential benefits of using real-time data in traffic systems?],
    points: 2,
    lines: 3,
  ),
  (
    question: [Explain one concern related to collecting and storing driver movement data.],
    points: 4,
    lines: 5,
  ),
)

