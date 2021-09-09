ARG BASE_CONTAINER=dblodgett/hydrogeoenv-linux:latest

FROM ${BASE_CONTAINER}

LABEL maintainer="Taher Chegini <cheginit.gmail.com>"
ENV DEBIAN_FRONTEND=noninteractive

USER root

RUN pip3 install -U \
    --global-option=build_ext \
    --global-option="-I/usr/include/gdal" \
    gdal==`gdal-config --version`

RUN apt-get -y purge python3-simplejson

RUN pip3 install -U \
    requests \
    simplejson \
    geopandas \
    pygeos \
    shapely \
    rasterio \
    xarray \
    rioxarray \
    scipy \
    dask \
    sparse \
    bottleneck \
    netcdf4 \
    networkx \
    matplotlib \
    mapclassify \
    contextily \
    colorcet \
    descartes \
    cmocean \
    seaborn \
    numba \
    pyarrow \
    spotpy \
    osmnx \
    pint \
    numbagg \
    sympy \
    nb_black \
    jupyterlab-spellchecker \
    python-igraph \
    tqdm \
    h5py \
    tables \
    psutil \
    git+https://github.com/eea/odfpy

USER $NB_UID
