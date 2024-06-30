#!/bin/bash
# $1 argument holds whether to use common docker image or not
# $2 holds java version
# $3 is service path
JAVA_VERSION=${2:-'17'}
SERVICE_PATH=${3:-'.'}

if [ "$1" != 'true' ]
then
  DOCKER_BUILDKIT=1 bash -c "docker build -t $ARTIFACT_REGISTRY/$REPO_NAME:$BUILD_NUMBER ."
else
  if [ "$JAVA_VERSION" != '17' ]
  then
    sed -i "s/base-jre-17/base-jre-$JAVA_VERSION/g" "$GITHUB_ACTION_PATH/Dockerfile_Java"
  fi
  DOCKER_BUILDKIT=1 bash -c "docker build -t $ARTIFACT_REGISTRY/$REPO_NAME:$BUILD_NUMBER --build-arg \"SERVICE_PATH=$SERVICE_PATH\" -f $GITHUB_ACTION_PATH/Dockerfile_Java ."
fi