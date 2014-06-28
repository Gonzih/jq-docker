# VERSION 1.4
# to install jq docker run -v /usr/bin/jq:/target gonzih/jq
# will install jq command to /usr/bin/jq
#
# also you can use this image to build your container
# FROM gonzih/jq

FROM ubuntu:14.04
MAINTAINER Max Gonzih <gonzih at gmali.com>

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install flex bison gcc make automake
RUN apt-get -y install wget

RUN mkdir /jq
WORKDIR /jq

RUN wget http://stedolan.github.io/jq/download/source/jq-1.4.tar.gz
RUN tar -xvzf jq-1.4.tar.gz

WORKDIR /jq/jq-1.4
RUN ./configure
RUN make
RUN make install

WORKDIR /
RUN rm -rf /jq
RUN apt-get -y remove flex bison gcc make automake

CMD cp /usr/local/bin/jq /target/jq
