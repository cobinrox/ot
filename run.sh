#!/bin/bash
# runs the ot image and creates new instance of
# a container
# TODO: should move this to a docker-compose file

# remove the container if it is or was already running
docker rm -f ot > /dev/null 2>&1

# Uncomment these lines if you want to try to run connectexpert,
# etc. from an xterm
#export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}') 
export IP=$(ifconfig en10 | grep inet | awk '$1=="inet" {print $2}') 
#export=host.docker.internal
echo "Your (host) IP is: $IP"
xhost +$IP
xhost +local:docker

# start container
docker run -d -t --network host -e DISPLAY=$IP:0 -e XAUTHORITY=/.Xauthority  -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/.Xauthority:/.Xauthority --name ot ot

# once the container is running, you need to run the 
# Keysight Instrument Discovery Service in the background
docker exec -u 0 ot utils/rundiscoveryservice.sh
#docker exec -u 0 ot /opt/keysight/iolibs/ds/start-discoveryservice.sh
# /opt/keysight/iolibs/ds/start-discoveryservice.sh &

# to test that VISA is working you can run the vifind utility 
#(it won't hang if the Discovery Service is running)
# /opt/keysight/iolibs/utils/vifind 
