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
4. If, during the build, you see the error message similar to `This device is not connected to the network -- aborting the installation.`, which is from the keysight library installation, stop the build, then restart your host's (laptop/desktop's) docker engine, then re-run the build script).  This error was especially an issue when running the build script on a Mac and each time a restart of the docker engine seemed to fix it..
5. You'll have an ubuntu container with openTap, tui, keysight libs.
5. Run: `docker images | grep ot`
5. You should see your new image, `ot` in the list of docker images
5. Run: `./run.sh`
5. Your image will run as a container, and you'll be logged into the container.  You can now run commands inside the container.
5. To exit the container, Run: `exit`
5. You're now back at the host
~
~
~
