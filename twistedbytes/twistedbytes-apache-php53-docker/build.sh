#!/bin/bash

set -e

# docker build --rm -t "twistedbytes/apache-php52:20221205" -t "twistedbytes/apache-php52:latest" .

podman build --rm -t "twistedbytes/apache-php53:$(date +%Y%m%d)" -t "twistedbytes/apache-php53:latest" .

podman save "twistedbytes/apache-php53:latest" | pv | ssh yview.dev2@csl-yview-dev-01.cslweb.uk -p2223 podman load
