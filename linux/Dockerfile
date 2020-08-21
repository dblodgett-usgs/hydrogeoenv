ARG BASE_CONTAINER=ubuntu:18.04

FROM ${BASE_CONTAINER}

LABEL maintainer="David Blodgett <dblodgett@usgs.gov>"

ARG NB_USER="jovyan"
ARG NB_UID="1000"
ARG NB_GID="100"

USER root

# From https://hub.docker.com/r/rocker/r-ubuntu/dockerfile
# and https://hub.docker.com/r/jupyter/base-notebook/dockerfile
# and https://hub.docker.com/r/jupyter/minimal-notebook/dockerfile        
# Install all OS dependencies for fully functional notebook server
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq --no-install-recommends \
        sudo \
        fonts-liberation \
        run-one \
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
        gnupg-agent \
        pkg-config \
        build-essential \
        emacs-nox \
        vim-tiny \
        git \
        inkscape \
        jed \
        libsm6 \
        libxext-dev \
        libxrender1 \
        lmodern \
        netcat \
        python-dev \
        # ---- nbconvert dependencies ----
        texlive-xetex \
        texlive-fonts-recommended \
        texlive-plain-generic \
        # Optional dependency
        texlive-fonts-extra \
        # ----
        tzdata \
        unzip \
        p7zip-full \
        nano \
        # Python3 essentials
        python3 \
        python3-dev \
        python3-pip \
        python3-llvmlite \
        && apt-get clean && rm -rf /var/lib/apt/lists/*
    
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - \
    && sudo apt-get install -y nodejs

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.utf8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV SHELL=/bin/bash \
    NB_USER=$NB_USER \
    NB_UID=$NB_UID \
    NB_GID=$NB_GID \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    HOME=/home/$NB_USER
    
COPY fix-permissions /usr/local/bin/fix-permissions
RUN chmod a+rx /usr/local/bin/fix-permissions

# Enable prompt color in the skeleton .bashrc before creating the default NB_USER
RUN sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' /etc/skel/.bashrc

# Create NB_USER wtih name jovyan user with UID=1000 and in the 'users' group
# and make sure these dirs are writable by the `users` group.
RUN echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    sed -i.bak -e 's/^%admin/#%admin/' /etc/sudoers && \
    sed -i.bak -e 's/^%sudo/#%sudo/' /etc/sudoers && \
    useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    chmod g+w /etc/passwd && \
    fix-permissions $HOME
    
ARG PYTHON_VERSION=default

# Setup work directory for backward-compatibility
RUN mkdir /home/$NB_USER/work && \
    fix-permissions /home/$NB_USER
    
EXPOSE 8888

RUN pip3 install -U setuptools wheel pip

# Install jupyterlab and jupytext
RUN pip3 install -U jupyterlab jupytext ipymd \
    && jupyter lab build
   
# install DOI root certificate so things work on the DOI network.
COPY DOIRootCA2.cer /usr/local/share/ca-certificates/DOIRootCA2.crt

RUN chmod 644 /usr/local/share/ca-certificates/DOIRootCA2.crt && update-ca-certificates

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# Configure container startup
ENTRYPOINT ["/tini", "-g", "--"]
CMD ["start-notebook.sh"]

# Copy local files as late as possible to avoid cache busting
COPY start.sh start-notebook.sh start-singleuser.sh /usr/local/bin/
COPY jupyter_notebook_config.py /etc/jupyter/

# Fix permissions on /etc/jupyter as root
RUN fix-permissions /etc/jupyter/

RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable

# from: https://hub.docker.com/r/rocker/tidyverse/dockerfile
# and https://github.com/rocker-org/geospatial/blob/master/Dockerfile
RUN apt-get update -qq \
    && apt-get -y --no-install-recommends install \
        libxml2-dev \
        libcairo2-dev \
        libsqlite-dev \
        libpq-dev \
        libssh2-1-dev \
        unixodbc-dev \
        libsasl2-dev \
        libssl-dev \
        libcurl4-openssl-dev \
        libsodium-dev \
        lbzip2 \
        libfftw3-dev \
        libmysqlclient-dev \
        default-libmysqlclient-dev \
        libgdal-dev \
        gdal-bin \
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
        libnetcdff-dev \
        libsqlite3-dev \
        libssl-dev \
        libudunits2-dev \
        netcdf-bin \
        postgis \
        protobuf-compiler \
        sqlite3 \
        tk-dev \
        libv8-dev \
        unixodbc-dev \
        gfortran \
        liblapack-dev \
        libblas-dev \
        libspatialindex-dev \
        build-essential \
        libffi-dev \
        libxslt1-dev \
        zlib1g-dev \
        libspatialindex-dev

RUN apt-get autoremove -y && \
    apt-get autoclean

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

WORKDIR $HOME
