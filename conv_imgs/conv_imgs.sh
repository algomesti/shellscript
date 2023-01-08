#!/bin/bash

convert_images() {
    cd imgs
    [ ! -d png ] && {
        mkdir png
    }

    for image in *.jpg 
    do
        local image_without_ext=$(ls $image | awk -F. '{ print $1 }')
        convert $image_without_ext.jpg in png/$image_without_ext.png
    done
}

convert_images 2>error.log;

[ $? -eq 0 ] && {
    echo "\n ERROR: - Fail Executing Script"
    exit 1;
}