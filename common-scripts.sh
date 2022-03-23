#!/bin/sh
set -e
set -x

# directory loop
for x in {1..13}; do
  mkdir ./$x
done

# rename loop suffix
for file in *.pdf; do mv "$file" "${file/.pdf/-old.pdf}"; done

# rename fix recursively
find . -name "*.test.jsx" -exec rename 's/\.jsx$/.js/' '{}' \;

# change encoding recursively
find . -type f -print -exec iconv -f windows-1250 -t utf-8 -o {}.converted {} \; -exec mv {}.converted {} \;

# change extension of all
for file in *.txt; do mv "$file" "$(basename "$file" .txt).md"; done

# convert to ts
for file in *.js; do
  react-js-to-ts "$file"
done

for f in $(find . -name '*.js'); do react-js-to-ts $f; done

# change git extension
find . -name "*.scss" -delete
for i in $(find . -iname "*.scss"); do git mv "$i" "$(echo $i | rev | cut -d '.' -f 2- | rev).css"; done

# current working directory
echo $PWD

# files do not contain word render
grep -r --include=\*.jsx -L render ./src/

# Append to every file
for f in $(find src -type f -name '*.json'); do
  sed -i '.bak' '1s/^/export default \'$'\n/g' $f
done

# Change extensions OS X.  "+"" not working on os x, bash neither, run in local directory i.e. "."
find . -name "*.json" -exec sh -c 'mv "$1" "${1%.json}".ts' - '{}' \;

# duplicate name search
find . -type f | sed 's_.*/__' | sort | uniq -d |
  while read fileName; do
    find . -type f | grep "$fileName"
  done;