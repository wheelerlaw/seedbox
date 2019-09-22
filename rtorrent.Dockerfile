FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y \
 && apt-get install -y curl build-essential autoconf g++ gcc libtool libcppunit-dev zlib1g-dev libssl-dev libncurses-dev libncursesw5-dev libcurl4-openssl-dev automake libxmlrpc-core-c3-dev pkg-config \
 && cd /usr/local/src \
 && curl -fsSL https://github.com/rakshasa/rtorrent/releases/download/v0.9.7/libtorrent-0.13.7.tar.gz -O \
 && tar -xzvf libtorrent-0.13.7.tar.gz \
 && rm libtorrent-0.13.7.tar.gz \
 && cd libtorrent-0.13.7/ \
 && ./autogen.sh \
 && ./configure \
 && make -j2 \
 && make install \
 && cd .. \
 && curl -fsSL https://github.com/rakshasa/rtorrent/releases/download/v0.9.7/rtorrent-0.9.7.tar.gz -O \
 && tar -xzvf rtorrent-0.9.7.tar.gz \
 && rm rtorrent-0.9.7.tar.gz \
 && cd rtorrent-0.9.7/ \
 && ./autogen.sh \
 && ./configure --with-xmlrpc-c \
 && make -j2 \
 && make install \
 && ldconfig \
 && mkdir /data

COPY rtorrent.rc /etc/rtorrent.rc
COPY plex_link.sh /usr/bin/plex_link.sh

VOLUME /data

EXPOSE 49155
EXPOSE 49156

CMD ["/usr/local/bin/rtorrent", "-n", "-o", "import=/etc/rtorrent.rc"]
