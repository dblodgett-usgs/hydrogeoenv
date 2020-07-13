ARG BASE_CONTAINER=jupyter/minimal-notebook:76402a27fd13
FROM $BASE_CONTAINER

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
        && add-apt-repository --enable-source --yes "ppa:marutter/rrutter4.0" \
        && add-apt-repository --enable-source --yes "ppa:c2d4u.team/c2d4u4.0+"

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

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

# from: https://hub.docker.com/r/rocker/tidyverse/dockerfile
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
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
 
RUN install2.r --error \
    --deps TRUE \
    httr \
    curl \
    openssl

RUN install2.r --error \
    --deps TRUE \
    tidyverse \
    dplyr \
    devtools \
    remotes
	
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
    unixodbc-dev

RUN install2.r --error \
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
    geosphere

# locally defined
RUN install2.r --error \
    codetools \
    dataRetrieval \
    IRkernel \
    RSQLite \
    systemfonts \
    leafpop \
    svglite \
    sbtools

RUN Rscript -e 'devtools::install_github("usgs-r/intersectr")'

RUN Rscript -e 'devtools::install_github("usgs-r/nhdplusTools")'

RUN Rscript -e 'devtools::install_github("dblodgett-usgs/hyRefactor")'

USER $NB_UID

RUN Rscript -e 'IRkernel::installspec()'

USER root

# Install numpy, scipy and matplotlib
RUN pip install scipy matplotlib pandas sympy

COPY DOIRootCA2.cer /usr/local/share/ca-certificates/DOIRootCA2.crt

RUN chmod 644 /usr/local/share/ca-certificates/DOIRootCA2.crt && update-ca-certificates

RUN pip --cert /usr/local/share/ca-certificates/DOIRootCA2.crt install ipymd && \
		pip --cert /usr/local/share/ca-certificates/DOIRootCA2.crt install git+https://github.com/eea/odfpy

RUN pip --cert /usr/local/share/ca-certificates/DOIRootCA2.crt install jupytext

# Install docker
RUN apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common && \
               curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
               sudo add-apt-repository \
                  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
                  $(lsb_release -cs) \
                  stable" && \
               apt-get -y install docker-ce docker-ce-cli containerd.io

