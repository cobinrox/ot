#!/bin/bash
# builds an ot docker image/w ks libs and tui

# remove old version of this container and image, if it exists
docker container rm -f ot > /dev/null 2>&1 
docker image rm -f ot > /dev/null 2>&1

# create the image anew, give it a name of "ot"
docker build -t ot .
