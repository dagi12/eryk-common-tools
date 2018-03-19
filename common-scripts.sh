#!/bin/sh
set -e
set -x

# directory loop
for x in {1..13}; do
    mkdir ./test$x
done
