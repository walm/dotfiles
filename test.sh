#!/bin/bash
set -e

shellcheck="docker run --rm -v $PWD:/root/.dotfiles -w /root/.dotfiles walm/shellcheck -x"

(
# find all executables and run `shellcheck`
while IFS= read -r -d '' f
do
  $shellcheck "$f" && echo -e "---\nSucessfully linted $f\n---"
done < <(find . -type f -executable \( ! -ipath "*vim*" -and ! -iname "*.sample" \) -print0)
) || true
