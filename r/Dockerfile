ARG BASE_CONTAINER=dblodgett/hydrogeoenv-python:latest

FROM ${BASE_CONTAINER}

LABEL maintainer="David Blodgett <dblodgett@usgs.gov>"

USER root

# From https://hub.docker.com/r/rocker/r-ubuntu/dockerfile
RUN add-apt-repository --enable-source --yes "ppa:marutter/rrutter4.0"

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
    devtools \
    tidyverse \
    codetools \
    RColorBrewer \
    RandomFields \
    systemfonts \
    svglite \
    reticulate \
    RSQLite \
    RNetCDF \
    classInt \
    hdf5r \
    ncdf4 \
    proj4 \
    raster \
    rgdal \
    rgeos \
    sf \
    sp \
    dataRetrieval \
    sbtools

RUN install2.r --error \
    --deps FALSE \
    stars

RUN install2.r --error \
    --deps TRUE \
    spacetime \
    spatstat \
    geoR \
    geosphere \
    spdep \
    deldir \
    gstat \
    lidR \
    rlas \
    mapdata \
    maptools \
    mapview \
    leafpop

RUN Rscript -e 'devtools::install_github("RBigData/pbdZMQ")'

RUN install2.r --error --deps TRUE IRkernel

USER $NB_UID

RUN Rscript -e 'IRkernel::installspec()'
