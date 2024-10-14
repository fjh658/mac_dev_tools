#!/usr/bin/env bash

#  gen_standalone_instruments is a script that generates a standalone instruments script
#  
#  Created by jianhua.fengjh on 08/10/2024
#  

# set environments
XCODE_PATH=/Applications/Xcode.app
XCODE_FRAMEWORKS_PATH=${XCODE_PATH}/Contents/Frameworks/
XCODE_SHARED_FRAMEWORKS_PATH=${XCODE_PATH}/Contents/SharedFrameworks/
XCODE_SYSTEM_FRAMEWORKS_PATH=${XCODE_PATH}/Contents/SystemFrameworks/

# copy this script's location
TARGET_ROOT_PATH=${PWD}
TARGET_PATH=${TARGET_ROOT_PATH}/Instruments.app/Contents/Frameworks/

# create standalone instruments bundle app
cp -Rf ${XCODE_PATH}/Contents/Applications/Instruments.app ${TARGET_ROOT_PATH}

# Method:

# 1. view all dependencies
#    DYLD_PRINT_LIBRARIES=1 DYLD_PRINT_LIBRARIES_POST_LAUNCH=1 DYLD_PRINT_RPATHS=1 /Applications/Xcode.app/Contents/Applications/Instruments.app/Contents/MacOS/Instruments
#    grep -r "SharedFrameworks" Instruments_16_loaded.log | grep -v "_CodeSignature"
# 2. uniq

declare -a name_array=(
    
    "DVTInstrumentsUtilities"
    "DVTInstrumentsFoundation"
    "DVTSystemPrerequisites"
    "DVTSystemPrerequisitesUI"
    "DTGraphKit"
    "DVTFoundation"
    "CoreSymbolicationDT"
    "SymbolicationDT"
    "kperfdataDT"
    "MallocStackLoggingDT"
    "ktraceDT"
    "DTXConnectionServices"
    "DebugSymbolsDT"
    "DVTInstrumentsAnalysisCore"
    "DTDeviceServices"
    "DVTUserInterfaceKit"
    "DTGTTimeline"
    "DTGanache"
    "DVTKeychain"
    "DVTKeychainService"
    "PackedPaths"
    "DVTKeychainUtilities"
    "DVTViewControllerKit"
    "DVTIconKit"
    "DVTStructuredLayoutKit"
    "DVTCocoaAdditionsKit"
    "SourceEditor"
    "SourceModel"
    "SourceModelSupport"
    "_CodeCompletionFoundation"

)

array_length=${#name_array[@]}

for (( i = 0; i < ${array_length}; i++ ));
do
    # echo "index: $i, value: ${name_array[$i]}"
    # echo "cp -Rf ${XCODE_SHARED_FRAMEWORKS_PATH}${name_array[$i]}.framework ${TARGET_PATH}"
    
    # copy dependent framework
    cp -Rf "${XCODE_SHARED_FRAMEWORKS_PATH}${name_array[$i]}.framework" ${TARGET_PATH}
done

# Developer/Platforms/MacOSX.platform/Developer/usr/lib/libXCTestSwiftSupport.dylib to Instruments.app/Contents/Frameworks/libXCTestSwiftSupport.dylib
cp -Rf "${XCODE_PATH}/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/lib/libXCTestSwiftSupport.dylib" "${TARGET_PATH}"

# fixed The bundle “Devices” couldn’t be loaded. Try reinstalling the bundle.
cp -Rf "/Library/Developer/PrivateFrameworks/CoreSimulator.framework" ${TARGET_PATH}
cp -Rf "/Library/Developer/PrivateFrameworks/CoreDevice.framework" ${TARGET_PATH}
cp -Rf "/Library/Developer/PrivateFrameworks/CoreDeviceUtilities.framework" ${TARGET_PATH}
cp -Rf "/Library/Developer/PrivateFrameworks/ROCKit.framework" ${TARGET_PATH}

cp -Rf "${XCODE_FRAMEWORKS_PATH}DVTNFASupport.framework" ${TARGET_PATH}

cp -Rf "${XCODE_SYSTEM_FRAMEWORKS_PATH}ModelIO.framework" ${TARGET_PATH}

cp -Rf ./fix.sh "${TARGET_ROOT_PATH}/Instruments.app/Contents/MacOS/"
# fake SDK check
mkdir -p "${TARGET_ROOT_PATH}/Instruments.app/Contents/Developer/Platforms/MacOSX.platform/"
rsync -av --exclude=Developer/iOSSupport/ --exclude=Developer/Library/ --exclude=Developer/usr/ --exclude=Developer/SDKs/MacOSX.sdk/System/ --exclude=Developer/SDKs/MacOSX.sdk/usr/ "${XCODE_PATH}/Contents/Developer/Platforms/MacOSX.platform/" "${TARGET_ROOT_PATH}/Instruments.app/Contents/Developer/Platforms/MacOSX.platform/"
# clean
rm -rf "${TARGET_ROOT_PATH}/Instruments.app/Contents/XCSystemLibraries"
rm -rf "${TARGET_ROOT_PATH}/Instruments.app/Contents/XCSystemFrameworks"
rm -rf "${TARGET_ROOT_PATH}/Instruments.app/Contents/XCContentsDir"

echo "Generate standalone Instruments is done! "