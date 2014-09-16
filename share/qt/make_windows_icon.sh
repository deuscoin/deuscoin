#!/bin/bash
# create multiresolution windows icon
ICON_SRC=../../src/qt/res/icons/deuscoin.png
ICON_DST=../../src/qt/res/icons/deuscoin.ico
convert ${ICON_SRC} -resize 16x16 deuscoin-16.png
convert ${ICON_SRC} -resize 32x32 deuscoin-32.png
convert ${ICON_SRC} -resize 48x48 deuscoin-48.png
convert deuscoin-16.png deuscoin-32.png deuscoin-48.png ${ICON_DST}

