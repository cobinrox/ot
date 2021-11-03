#!/bin/bash
# runs the ot image and creates new instance of
# a container


# remove the container if it is or was already running
docker rm -f ot > > /dev/null 2>&1

# run the "ot" image and give resulting container
# a name of "ot"
docker run -it --name ot ot
