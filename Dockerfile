FROM phusion/baseimage:latest
LABEL Author="LedoKun <romamp100 at gmail dot com>"

# Set correct environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Wine's environment variables
ENV WINEPREFIX /root/prefix32
ENV WINEARCH win32
ENV DISPLAY :0

COPY root/install.sh /install.sh
COPY root/etc/service/ /etc/service/

# Run install script
RUN \
 /bin/bash /install.sh

WORKDIR /root/

# Expose Port
EXPOSE 8080

CMD ["/sbin/my_init"]
