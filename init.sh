#!/bin/sh

chown -R dev:dev /home/src
su -l -c "$@" dev
