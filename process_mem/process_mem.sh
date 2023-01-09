#!/bin/bash

[ ! -d logs ] && {
    mkdir logs
}

process_mem() {
    pids=$(ps -e -o pid --sort -size | head -n 11 | grep [0-9])
    for pid in $pids
    do
        name_file=$(ps -p $pid -o comm=)
        [ ! $name_file = "" ] && {
            sizeInKb=$(ps -p $pid -o size | grep [0-9])
            sizeInMb=$(bc <<< "scale=2;$sizeInKb/1024")
            echo -n $(date +%F,%H:%M:%S,) >> logs/$name_file.log
            echo "$sizeInMb MB" >> logs/$name_file.log
        }
        
    done
}

process_mem

[ $? -ne 0 ] && {
    echo -e "\n ERROR: - Fail Executing Script"
    exit 1;
}