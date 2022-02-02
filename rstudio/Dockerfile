ARG BASE_CONTAINER=dblodgett/hydrogeoenv-r:latest

FROM ${BASE_CONTAINER}

LABEL maintainer="David Blodgett <dblodgett@usgs.gov>"

USER root

# https://github.com/dceoy/docker-rstudio-server/blob/master/latest/Dockerfile
RUN apt-get update \
    && apt-get -y install gdebi-core psmisc libclang-dev \
		&& apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN set -e pipefail \
    && wget -O /tmp/rstudio-server.deb https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2021.09.2-382-amd64.deb  \
    && gdebi --non-interactive /tmp/rstudio-server.deb \
    && rm -rf /tmp/rstudio-server.deb

RUN set -e pipefail \
      && ln -s /dev/stdout /var/log/syslog \
      && echo "r-cran-repos=${CRAN_URL}" >> /etc/rstudio/rsession.conf \
      && useradd -m -d /home/rstudio -g rstudio-server rstudio \
      && echo rstudio:rstudio | chpasswd

EXPOSE 8787

USER rstudio
WORKDIR /home/rstudio
