#!/bin/sh
set -e
set -x

# directory loop
for x in {1..13}; do
    mkdir ./$x
done

# rename loop suffix
for file in *.pdf; do
  mv "$file" "${file/.pdf/-old.pdf}"
done

# rename fix recursively
find . -name "*.java" -exec rename 's/\.java$/.kt/' '{}' \;
