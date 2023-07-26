#!/usr/bin/env bash

# cd Instruments.app/Contents/MacOS
# sudo sh fix.sh

SHELL_PATH=$(dirname "$(readlink -f "$0")")
xattr -rd com.apple.quarantine $SHELL_PATH/../../