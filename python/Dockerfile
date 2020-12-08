ARG BASE_CONTAINER=dblodgett/hydrogeoenv-linux:latest

FROM ${BASE_CONTAINER}

LABEL maintainer="Taher Chegini <cheginit.gmail.com>"
ENV DEBIAN_FRONTEND=noninteractive

USER root

RUN pip3 install -U --global-option=build_ext --global-option="-I/usr/include/gdal" GDAL==`gdal-config --version`

RUN apt-get install -y libspatialindex-dev

RUN pip3 install -U \
    Rtree \
    dask \
    bottleneck \
    netCDF4 \
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
    sympy \
    hydrodata \
    mapclassify \
    git+https://github.com/eea/odfpy

USER $NB_UID
