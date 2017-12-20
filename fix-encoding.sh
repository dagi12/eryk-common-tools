#!/bin/sh
#set -e
#set -x
mkdir txt-bak
find songs -name "*.txt" -exec cp {} txt-bak/ \;
cd songs
for D in *; do
    if [ -d "${D}" ]; then
      cd "${D}"
      for i in *.txt; do
        [ -f "$i" ] || break
        echo "Processing:  ${i}..."
        iconv -f WINDOWS-1250 -t UTF-8 "$i" > "$i.tmp"
        cat "$i.tmp" > "$i"
        rm "$i.tmp"
      done
      cd ..
    fi
done
