ARG BASE_CONTAINER=dblodgett/hydrogeoenv-python:latest

FROM ${BASE_CONTAINER}

LABEL maintainer="David Blodgett <dblodgett@usgs.gov>"

USER root

# From https://hub.docker.com/r/rocker/r-ubuntu/dockerfile
RUN add-apt-repository --enable-source --yes "ppa:marutter/rrutter4.0" \
    && add-apt-repository --enable-source --yes "ppa:c2d4u.team/c2d4u4.0+"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        littler \
        r-base \
        r-base-dev \
        r-recommended \
  	&& ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
 	&& ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
 	&& ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
 	&& ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
 	&& install.r docopt \
 	&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
 	&& rm -rf /var/lib/apt/lists/*
    
RUN Rscript -e 'install.packages("BiocManager", repos="http://cran.us.r-project.org"); BiocManager::install("EBImage")'

RUN install2.r --error \
    --deps TRUE \
    httr \
    curl \
    openssl \
    tidyverse \
    dplyr \
    devtools \
    RColorBrewer \
    RandomFields \
    RNetCDF \
    classInt \
    deldir \
    gstat \
    hdf5r \
    lidR \
    mapdata \
    maptools \
    mapview \
    ncdf4 \
    proj4 \
    raster \
    rgdal \
    rgeos \
    rlas \
    sf \
    sp \
    spacetime \
    spatstat \
    spdep \
    geoR \
    geosphere \
    codetools \
    dataRetrieval \
    IRkernel \
    RSQLite \
    systemfonts \
    leafpop \
    svglite \
    reticulate \
    sbtools

RUN apt-get update -qq \
        && apt-get -y --no-install-recommends install pandoc

USER $NB_UID

RUN Rscript -e 'IRkernel::installspec()'
