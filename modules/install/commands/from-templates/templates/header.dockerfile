FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y wget

RUN mkdir -p /deploy/ && \
    wget --no-check-certificate -qO- https://github.com/ownport/dockerfile-templates/archive/master.tar.gz | tar -xz -C /deploy

RUN /deploy/dockerfile-templates-master/rerun config:init --export-to /configs/

RUN apt-get update

