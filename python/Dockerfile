ARG BASE_CONTAINER=ubuntu:latest

FROM ${BASE_CONTAINER}

LABEL maintainer="David Blodgett <dblodgett@usgs.gov>"
ENV DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    pkg-config

RUN apt-get install -y \
    libgdal-dev \
    gdal-bin \
    libnetcdff-dev \
    gfortran \
    liblapack-dev \
    libspatialindex-dev \
    libspatialindex6 \
    python3-pip

RUN apt-get autoremove -y && \
    apt-get autoclean

RUN pip3 install -U \
    numpy \
    hydrodata \
    dask \
    netCDF4 \
    bottleneck \
    descartes \
    sparse \
    cmocean \
    viscm \
    colorspacious \
    seaborn \
    numba \
    pyarrow \
    spotpy \
    rioxarray \
    osmnx \
    pint \
    numbagg \
    jupyterlab

USER $NB_UID

