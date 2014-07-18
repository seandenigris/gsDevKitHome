#! /bin/bash

#=========================================================================
# Copyright (c) 2014 GemTalk Systems, LLC <dhenrich@gemtalksystems.com>.
#
# Name - installGci.sh 
#
# Purpose - Install gemstone gci libraries from the specied gemstone
#           release into the pharo vm
#
# Examples
#   installGci.sh <gs-version>
#
#=========================================================================

if [ "$1x" = "x" ] ; then
  echo "installGemStone.sh <gemstone version (e.g., 3.1.0.1)>"
  exit 1
fi 
vers="$1"
if [ "${GS_HOME}x" = "x" ] ; then
  echo "the GS_HOME environment variable needs to be defined"
  exit 1
fi
echo "Copying gci files to pharo"

pharo_vm=$GS_HOME/pharo/pharo-vm


#    Copy the gci libraries to the Pharo vm
if [ ! -e "$pharo_vm" ]; then
  echo "Install Pharo"
  $GS_HOME/bin/installPharo.sh
fi

# Detect operating system
PLATFORM="`uname -sm | tr ' ' '-'`"
# Macs with Core i7 use the same software as older Macs
[ $PLATFORM = "Darwin-x86_64" ] && PLATFORM="Darwin-i386"

case "$PLATFORM" in
  Linux-x86_64)
    gsvers="GemStone64Bit${vers}-x86_64.Linux"
    gs_product=$GS_HOME/gemstone/products/$gsvers
    cp $gs_product/lib32/lib* $pharo_vm
  ;;
  Darwin-i386)
    gsvers="GemStone64Bit${vers}-i386.Darwin"
    gs_product=$GS_HOME/gemstone/products/$gsvers
    cp $gs_product/lib32/lib* $pharo_vm/Pharo.app/Contents/MacOS/Plugins
  ;;
esac

# End of script
exit 0
