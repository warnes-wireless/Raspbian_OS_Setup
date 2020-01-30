#!/bin/bash

# Install ARM Compute library 
# Copyright 2020 The MathWorks, Inc.

VERSION=19.05
GITHUB=https://github.com/ARM-software/ComputeLibrary/archive/v
INSTALLDIR=/opt/ComputeLibrary
PACKAGESTOINSTALL=(libopencv-dev scons)


for pkg in "${PACKAGESTOINSTALL[@]}"
do
	echo "Installing $pkg ..."
	sudo apt install $pkg
done

echo "Download source code for ARM Compute library $VERSION "
if [ ! -d "$INSTALLDIR" ]; then
  mkdir -p $INSTALLDIR
fi
cd $INSTALLDIR; wget $GITHUB$VERSION.tar.gz

echo "Extracting the downloaded source code"
cd $INSTALLDIR ; tar -xvf v$VERSION.tar.gz ;

echo "Installing ARM Compute library $VERSION "
cd $INSTALLDIR/ComputeLibrary-$VERSION ; scons Werror=1 debug=0 asserts=0 neon=1 opencl=0 build=native -j2 ; cd - ;

echo "Adding ARM Compute Library path to env ARM_COMPUTELIB"
sudo echo "ARM_COMPUTELIB=$INSTALLDIR/ComputeLibrary-$VERSION" >> /etc/environment;

echo "Copying libraries from build folder to lib"
if [ ! -d "$INSTALLDIR/ComputeLibrary-$VERSION/lib" ]; then
  sudo mkdir -p $INSTALLDIR/ComputeLibrary-$VERSION/lib
fi
sudo cp -v $INSTALLDIR/ComputeLibrary-$VERSION/build/*.so $INSTALLDIR/ComputeLibrary-$VERSION/lib/

echo "Done."


