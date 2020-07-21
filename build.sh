#!/bin/bash

linux_TAG=${1:-latest}
r_TAG=${2:-latest}
python_TAG=${3:-latest}
custom_TAG=${4:-latest}
push=${5:-FALSE}

linux=dblodgett/hydrogeoenv-linux:$linux_TAG
python=dblodgett/hydrogeoenv-python:$python_TAG
r=dblodgett/hydrogeoenv-r:$r_TAG
custom=dblodgett/hydrogeoenv-custom:$custom_TAG

docker build -t $linux --build-arg BASE_CONTAINER=ubuntu:bionic-20200630 linux/
docker build -t $python --build-arg BASE_CONTAINER=dblodgett/hydrogeoenv-linux:$r_TAG python/
docker build -t $r --build-arg BASE_CONTAINER=dblodgett/hydrogeoenv-python:$linux_TAG r/
docker build -t $custom --build-arg BASE_CONTAINER=dblodgett/hydrogeoenv-r:$r_TAG custom/

if [ "$push" == "TRUE" ]; then
  docker push $linux
  docker push $r
  docker push $python
  docker push $custom
fi