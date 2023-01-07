#!/bin/bash

clone_repos() {

    url="https://api.github.com/users/$1/repos";
    repositories=$(curl -s $url | awk '/ssh_url/{print $2}' | sed 's/^"//g' | sed 's/",$//g');
    target=$2;

    [ ! -d $target ] && {
        echo -e "\n Creating folder: $target ...";
        mkdir $target;
    }

    total=0;
    for repository in $repositories 
    do
        project=$(echo $repository | awk -F.git '{print $2}' | awk -F/ '{print $2}');
        echo -e "PROJETO: $project";
        echo -e "Starting clone $project  ... ";
        git clone $repository $target/$project;
        echo -e "\tRepository '$repository' cloned in folder: '$target'/$project \n";
        let total++;
        exit 1
    done
    echo -e "========================================";
    echo -e "Total of repositories cloned: $total";
    echo -e "========================================\n\n";
}

[ $# -ne 2 ] && {
    echo -e "\n\tError: Invalid number of parameters ($#) : clone-all-repository-from-git <gitUser> <folderToClone>\n";
    exit 1;
}; 

clone_repos $1 $2 2>error.log;

[ $? -eq 0 ] && {
    echo "\n ERROR: - Fail Executing Script"
    exit 1;
}