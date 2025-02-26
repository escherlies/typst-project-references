build lang:
  typst compile --input lang={{lang}} main.typ References_{{lang}}.pdf

# Init projects.yaml if non-existent
init:
  [ ! -e projects.yaml ] && cp projects-template.yaml projects.yaml

build-readme:
  typst compile --format svg --input lang=en main.typ images/en_{p}.svg