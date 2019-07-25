#!/bin/bash

#sudo pip3 install virtualenv

virtualenv ~/cekit
source ~/cekit/bin/activate
pip install odcs
pip install -U cekit==3.2.0
make

