FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y \
 && apt-get install -y curl build-essential autoconf g++ python libtool git \
 && cd /opt \
 && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
 && apt-get install -y nodejs \
 && git clone https://github.com/Flood-UI/flood.git

COPY config.js /opt/flood/config.js

RUN cd /opt/flood \
 && npm install --unsafe-perm \
 && npm run build

EXPOSE 3000



