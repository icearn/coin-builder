# Create a build and deployment env for coin ming
# 
# Docker base for building coin daemons 
#
FROM ubuntu:16.04
MAINTAINER icearn

# deal with installation warnings
ENV TERM xterm
# allow easy versioning of images
ENV TESTING 0.3.0

RUN apt-get update
RUN apt-get install -y aptitude
RUN aptitude -y upgrade

# Upstart and DBus have issues inside docker. We work around that.
RUN dpkg-divert --local --rename --add /sbin/initctl 
#&& ln -s /bin/true /sbin/initctl

# Basic build dependencies.
RUN aptitude install -y build-essential libtool autotools-dev autoconf libssl-dev unzip yasm zip pkg-config checkinstall

# Libraries required for building.
RUN aptitude install -y libdb5.1-dev libdb5.1++-dev libboost-all-dev ntp git libqrencode-dev libevent-dev
RUN apt-get install -y libdb++-dev

# Gold linker is much faster than standard linker.
RUN apt-get install -y binutils-gold

# Developer tools.
RUN apt-get install -y bash-completion curl emacs git man-db python-dev python-pip vim

# Now let's build bitcoin
VOLUME /data/buildOutput
WORKDIR /home
RUN mkdir development
WORKDIR /home/development
