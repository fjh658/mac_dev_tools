#!/usr/bin/env bash

INSTRUMENTS_APP_PATH="/Applications/Instruments_14.3.1.app"
DEV_PRIV_FX="/Library/Developer/PrivateFrameworks"

if [ ! -d "${DEV_PRIV_FX}/CoreSimulator.framework" ]; then
    mkdir -p "${DEV_PRIV_FX}"
    cp -Rf "${INSTRUMENTS_APP_PATH}/Contents/Frameworks/CoreSimulator.framework" "${DEV_PRIV_FX}"    
fi

if [ ! -d "${DEV_PRIV_FX}/ROCKit.framework" ]; then
    mkdir -p "${DEV_PRIV_FX}"
    cp -Rf "${INSTRUMENTS_APP_PATH}/Contents/Frameworks/ROCKit.framework" "${DEV_PRIV_FX}"    
fi

if [ ! -d "${DEV_PRIV_FX}/CoreDevice.framework" ]; then
    mkdir -p "${DEV_PRIV_FX}"
    cp -Rf "${INSTRUMENTS_APP_PATH}/Contents/Frameworks/CoreDevice.framework" "${DEV_PRIV_FX}"    
fi

rm -rf ${INSTRUMENTS_APP_PATH}/Contents/XCSystemFrameworks
xattr -rd com.apple.quarantine ${INSTRUMENTS_APP_PATH}