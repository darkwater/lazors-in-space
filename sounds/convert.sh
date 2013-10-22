#!/bin/bash

for i in *.wav; do
    ffmpeg -y -i "$i" -acodec libvorbis "${i%%.*}.ogg";
done
