#!/bin/bash
# Run my development local image for osrf/ros:noetic_desktop_full


set -ex

XSOCK=/tmp/.X11-unix
XAUTH=$HOME/.Xauthority
SHARED_DOCKER_DIR=/home/shuhei/shared_dir
SHARED_HOST_DIR=$HOME/shared_dir
IMAGE=$1
VOLUMES="--volume=$XSOCK:$XSOCK:rw
         --volume=$XAUTH:$XAUTH:rw
         --volume=$SHARED_HOST_DIR:$SHARED_DOCKER_DIR:rw"

USER_ID="$(id -u)"
RUNTIME="--gpus all"

NAME="ros_noetic_development"
name_arg=$2
if [ "$name_arg" != "" ]; then
    NAME=$name_arg
fi

echo "Launching $IMAGE"
echo "Without --rm option"

docker run \
    -it \
    --name $NAME \
    $VOLUMES \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY=${DISPLAY}" \
    --env="USER_ID=$USER_ID" \
    --privileged \
    --net=host \
    $RUNTIME \
    $IMAGE
