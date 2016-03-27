FROM armhf/debian:jessie

RUN apt-get update && \
    apt-get -o Apt::Install-Recommends=0 install -y squid3 build-essential git ca-certificates && \
    git clone https://github.com/Yelp/dumb-init.git /dumb-init && \
    cd /dumb-init && \
    make && \
    cp dumb-init /sbin/dumb-init && \
    cd / && \
    rm -rf /dumb-init && \
    apt-get remove --purge -y build-essential git ca-certificates && \
    apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3128

ENTRYPOINT ["/sbin/dumb-init"]
CMD ["/usr/sbin/squid3", "-N", "-D", "-YC"]
