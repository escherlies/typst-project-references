#import "@preview/cmarker:0.1.2"
#import "@preview/linguify:0.4.2"

#let lang-data = toml("lang.toml")
#linguify.set-database(lang-data)


#let project(
  name: str,
  customer: [],
  website: [],
  langs: (),
  techs: (),
  description: (en: str, de: str),
) = {
  let overlay(img, color) = layout(bounds => {
    let size = measure(img, ..bounds)
    img
    place(top + left, block(..size, fill: color))
  })
  let bg-color = rgb("#f6f4f2")
  let pageCount = box(rect("0" + (context counter(page).get().first()), radius: 100pt, inset: 4pt), baseline: 28%)
  let footer = upper[Binary Please #h(1fr) Page #pageCount]

  set page(fill: bg-color, footer: footer, footer-descent: 12pt)

  let filler = image("filler.svg", height: 15pt)

  let description = context {
    if (text.lang == "en") {
      cmarker.render(description.en)
    } else {
      cmarker.render(description.de)
    }
  }

  text(upper[*#name* ], size: 18pt, font: "Iosevka Extrabold Extended", fill: rgb(154, 99, 255))

  box(width: 1fr, repeat(move(filler, dy: 0pt), gap: -1pt))

  linebreak()
  linebreak()


  let titleCell(content) = table.cell(upper(text(weight: "bold", content)), inset: (left: 0pt))
  let contentCell(content) = content //upper(content)

  block(
    radius: 3pt,
    inset: 12pt,
    stroke: rgb("656565") + 0.5pt,

    height: 1fr,
    [#table(
        columns: (auto, 1fr),
        rows: (auto, auto, auto, auto, auto, 1fr),
        inset: 9pt,
        stroke: (x, y) => (
          // Only draw top stroke if we're beyond the first row
          // Avoid conflicting with the outer block stroke
          top: if y > 0 { (thickness: 0.5pt, dash: "dotted") },
          // Only draw left stroke if we're beyond the first column
          // Avoid conflicting with the outer block stroke
          left: if x > 0 { (thickness: 0.5pt, dash: "dotted") },
          // No bottom or right stroke so that cells at the last row
          // or last column don't generate stroke conflicting with
          // the block outer stroke
        ),
        align: top + left,
        titleCell[#linguify.linguify("project")], contentCell(name),
        titleCell[#linguify.linguify("customer", default: "Foo")], contentCell(customer),
        titleCell[#linguify.linguify("website")], contentCell(link(website)),
        titleCell[#linguify.linguify("languages")], langs.map(contentCell).map(a => "* " + a).join("\n"),
        titleCell[#linguify.linguify("tech_stack")], techs.map(contentCell).join(", "),
        titleCell[#linguify.linguify("description")], text(description, size: 9pt),
      )],
  )
}
