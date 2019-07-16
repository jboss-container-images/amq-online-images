#!/bin/bash

sudo dnf install -y  python3-virtualenv
virtualenv ~/cekit
source ~/cekit/bin/activate
pip install -U cekit
make

