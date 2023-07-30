#!/usr/bin/env bash

INSTRUMENTS_APP_PATH="/Applications/Instruments_13.4.1.app"
xattr -rd com.apple.quarantine ${INSTRUMENTS_APP_PATH}