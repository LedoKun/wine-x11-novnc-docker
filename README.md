**Forked from [solarkennedy/wine-x11-novnc-docker](https://github.com/solarkennedy/wine-x11-novnc-docker).**

## wine-x11-novnc-docker

Containerized wine applications with a web browser access.

This container runs:

* Xvfb - X11 in a virtual framebuffer
* x11vnc - A VNC server that scrapes the above X11 server
* [noNVC](https://kanaka.github.io/noVNC/) - A HTML5 canvas vnc viewer
* Fluxbox - a small window manager
* Explorer.exe - to demo that it works
* WineTricks - a script to download and install Windows runtime lib

## Run It

    docker run -p 8080:8080 ledokun/wine-x11-novnc-docker
    xdg-open http://localhost:8080

In your web browser you should see the default application, explorer.exe:

![Explorer Screenshot](https://raw.githubusercontent.com/LedoKun/wine-x11-novnc-docker/master/screenshot.png)

## Modifying

This is a base image. You should fork or use this base image to run your own
wine programs?

## Issues

* Wine could be optimized a bit
* Bloated container...
* Fluxbox could be skinned or reduced
