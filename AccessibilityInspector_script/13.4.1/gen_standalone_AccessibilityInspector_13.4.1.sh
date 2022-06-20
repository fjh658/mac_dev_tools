#!/usr/bin/env bash

#  gen_standalone_AccessibilityInspector is a script that generates a standalone Accessibility Inspector script
#  
#  Created by jianhua.fengjh on 13/3/2022
#  

# set environments
XCODE_PATH=/Applications/Xcode.app
XCODE_SHARED_FRAMEWORKS_PATH=${XCODE_PATH}/Contents/SharedFrameworks/

# copy this script's location
TARGET_ROOT_PATH=${PWD}
TARGET_PATH="${TARGET_ROOT_PATH}/Accessibility Inspector.app/Contents/Frameworks/"

# create standalone Accessibility Inspector bundle app
cp -Rf "${XCODE_PATH}/Contents/Applications/Accessibility Inspector.app" ${TARGET_ROOT_PATH}

# Method:

# 1. view all dependencies
#    DYLD_PRINT_LIBRARIES=1 DYLD_PRINT_LIBRARIES_POST_LAUNCH=1 DYLD_PRINT_RPATHS=1 /Applications/Xcode.app/Contents/Applications/Accessibility\ Inspector.app/Contents/MacOS/Accessibility\ Inspector
# 2. uniq

declare -a name_array=(

"AccessibilityAudit"     
"AccessibilitySupport"
"CoreSymbolicationDT"
"DTDeviceKit"
"DTDeviceKitBase"
"DTXConnectionServices"
"DVTCocoaAdditionsKit"
"DVTDeviceFoundation"
"DVTDeviceKit"
"DVTExplorableKit"
"DVTFoundation"
"DVTIconKit"
"DVTInstrumentsFoundation"
"DVTInstrumentsUtilities"
"DVTKeychain"
"DVTKeychainService"
"DVTKeychainUtilities"
"DVTKit"
"DVTLibraryKit"
"DVTPortal"
"DVTServices"
"DVTStructuredLayoutKit"
"DVTUserInterfaceKit"
"DVTViewControllerKit"
"DebugSymbolsDT"
"MallocStackLoggingDT"
"SymbolicationDT"
"XCTAutomationSupport"
"XCTest"
"XCTestCore"
"XCUIAutomation"
"XCUnit"
"kperfdataDT"
"ktraceDT"

)

array_length=${#name_array[@]}

for (( i = 0; i < ${array_length}; i++ ));
do
    # echo "index: $i, value: ${name_array[$i]}"
    # echo "cp -Rf ${XCODE_SHARED_FRAMEWORKS_PATH}${name_array[$i]}.framework ${TARGET_PATH}"
    
    # copy dependent framework
    cp -Rf "${XCODE_SHARED_FRAMEWORKS_PATH}${name_array[$i]}.framework" "${TARGET_PATH}"
done

# fix AccessibilitySupport reference
cp -Rf "${TARGET_PATH}/AccessibilitySupport.framework/Versions/B/Frameworks/AccessibilityEvents.framework" "${TARGET_PATH}"
cp -Rf "${TARGET_PATH}/AccessibilitySupport.framework/Versions/B/Frameworks/AccessibilityFoundation.framework" "${TARGET_PATH}"
cp -Rf "${TARGET_PATH}/AccessibilitySupport.framework/Versions/B/Frameworks/AccessibilityKit.framework" "${TARGET_PATH}"
cp -Rf "${TARGET_PATH}/AccessibilitySupport.framework/Versions/B/Frameworks/AccessibilityVisuals.framework" "${TARGET_PATH}"

rm -rf "${TARGET_PATH}/AccessibilitySupport.framework/Versions/B/Frameworks/AccessibilityEvents.framework/"
rm -rf "${TARGET_PATH}/AccessibilitySupport.framework/Versions/B/Frameworks/AccessibilityFoundation.framework/"
rm -rf "${TARGET_PATH}/AccessibilitySupport.framework/Versions/B/Frameworks/AccessibilityKit.framework/"
rm -rf "${TARGET_PATH}/AccessibilitySupport.framework/Versions/B/Frameworks/AccessibilityVisuals.framework/"


# fix No macOS Platform was found, but Xcode requires a macOS Platform. You may have an incomplete or damaged installation of Xcode.
# copy /Applications/Xcode.app/Contents/Developer/Platforms to Accessibility Inspector.app//Contents/Developer/Platforms
# eg: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform

# mkdir -p "${TARGET_ROOT_PATH}/Accessibility Inspector.app/Contents/Developer/Platforms/"
# cp -Rf "${XCODE_PATH}/Contents/Developer/Platforms/MacOSX.platform" "${TARGET_ROOT_PATH}/Accessibility Inspector.app/Contents/Developer/Platforms/"

# fake SDK check
cp -Rf ${TARGET_ROOT_PATH}/Developer "${TARGET_ROOT_PATH}/Accessibility Inspector.app/Contents/"
echo "Generate standalone Accessibility Inspector is done! "