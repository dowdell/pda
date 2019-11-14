#!/bin/sh

if [ ! -d ~pda/.cache/npm ]; then mkdir ~pda/.cache/npm; fi
chown pda ~pda/.cache/*

if [ -f /var/run/docker.sock ]; then chown pda /var/run/docker.sock; fi

su -s /usr/bin/fish pda
