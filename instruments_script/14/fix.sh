#!/usr/bin/env bash

# cd Instruments.app/Contents/MacOS
# sudo sh fix.sh

DEV_PRIV_FX="/Library/Developer/PrivateFrameworks"

if [ ! -d "${DEV_PRIV_FX}/CoreSimulator.framework" ]; then
    mkdir -p "${DEV_PRIV_FX}"
    cp -Rf "../Frameworks/CoreSimulator.framework" "${DEV_PRIV_FX}"    
fi


if [ ! -d "${DEV_PRIV_FX}/ROCKit.framework" ]; then
    mkdir -p "${DEV_PRIV_FX}"
    cp -Rf "../Frameworks/ROCKit.framework" "${DEV_PRIV_FX}"    
fi

if [ ! -d "${DEV_PRIV_FX}/CoreDevice.framework" ]; then
    mkdir -p "${DEV_PRIV_FX}"
    cp -Rf "../Frameworks/CoreDevice.framework" "${DEV_PRIV_FX}"    
fi

SHELL_PATH=$(dirname "$(readlink -f "$0")")
rm -rf $SHELL_PATH/../XCSystemFrameworks
xattr -rd com.apple.quarantine $SHELL_PATH/../../../