#!/bin/bash

if test -z "$1"; then
  ps a -o pid,etime,cmd | tail -n +2
  exit 0
fi

kill $(echo "$1" | awk '{print $1}')

