#!/bin/bash

if [ $# -eq 0 ]; then
  echo "No arguments provided"
  echo "usage: build.sh linux_tag r_tag python_tag custom_tag push nocache_l nocache_p nocache_r nocache_c"
  echo "defaults: build.sh latest latest latest latest FALSE false false false false"
  exit 1
fi

linux_TAG=${1:-latest}
r_TAG=${2:-latest}
python_TAG=${3:-latest}
custom_TAG=${4:-latest}
push=${5:-FALSE}

nocache_l=${6:-false}
nocache_p=${7:-false}
nocache_r=${8:-false}
nocache_c=${9:-false}

linux=dblodgett/hydrogeoenv-linux:$linux_TAG
python=dblodgett/hydrogeoenv-python:$python_TAG
r=dblodgett/hydrogeoenv-r:$r_TAG
custom=dblodgett/hydrogeoenv-custom:$custom_TAG

docker build -t $linux --build-arg BASE_CONTAINER=ubuntu:bionic-20200630 --no-cache=$nocache_l linux/
docker build -t $python --build-arg BASE_CONTAINER=dblodgett/hydrogeoenv-linux:$r_TAG --no-cache=$nocache_p python/
docker build -t $r --build-arg BASE_CONTAINER=dblodgett/hydrogeoenv-python:$linux_TAG --no-cache=$nocache_r r/
docker build -t $custom --build-arg BASE_CONTAINER=dblodgett/hydrogeoenv-r:$r_TAG --no-cache=$nocache_c custom/

if [ "$push" == "TRUE" ]; then
  docker push $linux
  docker push $r
  docker push $python
  docker push $custom
fi