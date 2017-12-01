#!/bin/sh

set -e

[ -f /opt/rh/rh-nodejs4/enable ] && . /opt/rh/rh-nodejs4/enable
cd /opt/app-root/src
npm install debug && npm install rhea