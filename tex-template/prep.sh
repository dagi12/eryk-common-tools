#!/bin/sh
set -e
set -x

git checkout -- *.tex

for f in *.tex; do
        cp main.tex.tpl tmpfile
        cat $f >> tmpfile
        echo -e "\n\\\end{document}" >> tmpfile
	mv tmpfile $f
	pdflatex $f -interaction nonstopmode
done
