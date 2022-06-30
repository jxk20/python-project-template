#!/bin/bash
DOCKER_IMAGE=jxk20/popeyes:latest #Change if necessary

USAGE="Usage: ./`basename $0` [-h] [<bash-command>]

Optional arguments:
  -h              Show this help message and exit
  <bash-command>  This bash command will be executed in the docker container
                  if given

Example usage:
./`basename $0` 'echo hello'
This will echo 'hello' in the docker container.
"

PARENT_PWD=$(dirname "$PWD")
PWD_NAME=$(basename "$PWD")
WORKSPACE=/workspace

SERVER_VERSION=$(docker version -f "{{.Server.Version}}")
SERVER_VERSION_MAJOR=$(echo "$SERVER_VERSION"| cut -d'.' -f 1)
SERVER_VERSION_MINOR=$(echo "$SERVER_VERSION"| cut -d'.' -f 2)
SERVER_VERSION_BUILD=$(echo "$SERVER_VERSION"| cut -d'.' -f 3)

# See https://stackoverflow.com/questions/52865988/nvidia-docker-unknown-runtime-specified-nvidia#comment102492832_52865988
# --runtime=nvidia can only be used for Docker version < 19.0.3
# Else, use --gpus=all
if [ "${SERVER_VERSION_MAJOR}" -lt 19 ] || \
    [ "${SERVER_VERSION_MAJOR}" -eq 19 ] && [ "${SERVER_VERSION_MINOR}" -eq 0 ] && [ "${SERVER_VERSION_BUILD}" -lt 3 ]; then
    NVIDIA_FLAG='--runtime=nvidia'
else
    NVIDIA_FLAG='--gpus all'
fi


DOCKER_COMMAND="docker run -it $NVIDIA_FLAG -w $WORKSPACE/$PWD_NAME -v $PARENT_PWD:$WORKSPACE --net=host --ipc host -e DISPLAY=unix$DISPLAY $DOCKER_IMAGE"

if [ $# -eq 0 ]; then #Checks number of input arguments
    $DOCKER_COMMAND
elif [ $# -eq 1 ]; then
    if [ "$1" == "-h" ]; then
        echo -e "$USAGE"
        exit 0
    else
        NEW_BASH_SCRIPT="$1"
        $DOCKER_COMMAND bash -c "$NEW_BASH_SCRIPT"
    fi
fi
