#!/bin/bash

# ================ functions ======================
function test_add() {
    touch $1

    sleep 3

    python3 ./ci/tests/find_file.py $2 $3 $4

    if [ $? -ne $5 ]; then
        echo -e "$1 FAILED with code $?"
        exit 84
    else
        echo -e "\033[1;32m$1 PASSED\033[0m"
    fi

    rm $1
}

function test_add_wfolder() {
    mkdir $1
    touch $1/$2

    sleep 3

    python3 ./ci/tests/find_file.py $3 $4 $5

    if [ $? -ne $6 ]; then
        echo "$1/$2 FAILED with exit code $?"
        exit 84
    else
        echo "$1/$2 PASSED"
    fi

    rm $1/$2
    rm -r $1
}


echo -e "\033[1m Testing whem we the file has a bad extension\033[0m"
test_add testing/src/bad_extension_file.pdf "./testing/" "SRC\t=" "/bad_extension_file.pdf" 84

echo -e "\033[1m Testing whem we add a file in src\033[0m"
test_add testing/src/good_file.c "./testing/" "SRC\t=" "/good_file.c" 0

echo -e "\033[1m Testing whem we add a file on a folder in src\033[0m"
test_add_wfolder testing/src/folder good_file.c "./testing/" "SRC\t=" "/folder/good_file.c" 0

echo -e "\033[1m Testing whem we add a file on tests\033[0m"
test_add testing/tests/good_tests_file.c "./testing/" "TESTS\t=" "/good_tests_file.c" 0

echo -e "\033[1m Testing whem we add a file in a folder in tests\033[0m"
test_add_wfolder testing/tests/folder good_tests_file.c "./testing/" "TESTS\t=" "/folder/good_tests_file.c" 0

echo -e "\033[1m Testing whem we add a file in lib/my\033[0m"
test_add testing/lib/my/good_lib_file.c "./testing/lib/my/" "SRC\t=" "good_lib_file.c" 0

echo -e "\033[1m Testing whem we add a file in a folder in lib/my\033[0m"
test_add_wfolder testing/lib/my/folder good_lib_file.c "./testing/lib/my/" "SRC\t=" "folder/good_lib_file.c" 0

exit 0