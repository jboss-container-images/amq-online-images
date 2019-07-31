#!/bin/bash

#sudo pip3 install virtualenv

virtualenv ~/cekit
source ~/cekit/bin/activate
pip install odcs
pip install docker-py
pip install docker-squash

pip install -U cekit
make

