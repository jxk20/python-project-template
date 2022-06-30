#!/bin/bash

GREEN='\033[0;32m'
NO_COLOUR='\033[0m'

# Black python code formatter first
./start_docker.sh ./run_code_formatter.sh

# Then pylint
./start_docker.sh ./run_pylint.sh

# Then mypy
./start_docker.sh ./run_mypy.sh

# Radon to calculate Cyclomatic Complexity
./start_docker.sh ./run_radon.sh

# # Download test files
TEST_VIDEO='tests/videos/test_video.mp4'
TEST_VIDEO_DL_LINK="https://this.link.com"
TEST_VIDEO_HASH='abcdefg'

download_if_doesnt_exist () {
    FILE_PATH=$1
    DOWNLOAD_LINK=$2
    FILE_HASH=$3
    if [ ! -f $FILE_PATH ]; then
        echo "Downloading to ${FILE_PATH}"
        ./start_docker.sh "gdown $DOWNLOAD_LINK -O $FILE_PATH"
        echo "Giving owner rights to $FILE_PATH"
        echo "sudo chown -hR $USER $FILE_PATH"
        sudo chown -hR $USER $FILE_PATH
    else
        echo "File has already been downloaded in ${FILE_PATH}"
    fi

    #Exit if checksum do not match
    if ! echo "$FILE_HASH $FILE_PATH" | sha256sum --check; then
        echo "Checksum for $FILE_PATH does not match!"
        exit 1
    fi
}

printf "${GREEN}DOWNLOADING FILES FOR TESTING${NO_COLOUR}\n"
download_if_doesnt_exist $TEST_VIDEO $TEST_VIDEO_DL_LINK $TEST_VIDEO_HASH

# Run pytest
./start_docker.sh ./run_pytest.sh
