#!/bin/sh
dirname=$(pwd)
find $dirname -type f -name '*.java' | sed 's_.*/__' | sort|  uniq -d|
while read fileName
do
find $dirname -type f -name '*.java' | grep "$fileName"
done