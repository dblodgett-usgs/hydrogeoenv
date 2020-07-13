#!/bin/bash

linux_TAG=${1:-latest}
r_TAG=${2:-latest}
custom_TAG=${3:-latest}
push=${4:-FALSE}

linux=dblodgett-usgs/hydrogeoenv-linux:$linux_TAG
r=dblodgett-usgs/hydrogeoenv-r:$r_TAG
custom=dblodgett-usgs/hydrogeoenv-custom:$custom_TAG

docker build -t $linux --build-arg BASE_CONTAINER=jupyter/minimal-notebook:76402a27fd13 linux/
docker build -t $r --build-arg BASE_CONTAINER=dblodgett-usgs/hydrogeoenv-linux:$linux_TAG r/
docker build -t $custom --build-arg BASE_CONTAINER=dblodgett-usgs/hydrogeoenv-r:$r_TAG custom/

if [ "$push" == "TRUE" ]; then
  docker push $linux
  docker push $r
  docker push $custom
fi