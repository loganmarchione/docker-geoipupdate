FROM ubuntu:bionic

ARG BUILD_DATE

LABEL \
  maintainer="Logan Marchione <logan@loganmarchione.com>" \
  org.opencontainers.image.authors="Logan Marchione <logan@loganmarchione.com>" \
  org.opencontainers.image.title="docker-geoipupdate" \
  org.opencontainers.image.description="Runs MaxMind's geoipupdate program in Docker" \
  org.opencontainers.image.created=$BUILD_DATE

ENV VERSION 4.2.2

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    cron \
    tzdata \
    wget && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://github.com/maxmind/geoipupdate/releases/download/v${VERSION}/geoipupdate_${VERSION}_linux_amd64.deb && \
    apt-get install -y /geoipupdate_${VERSION}_linux_amd64.deb && \
    rm ./geoipupdate_${VERSION}_linux_amd64.deb

VOLUME [ "/usr/share/GeoIP" ]

COPY ./entrypoint.sh /

COPY VERSION /

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/cron", "-f"]
