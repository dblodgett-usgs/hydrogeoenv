ARG BASE_CONTAINER=dblodgett/hydrogeoenv-r:latest

FROM ${BASE_CONTAINER}

LABEL maintainer="David Blodgett <dblodgett@usgs.gov>"

USER root

RUN Rscript -e 'devtools::install_github("usgs-r/intersectr", upgrade = FALSE)'

RUN Rscript -e 'devtools::install_github("usgs-r/nhdplusTools", upgrade = FALSE)'

RUN Rscript -e 'devtools::install_github("dblodgett-usgs/hyRefactor", upgrade = FALSE)'

RUN Rscript -e 'devtools::install_github("dblodgett-usgs/hygeo", upgrade = FALSE)'

RUN install2.r --error reticulate

RUN pip3 install -U \
    git+https://github.com/cheginit/async_retriever.git \
    git+https://github.com/cheginit/pygeoogc.git \
    git+https://github.com/cheginit/pygeoutils.git \
    git+https://github.com/cheginit/pynhd.git \
    git+https://github.com/cheginit/py3dep.git \
    git+https://github.com/cheginit/pydaymet.git \
    git+https://github.com/cheginit/pygeohydro.git

RUN Rscript -e 'devtools::install_github("USGS-R/USGSmarkdowntemplates")'

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

WORKDIR $HOME
