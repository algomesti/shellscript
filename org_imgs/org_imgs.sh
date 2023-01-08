#!/bin/bash

convert_image() {
    local path_image=$1
    local image_without_ext=$(ls $path_image | awk -F.jpg '{ print $1 }')
    convert $image_without_ext.jpg $image_without_ext.png
}

walk_folders() {
    folder=$1;
    ini_folder=$2 
    cd $folder
    for file in *
    do      
        local path_file=$(find $initial_folder -name $file)
        if [ -d $path_file ]
        then 
            walk_folders $path_file $initial_folder
        else
            convert_image $path_file $initial_folder
        fi
    done
}

initial_folder=$(pwd);
walk_folders $initial_folder/imgs $initial_folder/imgs 2>error.log;

[ $? -eq 0 ] && {
    echo "\n ERROR: - Fail Executing Script"
    exit 1;
}