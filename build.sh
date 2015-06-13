#!/bin/bash
ZIP_DIR="../zip"
ZIMAGE="arch/arm/boot/zImage"
BUILD_START=$(date +"%s")
echo "Removing extra files"
find . -type f -name '*~' | xargs -n 1 rm
rm $ZIMAGE
echo "Removing Present Modules"
rm $ZIP_DIR/modules/*
echo "Building Kernel"
make -j2
echo "Stripping  Modules For Size"
find . -type f -name '*.ko' | xargs -n 1 /home/arnab/android/arm-eabi-6.0/bin/arm-eabi-objcopy --strip-unneeded
echo "Copying Files to zip Directory"
cp $ZIMAGE $ZIP_DIR
find . -name '*.ko' -exec cp {} $ZIP_DIR/modules/ \;
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
