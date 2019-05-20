#!/bin/bash

# ========= functions ============

function move_test() {
    touch testing/$6/$1
    mkdir $2

    sleep 4

    mv testing/$6/$1 $2/$1

    sleep 4

    python3 ./ci/tests/find_file.py $3 $4 $5

    if [ $? -ne 0 ]; then
        echo -e "$1 NOT FOUND"
        exit 84
    fi

    python3 ./ci/tests/find_file.py $3 $4 "/$1"

    if [ $? -ne 84 ]; then
        echo -e "$1 NEED TO BE REMOVED AFTER MOVE"
        exit 84
    else
        echo -e "\033[1;32m$1 PASSED\033[0m"
    fi

    rm $2/$1
    rm -r $2
}

function move_to_root() {
    touch $1

    sleep 4

    mv $1 $2

    sleep 4

    python3 ./ci/tests/find_file.c $3 $4 $5

    if [ $? -ne 0 ]; then
        echo -e "When a file is moved, the names has to change"
        exit 84
    fi

    python3 ./ci/tests/find_file.c $3 $4 $6

    if [ $? -ne 84 ]; then
        echo -e "When a file is moved the name has to change"
        exit 84
    fi

    rm $2
}

echo -e "\033[1mTESTING when we move a file from src to src/folder \033[0m"
move_test file.c testing/src/folder "./testing/" "SRC\t=" "/folder/file.c" src

echo -e "\033[1mTESTING when we move a file from src/folder to src \033[0m"
move_to_root testing/src/folder/file.c testing/src/file.c "./testing/" "SRC\t=" "/file.c" "/folder/file.c"

echo -e "\033[1mTESTING when we move a file from tests to tests/folder \033[0m"
move_test file.c testing/tests/folder "./testing/" "TESTS\t=" "/folder/file.c" tests

echo -e "\033[1mTESTING when we move a file from tests/folder to tests \033[0m"
move_to_root testing/tests/folder/file.c testing/tests/file.c "./testing/" "TESTS\t=" "/file.c" "/folder/file.c"

echo -e "\033[1mTESTING when we move a file from lib/my to lib/my/folder \033[0m"
move_test file.c testing/lib/my/folder "./testing/lib/my/" "SRC\t=" "folder/file.c" lib/my

echo -e "\033[1mTESTING when we move a file from lib/my/folder to lib/my \033[0m"
move_to_root testing/lib/my/folder/file.c testing/lib/my/file.c "./testing/lib/my/" "SRC\t=" "file.c" "folder/file.c"
