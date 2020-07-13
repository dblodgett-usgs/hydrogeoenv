ARG BASE_CONTAINER=jupyter/minimal-notebook:76402a27fd13

FROM ${BASE_CONTAINER}

LABEL maintainer="David Blodgett <dblodgett@usgs.gov>"

USER root

# From https://hub.docker.com/r/rocker/r-ubuntu/dockerfile
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        software-properties-common \
        dirmngr \
        ed \
        less \
        locales \
        vim-tiny \
        wget \
        ca-certificates \
        apt-transport-https \
        curl \
        gnupg-agent

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.utf8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

# from: https://hub.docker.com/r/rocker/tidyverse/dockerfile
RUN apt-get update -qq \
    && apt-get -y --no-install-recommends install \
        libxml2-dev \
        libcairo2-dev \
        libsqlite-dev \
        libmariadbd-dev \
        libmariadbclient-dev \
        libpq-dev \
        libssh2-1-dev \
        unixodbc-dev \
        libsasl2-dev \
        libssl-dev \
        libcurl4-openssl-dev \
        libsodium-dev
 
# from: https://github.com/rocker-org/geospatial/blob/master/Dockerfile
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        lbzip2 \
        libfftw3-dev \
        libmysqlclient-dev \
        default-libmysqlclient-dev \
        libgdal-dev \
        libgeos-dev \
        libgsl0-dev \
        libgl1-mesa-dev \
        libglu1-mesa-dev \
        libhdf4-alt-dev \
        libhdf5-dev \
        libjq-dev \
        liblwgeom-dev \
        libpq-dev \
        libproj-dev \
        libprotobuf-dev \
        libnetcdf-dev \
        libsqlite3-dev \
        libssl-dev \
        libudunits2-dev \
        netcdf-bin \
        postgis \
        protobuf-compiler \
        sqlite3 \
        tk-dev \
        libv8-dev \
        unixodbc-dev

# Install numpy, scipy matplotlib, and jupytext
RUN pip install scipy matplotlib pandas sympy jupytext ipymd git+https://github.com/eea/odfpy

# install DOI root certificate so things work on the DOI network.
COPY DOIRootCA2.cer /usr/local/share/ca-certificates/DOIRootCA2.crt

RUN chmod 644 /usr/local/share/ca-certificates/DOIRootCA2.crt && update-ca-certificates

# Install docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
               sudo add-apt-repository \
                  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
                  $(lsb_release -cs) \
                  stable" && \
               apt-get -y install docker-ce docker-ce-cli containerd.io
