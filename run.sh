#!/bin/bash
# runs the ot image and creates new instance of
# a container


# remove the container if it is or was already running
docker rm -f ot > /dev/null 2>&1

# run the "ot" image and give resulting container
# a name of "ot"
docker run -it --network host --name ot ot

# once the container is running, you need to run the Keysight Instrument Discovery Service in the background
# /opt/keysight/iolibs/ds/start-discoveryservice.sh &

# to test that VISA is working you can run the vifind utility (it won't hang if the Discovery Service is running)
# /opt/keysight/iolibs/utils/vifind 
