FROM phusion/baseimage:latest
MAINTAINER LedoKun <romamp100 at gmail dot com>

# Set correct environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Configure user nobody to match unRAID's settings
RUN \
 usermod -u 99 nobody && \
 usermod -g 100 nobody && \
 usermod -d /config nobody && \
 chown -R nobody:users /home && \
 dpkg --add-architecture i386 && \
 apt-get update && \
 apt-get dist-upgrade -y && \
 apt-get -y install \
 xvfb \
 x11vnc \
 xdotool \
 wget \
 supervisor && \
 wget -nc https://dl.winehq.org/wine-builds/Release.key && \
 apt-key add Release.key && \
 apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/ && \
 apt-get update && \
 apt-get install --install-recommends -y winehq-stable

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV WINEPREFIX /root/prefix32
ENV WINEARCH win32
ENV DISPLAY :0

WORKDIR /root/
ADD novnc /root/novnc/

# Expose Port
EXPOSE 8080

CMD ["/sbin/my_init", "/usr/bin/supervisord"]
