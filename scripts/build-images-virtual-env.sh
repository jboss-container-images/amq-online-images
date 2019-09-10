#!/bin/bash

#sudo pip3 install virtualenv

virtualenv ~/cekit
source ~/cekit/bin/activate

if ! which jq
then
    LOCAL_JQ_BIN=~/cekit/bin/jq
    curl -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 --output "${LOCAL_JQ_BIN}"
    chmod a+x "${LOCAL_JQ_BIN}"
fi

pip install odcs
pip install docker-py
pip install docker-squash
pip install yq

pip install -U cekit
make

