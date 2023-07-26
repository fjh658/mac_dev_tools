#!/usr/bin/env bash

#  gen_standalone_instruments is a script that generates a standalone instruments script
#  
#  Created by jianhua.fengjh on 13/3/2022
#  

# set environments
XCODE_PATH=/Applications/Xcode.app
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

###### Instruments Original frameworks begin ######
# DTBinaryAnalysis
# DTInstrumentsX
# InstrumentsAnalysisCore
# InstrumentsKit
# InstrumentsPackaging
# InstrumentsPlugIn
# InstrumentsTrace
# XCTraceCore

###### Instruments Original frameworks end ######

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
"DVTKeychain"
"DVTKeychainService"
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
"SourceKitSupport"
"MarkupSupport"
"DVTMarkup"
"SourceKit"

)

array_length=${#name_array[@]}

for (( i = 0; i < ${array_length}; i++ ));
do
    # echo "index: $i, value: ${name_array[$i]}"
    # echo "cp -Rf ${XCODE_SHARED_FRAMEWORKS_PATH}${name_array[$i]}.framework ${TARGET_PATH}"
    
    # copy dependent framework
    cp -Rf "${XCODE_SHARED_FRAMEWORKS_PATH}${name_array[$i]}.framework" ${TARGET_PATH}
done
cp -Rf ./fix.sh "${TARGET_ROOT_PATH}/Instruments.app/Contents/MacOS/"

echo "Generate standalone Instruments is done! "