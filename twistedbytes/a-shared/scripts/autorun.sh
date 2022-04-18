#!/bin/bash

cd /usr/local/bin/autorun
for i in *; do
    # echo running $i;
    ./$i
done
