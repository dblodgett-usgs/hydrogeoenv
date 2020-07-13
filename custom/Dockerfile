ARG BASE_CONTAINER=dblodgett-usgs/hydrogeoenv-r:latest

FROM ${BASE_CONTAINER}

LABEL maintainer="David Blodgett <dblodgett@usgs.gov>"

USER root

RUN Rscript -e 'devtools::install_github("usgs-r/intersectr")'

RUN Rscript -e 'devtools::install_github("usgs-r/nhdplusTools")'

RUN Rscript -e 'devtools::install_github("dblodgett-usgs/hyRefactor")'

RUN jupyter lab build