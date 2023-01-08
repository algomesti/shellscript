#!/bin/bash

convert_images() {
    cd imgs
    [ ! -d png ] && {
        mkdir png
    }

    for image in *.jpg 
    do
        local image_without_ext=$(ls $image | awk -F. '{ print $1 }')
        convert $image_without_ext.jpg png/$image_without_ext.png
    done
}

convert_images 2>error.log;

[ $? -ne 0 ] && {
    echo -e "\n ERROR: - Fail Executing Script \n"
    exit 1;
}