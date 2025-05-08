root := justfile_directory()

export TYPST_ROOT := root

[private]
default:
  @just --list --unsorted

# generate manual and thumbnails
doc:
  typst compile docs/manual.typ docs/manual.pdf --font-path fonts
  typst compile docs/thumbnail.typ thumbnail.png --font-path fonts
  typst compile docs/readme-thumbnail.typ readme-thumbnail-{0p}.png --font-path fonts
  # typst compile --input theme=dark docs/thumbnail.typ thumbnail-dark.svg

# generate examples
example:
  typst compile template/main.typ examples/example.pdf --font-path fonts

# run test suite
test *args:
  tt run {{ args }} --font-path fonts

# update test cases
update *args:
  tt update {{ args }} --font-path fonts

# package the library into the specified destination folder
package target:
  ./scripts/package "{{target}}"

# install the library with the "@local" prefix
install: (package "@local")

# install the library with the "@preview" prefix (for pre-release testing)
install-preview: (package "@preview")

[private]
remove target:
  ./scripts/uninstall "{{target}}"

# uninstalls the library from the "@local" prefix
uninstall: (remove "@local")

# uninstalls the library from the "@preview" prefix (for pre-release testing)
uninstall-preview: (remove "@preview")

# run ci suite
ci: test doc
