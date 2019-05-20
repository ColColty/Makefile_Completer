#!/bin/bash

COUNTER=0

# ========== functions ==========

function remove_file() {
    touch $1
    sleep 4

    python3 ./ci/tests/find_file.py $2 $3 $4

    if [ $? -ne 0 ]; then
        echo -e "The created file need to be added to the makefile"
        exit 84
    fi

    rm $1

    sleep 4

    python3 ./ci/tests/find_file.py $2 $3 $4

    if [ $? -ne 84 ]; then
        echo -e "When the file was removed the line on Makefile need to be removed too"
        exit 84
    fi

    COUNTER = $((COUNTER + 1))
    echo -e "\033[1;32Test $COUNTER passed\033[0m"
}

function remove_file_folder() {
    mkdir $5
    touch $1
    sleep 4

    python3 ./ci/tests/find_file.py $2 $3 $4

    if [ $? -ne 0 ]; then
        echo -e "The created file need to be added to the makefile"
        exit 84
    fi

    rm $1

    sleep 4

    python3 ./ci/tests/find_file.py $2 $3 $4

    if [ $? -ne 84 ]; then
        echo -e "When the file was removed the line on Makefile need to be removed too"
        exit 84
    fi

    COUNTER = $((COUNTER + 1))
    echo -e "\033[1;32Test $COUNTER passed\033[0m"
}

echo -e "\033[1mTESTING when we remove a file from src\033[0m"
remove_file testing/src/file.c "./testing/" "SRC\t=" "/file.c"

echo -e "\033[1mTESTING when we remove a file from src/folder\033[0m"
remove_file_folder testing/src/folder/file.c "./testing/" "SRC\t=" "/folder/file.c" testing/src/folder

echo -e "\033[1mTESTING when we remove a file from tests\033[0m"
remove_file testing/tests/file.c "./testnig/" "TESTS\t=" "/file.c"

echo -e "\033[1mTESTING when we remove a file from tests/folder\033[0m"
remove_file_folder testing/tests/folder/file.c "./testing/" "TESTS\t=" "/folder/file.c" testing/tests/folder

echo -e "\033[1mTESTING when we remove a file from lib/my\033[0m"
remove_file testing/lib/my/file.c "./testing/lib/my/" "SRC\t=" "file.c"

echo -e "\033[1mTESTING when we remove a file from lib/my/folder\033[0m"
remove_file_folder testing/lib/my/folder/file.c "./testing/lib/my/" "SRC\t=" "folder/file.c" testing/lib/my/folder
