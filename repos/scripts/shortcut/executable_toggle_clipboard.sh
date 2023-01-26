#!/bin/bash

exec >> /dev/null
exec 2>&1

if ps axf | grep '[g]reenclip daemon' | grep T; then
  greenclip print ' '
  xsel -bc -pc -sc
  ps axf | grep 'greenclip daemon' | grep -v grep | awk '{print $1}' | xargs kill -18
#  echo -e '{"message":"󰅉", "state": ""}' | socat unix-connect:/tmp/bumblebee_messagereceiver.sock STDIO
else
  ps axf | grep 'greenclip daemon' | grep -v grep | awk '{print $1}' | xargs kill -20
#  echo -e '{"message":"󱘛", "state": "warning"}' | socat unix-connect:/tmp/bumblebee_messagereceiver.sock STDIO
fi

