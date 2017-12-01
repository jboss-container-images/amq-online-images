#!/bin/sh

set -e

# Create a user and group used to launch processes
# We use the ID 185 fot the group as well as for the user.
# This ID is reserved on RHEL, centOS, and fedora
# which makes it safe to use.
groupadd -r jboss -g 185 && useradd -u 185 -r -g jboss -m -d /home/jboss -s /sbin/nologin -c "JBoss user" jboss