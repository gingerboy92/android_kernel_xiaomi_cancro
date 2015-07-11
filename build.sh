#!/bin/bash
ZIP_DIR="zip"
ZIMAGE="arch/arm/boot/zImage"
COMPILER="../arm-eabi-5.1/bin"
ZIP_NAME=StellAR_$(date +%F)
BUILD_START=$(date +"%s")
echo "Removing Present files"
find . -type f -name '*~' | xargs -n 1 rm
rm $ZIMAGE
rm ../$ZIP_DIR/modules/*
rm ../$ZIP_DIR/zImage
echo "Building Kernel"
make -j4
echo "Stripping  Modules For Size"
find . -type f -name '*.ko' | xargs -n 1 $COMPILER/arm-eabi-objcopy --strip-unneeded
echo "Copying Files to zip Directory"
cp $ZIMAGE ../$ZIP_DIR
find . -name '*.ko' -exec cp {} ../$ZIP_DIR/modules/ \;
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
cd ../$ZIP_DIR
find . -name '*.zip' -exec mv {} output \;
zip -r9 --exclude=*output* $ZIP_NAME.zip *
