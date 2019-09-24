#!/bin/bash

#sudo pip3 install virtualenv

virtualenv ~/cekit3
source ~/cekit3/bin/activate

if ! which jq
then
    LOCAL_JQ_BIN=~/cekit3/bin/jq
    curl -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 --output "${LOCAL_JQ_BIN}"
    chmod a+x "${LOCAL_JQ_BIN}"
fi

pip3 install odcs
pip3 install docker-py
pip3 install docker-squash
pip3 install yq

pip3 install -U cekit==3.5.0
make

