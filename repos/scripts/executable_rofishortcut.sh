#!/bin/bash

SCRIPT_DIR="$HOME/repos/scripts/shortcut/"

if test -n "$ROFI_DATA"; then
  $SCRIPT_DIR/"$ROFI_DATA" $@
  exit 0
fi

if test "$ROFI_RETV" -eq 1; then
  echo -en "\0data\x1f$1\n"
  $SCRIPT_DIR/"$1"
  exit 0
fi

IFS=$'\n'
for SHORTCUT in $(ls $SCRIPT_DIR); do
  echo -e "$SHORTCUT\0icon\x1fapplication-x-executable"
done

#if [ x"$@" = x"quit" ]
#then
#  exit 0
#fi
