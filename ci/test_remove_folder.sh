#!/bin/bash

sleep 2

FOLDER_FILE_SUBFOLDER=("/folder/subfolder/erase/inerase.c"
            "/folder/subfolder/erase/inseconderase.c"
            "/folder/subfolder/insubfolder.c"
            "/folder/subfolder/insubfolder_2.c"
            )

FOLDER_FILE_FOLDER=("/folder/infolder.c"
            "/folder/in_second_folder.c"
            )

function find_files() {
    if [ $4 -eq 0 ]; then
        for file in ${FOLDER_FILE_SUBFOLDER[@]}
        do
            python3 ./ci/tests/find_file.py $2 $3 $file

            if [ $? -ne $1 ]; then
                echo -e "\033[1;31mThe file $file stop the Makefile\033[0m"
                exit 84
            fi
        done
    else
        for file in ${FOLDER_FILE_FOLDER[@]}
        do
            python3 ./ci/tests/find_file.py $2 $3 $file

            if [ $? -ne $1 ]; then
                echo -e "\033[1;31mThe file $file stop the Makefile $?\033[0m"
                exit 84
            fi
        done
    fi
}

function removing_folder() {
    cp -r ci/tests/folder testing/$1

    sleep 4

    find_files 0 $2 $3 $4

    rm -rf testing/src/$5

    sleep 4

    find_files 84 $2 $3 $4

    echo -e "\033[1;32mTests passed\033[0m"
}

echo -e "\033[1mTesting erase with subfolder\033[0m"
removing_folder src "./testing/" "SRC\t=" 0 folder/subfolder

echo -e "\033[1mTesting erase with folder\033[0m"
removing_folder src "./testing/" "SRC\t=" 1 folder