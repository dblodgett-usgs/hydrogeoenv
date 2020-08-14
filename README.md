# Hydrologic Geospatial Environment Docker Container

This repository contains three Dockerfiles.
- `linux` contains system dependencies, primarily installed with apt-get.
- `r` contains the r-base install and a large number of R packages.
- `custom` is more of a template for projects to use to install their custom dependencies.

It would make sense to add a fourth `python` Dockerfile but at this time, no significant `python` work has been applied in the workflows that these containers support.

## Usage

NOTE: When using these containers, consider rerunning a docker pull command regularly:

```bash
$ docker pull dblodgett/hydrogeoenv-custom:latest
```

As the project progresses, tagged versions will be established and those should be relied on going forward. 
 
There are two usage patterns for this system of containers.

1. Via `docker-compose` where access is through jupyterlab on localhost

In this mode, the server is started with the typical 

```bash
$ docker-compose up
```

From within the directory containing a `docker-compose.yml` file. The `docker-compose.yml` file included in this repository shows the basic required elements to get this to work.

Once started, a jupyterlab interface will then be available via http://localhost:8888

2. Via `docker run` where a `.Rmd` file is run in headless mode.

In this mode, docker is kicked off with a set of commands to execute like:

```
docker run --mount type=bind,source="$(pwd)"/workspace,target=/jupyter dblodgett/hydrogeoenv-custom:latest R -e "rmarkdown::render('/jupyter/plot_nhdplus.Rmd', output_file='/jupyter/build/plot_nhdplus.html')"
mv workspace/build/* docs/demo/nhdplusTools/
```
see output: https://dblodgett-usgs.github.io/hydrogeoenv/demo/nhdplusTools/plot_nhdplus.html

```
docker run --mount type=bind,source="$(pwd)"/workspace,target=/jupyter dblodgett/hydrogeoenv-custom:latest jupyter nbconvert --ExecutePreprocessor.timeout=360 --to html --output /jupyter/build/plot_nhdplus_python.html --execute /jupyter/plot_nhdplus_python.ipynb
mv workspace/build/* docs/demo/hydrodata/
````
See output: https://dblodgett-usgs.github.io/hydrogeoenv/demo/hydrodata/plot_nhdplus_python.html

## Disclaimer

This information is preliminary or provisional and is subject to revision. It is being provided to meet the need for timely best science. The information has not received final approval by the U.S. Geological Survey (USGS) and is provided on the condition that neither the USGS nor the U.S. Government shall be held liable for any damages resulting from the authorized or unauthorized use of the information.

This software is in the public domain because it contains materials that originally came from the U.S. Geological Survey  (USGS), an agency of the United States Department of Interior. For more information, see the official USGS copyright policy at [https://www.usgs.gov/visual-id/credit_usgs.html#copyright](https://www.usgs.gov/visual-id/credit_usgs.html#copyright)

Although this software program has been used by the USGS, no warranty, expressed or implied, is made by the USGS or the U.S. Government as to the accuracy and functioning of the program and related program material nor shall the fact of distribution constitute any such warranty, and no responsibility is assumed by the USGS in connection therewith.

This software is provided "AS IS."

 [
    ![CC0](https://i.creativecommons.org/p/zero/1.0/88x31.png)
  ](https://creativecommons.org/publicdomain/zero/1.0/)