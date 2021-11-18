# Creates an image/w opentap and KS libraries and
# a few linux network tools.
#
# WARNING WARNING WARNING
# YOU MUST DOWNLOAD THE LATEST OPENTAP AND
# THE LATEST KS LIBRARIES TO YOUR DOCKER
# PROJECT BEFORE RUNNING THIS DOCKER FILE IF YOU DO NOT
# HAVE THEM.  (WE HAVE
# NOT FOUND A WAY TO WGET/DOWNLOAD THE LIBS 
# PROGRAMMATICALLY)
#
FROM opentapio/opentap:9.16-ubuntu18.04

RUN tap package install TUI --version any
RUN tap package install Demonstration

# need to install network tools for the KS libs
# to get installed properly
RUN  apt-get  update -y \
  && apt-get upgrade -y \
  && apt-get install iputils-ping -y \
  && apt-get install net-tools -y
CMD ["bash"]
RUN apt update
RUN apt upgrade -y
RUN apt install -y wget
RUN apt install libc6-dev libunwind8 curl git locales -y
RUN locale-gen en_US.UTF-8
RUN apt install unzip -y
# xterm stuff if you want to try running commandexpert
RUN apt install libgtk-3-0 -y
RUN apt install -y gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils
RUN apt-get install -qqy x11-apps
RUN apt install xinit -y
# For upgrade of OpenTap libs, make sure you have downloaded
# this file to your docker project dir
COPY OpenTAP.9.16.2+f3c96b9f.Linux.TapPackage otpkg
RUN tap package install otpkg

# To use KS libraries,
# Make sure you have downloaded this file from keysight and that it exists
# in the host's project dir before trying to copy this:
COPY iolibrariessuite-installer_20_0_26913_1.run keysightiolib.run
RUN chmod +x keysightiolib.run

# this is needed for installing ks libs
RUN apt-get install lsb-core -y

# This command can fail with the error
# "This device is not connected to the network"
# if the container cannot get out to the internet.
# If you are building this on a Macs, try restarting 
# the docker engine and then re-building. And make sure
# you are NOT connected to any LQ/TMC VPN
# The enable-debugger flag might help with the problem, eh
RUN ./keysightiolib.run --mode unattended --enable-debugger
#RUN /opt/keysight/iolibs/ds/start-discoveryservice.sh

# optional python stuff
#RUN apt-get install python3-pip -y
#RUN pip3 install -U pyvisa

# copy over sample test plans, a few python scripts
# Comment out these 3 lines if you do not have these folders
# in your project
#ADD mytestplans mytestplans
#ADD utils utils
# copy default settings to run time OT so we dont have to
# retype in everything in TAPTUI!
#COPY mytestplans/. /opt/tap/Settings/Bench/Default

#========================================
# Extras
#========================================

# these are for python visa driver if not using KS lib
# RUN apt-get install -y libusb-1.0-0
# 
# RUN pip3 install pyvisa-py pyusb pyserial

#
# this is vim
RUN apt-get install vim -y
