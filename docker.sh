#!/bin/bash

DOCKER_REGISTRY=retrocontestajvidhoekmrcpqzt.azurecr.io

ACTION=$1
AGENT_FOLDER=$2
AGENT_VERSION=$3

if [[ -z "$ACTION" ]]; then
  echo "Error: please provide first [build|push] parameter, e.g. build_docker.sh build"
  exit 1
elif [[ -z "$AGENT_FOLDER" ]] || [[ -z "$AGENT_VERSION" ]]; then
  echo "Error: please provide <folder> <version>, e.g. build_docker.sh build random-agent v3"
  exit 1
fi

if [[ "$ACTION" == "build" ]]; then
  cd $AGENT_FOLDER
  docker build -f box.docker -t $DOCKER_REGISTRY/$AGENT_FOLDER:$AGENT_VERSION .
  cd -
elif [[ "$ACTION" == "push" ]]; then
  docker push $DOCKER_REGISTRY/$AGENT_FOLDER:$AGENT_VERSION
fi


