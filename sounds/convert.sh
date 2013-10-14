#!/bin/bash

for i in *.wav; do
    ffmpeg -i "$i" -acodec libvorbis "${i%%.*}.ogg";
done
