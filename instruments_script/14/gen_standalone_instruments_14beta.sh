#!/usr/bin/env bash

#  gen_standalone_instruments is a script that generates a standalone instruments script
#  
#  Created by jianhua.fengjh on 08/06/2022
#  

# set environments
XCODE_PATH=/Applications/Xcode-14.0.0-Beta.app
XCODE_SHARED_FRAMEWORKS_PATH=${XCODE_PATH}/Contents/SharedFrameworks/

# copy this script's location
TARGET_ROOT_PATH=${PWD}
TARGET_PATH=${TARGET_ROOT_PATH}/Instruments.app/Contents/Frameworks/

# create standalone instruments bundle app
cp -Rf ${XCODE_PATH}/Contents/Applications/Instruments.app ${TARGET_ROOT_PATH}

# Method:

# 1. view all dependencies
#    DYLD_PRINT_LIBRARIES=1 DYLD_PRINT_LIBRARIES_POST_LAUNCH=1 DYLD_PRINT_RPATHS=1 /Applications/Xcode.app/Contents/Applications/Instruments.app/Contents/MacOS/Instruments
# 2. uniq

declare -a name_array=(

"DVTInstrumentsUtilities"
"DVTInstrumentsFoundation"
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
"XCTHarness"
"DVTKeychain"
"DVTKeychainService"
"XCTAutomationSupport"
"XCTDaemonControl"
"XCTest"
"XCResultKit"
"XCUIAutomation"
"XCTestCore"
"XCUnit"
"DVTKeychainUtilities"
"DVTViewControllerKit"
"DVTIconKit"
"DVTStructuredLayoutKit"
"DVTCocoaAdditionsKit"
"DVTLibraryKit"
"SourceEditor"
"DVTSourceEditor"
"SourceModel"
"SourceModelSupport"
"SymbolCacheSupport"
"SourceKitSupport"
"MarkupSupport"
"DVTMarkup"
"SourceKit"
"SymbolCache"

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
cp -Rf "/Library/Developer/PrivateFrameworks/ROCKit.framework" ${TARGET_PATH}

cp -Rf ./fix.sh "${TARGET_ROOT_PATH}/Instruments.app/Contents/MacOS/"
# fake SDK check
cp -Rf ${TARGET_ROOT_PATH}/Developer "${TARGET_ROOT_PATH}/Instruments.app/Contents/"
echo "Generate standalone Instruments is done! "