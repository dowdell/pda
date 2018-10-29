#!/bin/sh

if [[ ! `id $USER 2> /dev/null` ]]; then
    adduser -h /home -s /usr/bin/fish -D $USER
fi

su $USER
