root := justfile_directory()

export TYPST_ROOT := root

[private]
default:
  @just --list --unsorted

# generate manual and thumbnails
doc:
  typst compile docs/manual.typ docs/manual.pdf
  typst compile docs/thumbnail.typ thumbnail.png --input font=Arial
  typst compile docs/readme-thumbnail.typ readme-thumbnail-{0p}.png --input font=Arial
  typst compile examples/example.typ --input font=Arial

# run test suite
test *args:
  tt run {{ args }}

# update test cases
update *args:
  tt update {{ args }}

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
