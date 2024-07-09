FROM ubuntu:24.04 AS builder
RUN apt update && apt install -y curl tar build-essential pkg-config \
    libxml2-dev libxslt1-dev libcurl4-openssl-dev libvorbis-dev
COPY icecast-2.5-beta3.tar.gz /tmp/icecast-2.5-beta3.tar.gz
RUN tar -xf /tmp/icecast-2.5-beta3.tar.gz -C /tmp/
RUN mkdir -p /tmp/icecast-2.4.99.3/output
WORKDIR /tmp/icecast-2.4.99.3/output
RUN /tmp/icecast-2.4.99.3/configure
RUN make

FROM ubuntu:24.04 AS final
COPY --from=builder /tmp/icecast-2.4.99.3/output/src/icecast /usr/local/bin/
COPY --from=builder /tmp/icecast-2.4.99.3/admin /tmp/icecast/admin
COPY --from=builder /tmp/icecast-2.4.99.3/web /tmp/icecast/web

RUN apt update && apt install -y init-system-helpers adduser debconf \
    libc6 libcurl4t64 libogg0 libspeex1 libssl3t64 libtheora0 libvorbis0a \
    libxml2 libxslt1.1 lsb-base

RUN groupadd icecast
RUN useradd -s /bin/bash -d /home/nobody/ -m -g icecast icecast 

ENTRYPOINT ["icecast", "-c", "/tmp/icecast.xml"]