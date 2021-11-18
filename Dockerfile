FROM ubuntu:18.04
RUN  apt-get  update -y \
  && apt-get upgrade -y \
  && apt-get install iputils-ping -y \
  && apt-get install net-tools -y
CMD ["bash"]
RUN apt update
RUN apt upgrade -y
RUN apt install -y wget
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt install apt-transport-https -y
RUN apt update
RUN apt install dotnet-sdk-2.1 -y
RUN apt install libc6-dev libunwind8 curl git locales -y
RUN locale-gen en_US.UTF-8
RUN apt install unzip -y
COPY OpenTAP.9.16.1+7ad24bcd.Linux.TapPackage OpenTAP.Linux.TapPackage
RUN unzip OpenTAP.Linux.TapPackage -d /opt/tap
RUN chmod +x /opt/tap/tap
RUN mkdir -p /root/.local/share/OpenTAP
RUN echo 11111111-1111-1111-1111-111111111111 > /root/.local/share/OpenTAP/OpenTapGeneratedId
ENV PATH=$PATH:/opt/tap
# RUN tap -h
# RUN tap package list -v
RUN tap package install TUI --version any
RUN tap package install Demonstration
# Make sure you have downloaded this file from keysight and that it exists
# in the host's project file before trying to create this image:
COPY iolibrariessuite-installer_20_0_26913_1.run keysightiolib.run
RUN chmod +x keysightiolib.run

# this is needed for ks libs
RUN apt-get install lsb-core -y

# this command can fail with the error
# "This device is not connected to the network"
# if the container cannot get out to the internet
# It *might not* hang if you add the --enable-debugger flag?
RUN ./keysightiolib.run --mode unattended --enable-debugger

# add a soft link to the Keysight VISA library in the OpenTAP directory
RUN ln -s /opt/keysight/iolibs/libktvisa32.so /opt/tap/libvisa.so

