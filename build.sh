#!/bin/bash
MODULES_DIR="../zip/modules"
BUILD_START=$(date +"%s")
echo "Removing extra backup files"
find . -type f -name '*~' | xargs -n 1 rm
echo "Removing Present Modules"
rm $MODULES_DIR/*
echo "Stripping  Modules For Size"
find . -type f -name '*.ko' | xargs -n 1 /home/arnab/android/arm-eabi-6.0/bin/arm-eabi-objcopy --strip-unneeded
echo "Copying Modules to zip Directory"
find . -name '*.ko' -exec cp {} $MODULES_DIR/ \;
DIFF=$(($BUILD_END - $BUILD_START))
echo "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
