ARG BASE_CONTAINER=dblodgett/hydrogeoenv-r:latest

FROM ${BASE_CONTAINER}

LABEL maintainer="David Blodgett <dblodgett@usgs.gov>"

USER root

RUN install2.r --error reticulate

RUN pip3 install -U \
    git+https://github.com/cheginit/async_retriever.git \
    git+https://github.com/cheginit/pygeoogc.git \
    git+https://github.com/cheginit/pygeoutils.git \
    git+https://github.com/cheginit/pynhd.git \
    git+https://github.com/cheginit/py3dep.git \
    git+https://github.com/cheginit/pydaymet.git \
    git+https://github.com/cheginit/pygeohydro.git

# to add to python layer.
RUN apt-get update && apt-get install -y python3-venv

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b && rm -f Miniconda3-latest-Linux-x86_64.sh
RUN chown -R 1000:100 /home/jovyan/.conda/

ENV PATH=$PATH:/home/jovyan/miniconda3/bin

RUN conda config --set auto_activate_base false

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID

WORKDIR $HOME
