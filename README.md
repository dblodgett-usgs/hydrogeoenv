# Hydrologic Geospatial Environment Docker Container

This repository contains three Dockerfiles.
- `linux` contains system dependencies, primarily installed with apt-get.
- `r` contains the r-base install and a large number of R packages.
- `custom` is more of a template for projects to use to install their custom dependencies.

It would make sense to add a fourth `python` Dockerfile but at this time, no significant `python` work has been applied in the workflows that these containers support.

A list of installed packages in the `custom` image is provided in [r_table.md](docs/r_table.md) and [python_table.md](docs/python_table.md) files in the `docs` folder.

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

## USGS WSL2 Guidance

For USGS users on windows, you may need help getting docker set up. as of 2/2/2022, the following worked.

1. Work with your local IT admin to get added to the correct AD group and install the required software as described [here](https://tst.usgs.gov/operating-systems-2/windows-subsystem-for-linux/) (vpn required).
1. in powershell, [install wsl](https://docs.microsoft.com/en-us/windows/wsl/install) and set the default version to 2.

In powershell
```sh
wsl --install
wsl --set-default-version 2
wsl --list --online
wsl --install -d Ubuntu-20.04
# You may need to press enter in the screen that pops up to get it to run.
wsl
```

You should now be in a running ubuntu 20.04 instance.

See source and other goodies: https://code.chs.usgs.gov/jmfee/wsl-environment/-/blob/main/install.d/docker-ce.sh
```sh
sudo wget -O /usr/local/share/ca-certificates/DOIRootCA2.crt http://sslhelp.doi.net/docs/DOIRootCA2.cer
sudo chmod 644 /usr/local/share/ca-certificates/DOIRootCA2.crt && sudo update-ca-certificates

# from https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
# add apt repository
if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

# install
sudo apt update
sudo apt install -y docker-ce
sudo usermod -a -G docker $USER
sudo service docker start
unset DOCKER_HOST

docker run hello-world
```


## Disclaimer

This information is preliminary or provisional and is subject to revision. It is being provided to meet the need for timely best science. The information has not received final approval by the U.S. Geological Survey (USGS) and is provided on the condition that neither the USGS nor the U.S. Government shall be held liable for any damages resulting from the authorized or unauthorized use of the information.

This software is in the public domain because it contains materials that originally came from the U.S. Geological Survey  (USGS), an agency of the United States Department of Interior. For more information, see the official USGS copyright policy at [https://www.usgs.gov/visual-id/credit_usgs.html#copyright](https://www.usgs.gov/visual-id/credit_usgs.html#copyright)

Although this software program has been used by the USGS, no warranty, expressed or implied, is made by the USGS or the U.S. Government as to the accuracy and functioning of the program and related program material nor shall the fact of distribution constitute any such warranty, and no responsibility is assumed by the USGS in connection therewith.

This software is provided "AS IS."

 [
    ![CC0](https://i.creativecommons.org/p/zero/1.0/88x31.png)
  ](https://creativecommons.org/publicdomain/zero/1.0/)
