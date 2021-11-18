# ot
Attempt to build ubuntu container/w:
- network tools such as ping
- opentap
- tui
- keysight libraries
- x11 libraries to support running gui apps over xterm

0. On the host (i.e. your laptop/desktop), perform these steps...
1. Clone the project from github/the repo, change to the research directory of the project. `cd vte/research/tuiresearch`
2. If it is not in the directory (i.e., not part of the repo since it's a big file and we don't always include it in the repo), you'll have to go out and download the KS library independently, namely `iolibrariessuite-installer_20_0_26913_1.run` and copy it to the project directory.
3. Likewise, if it is not in the directory, you'll have to go out and download the latest OpenTap package independently, namely
`OpenTap.9.16.2+f3c96b9f.Linux.TapPackage`
3. Run: `./build.sh`
4. If, during the build, you see the error message similar to `This device is not connected to the network -- aborting the installation.`, which is from the keysight library installation, stop the build, then make sure you are not connected to any LQ/TMC VPN, and then restart your host's (laptop/desktop's) docker engine, then re-run the build script).  This error was especially an issue when running the build script on a Mac and each time a restart of the docker engine seemed to fix it.
5. You'll have an ubuntu container with openTap, tui, keysight libs, and x11 libs.
5. Run: `docker images | grep ot`
5. You should see your new image, `ot` in the list of docker images
5. Run: `./run.sh`
5. Your image will start up as a container, optionally Run: `docker ps`, you should see the ot container
5. To log in to the container, Run: `docker exec -it ot bash`
6. You should now be logged into the ubuntu container
5. Optionally, try to ping the instrument: `ping 192.168.26.49` (that is an example IP only)
5. To run TUI, run: `tap tui`
5. To run the TP_SIGGEN_IDN.xml test plan, open it up in TUI and hit the Run Test Plan
5. Alternatively, within TUI, you can create a new instrument/w the correct VISA address
5. Also within TUI, you can create a new SCPI test step to execute just the *IDN? command
5. Finally, within TUI, run the test plan
5. Exit TUI and you'll be back in the cmd line of the container
5. To test out xterm capability with your host you can run: `xclock`.  An xclock gui should appear if you have set up your xterm/x11 properly on your host.  If it does not work, then you can check the run.sh command of this project for hints on how to get it running, but this is beyond the scope of this project.
5. If the xclock app worked, you can optionally run the ConEx application. Run: `/opt/keysight/iolibs/ui/connection-expert/ConnectionExpert.
5. To exit the container, Run: `exit`
5. You're now back at the host
~
~
~
