#import "template.typ": project
#import "@preview/linguify:0.4.2": *

#let projects = yaml("projects.yaml")
#let lang-data = toml("lang.toml")
#set-database(lang-data)


#let bg-color = rgb("#f6f4f2")
// #let pageCount = box(rect("0" + (context counter(page).get().first()) ,radius: 100pt, inset: 4pt), baseline: 28%)
// #let footer = upper[Binary Please #h(1fr) Page #pageCount]
#set page(fill: bg-color, footer-descent: 12pt)
#set text(font: "Hack", size: 9pt)
#show link: underline

#let fromCli = sys.inputs.lang
#set text(lang: sys.inputs.lang)

#block(
  stroke: 0.5pt,
  height: 1fr,
  width: 100%,
  inset: 10pt,
  radius: 3pt,

  [
    #align(
      right,
      block[
        *Binary Please*\
        c/o Factory Works GmbH\
        Rheinsberger Str. 76/77\
        10115 Berlin\
        +49 170 4564799

        #link("mailto:enrico@binaryplease.com", [enrico\@binaryplease.com])\

        #link("https://binaryplease.com", [https://binaryplease.com])

      ],
    )

    #line(stroke: (thickness: 0.5pt, dash: "dotted"), length: 100%)

    #set align(horizon + center)

    #image("Logo.svg", width: 100pt)


    #text(linguify("references"), size: 20pt, weight: "black", font: "Iosevka Extrabold Extended")


    #context text.lang - v1.0 - #datetime.today().display()

    #set align(left + bottom)

    #line(stroke: (thickness: 0.5pt, dash: "dotted"), length: 100%)


    #for (key, value) in projects {
      [+ #value.name]
    }

  ],
)



#for (key, value) in projects {
  project(..value)
}

