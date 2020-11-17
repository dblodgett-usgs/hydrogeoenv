ARG BASE_CONTAINER=dblodgett/hydrogeoenv-r:latest

FROM ${BASE_CONTAINER}

LABEL maintainer="David Blodgett <dblodgett@usgs.gov>"

USER root

RUN Rscript -e 'devtools::install_github("usgs-r/intersectr")'

RUN Rscript -e 'devtools::install_github("usgs-r/nhdplusTools")'

RUN Rscript -e 'devtools::install_github("dblodgett-usgs/hyRefactor")'

RUN install2.r --error reticulate

RUN pip3 install -U \
    mapclassify \
    numpy \
    git+https://github.com/cheginit/pygeoogc.git \
    git+https://github.com/cheginit/pygeoutils.git \
    git+https://github.com/cheginit/pynhd.git \
    git+https://github.com/cheginit/py3dep.git \
    git+https://github.com/cheginit/pydaymet.git \
    git+https://github.com/cheginit/hydrodata.git

RUN Rscript -e 'devtools::install_github("USGS-R/USGSmarkdowntemplates")'

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

WORKDIR $HOME
