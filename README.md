# ot
Attempt to build ubuntu container/w:
- network tools such as ping
- opentap
- tui
- keysight libraries

0. On the host (i.e. your laptop/desktop), perform these steps...
1. Download the project from github.
2. You'll have to go out and download the KS library independently, namely `iolibrariessuite-installer_20_0_26913_1.run` and copy it to the project directory.
3. Run: `./build.sh`
5. You'll have an ubuntu container with openTap and tui, but no Keysight libs.
5. Run: `docker images | grep ot`
5. You should see your new image, ot in the list of docker images
5. Run: `./run.sh`
5. Your image will run as a container, and you'll be logged into the container.  You can now run commands inside the container.
5. (Inside the containter) Run: `./keysightiolib.run --mode unattended`
5. The install will fail with "This device is not connected to the network"
5. You can try to ping the google DNS server, Run: `ping 8.8.8.8`
5. This is far as we got, I would imagine if we could get the ping to succeed we could get further with the keysight installation.
5. To exit the container, Run: `exit`
5. You're now back at the host
~
~
~
