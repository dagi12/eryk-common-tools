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

# change extension of all
for file in *.txt; do
    mv "$file" "$(basename "$file" .txt).md"
done

# change git extension
find . -name "*.scss" -delete
for i in $(find . -iname "*.scss"); do git mv "$i" "$(echo $i | rev | cut -d '.' -f 2- | rev).css"; done

# current working directory
echo $PWD
