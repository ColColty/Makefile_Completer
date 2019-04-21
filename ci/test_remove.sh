#!/bin/bash

echo "\033[1mTESTING when we remove a file from src\033[0m"

touch testing/src/file.c

rm testing/src/file.c

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/file.c"

if [ $? -ne 84 ]; then
    echo "When the file was removed the line on Makefile need to be removed too"
    exit 84
fi

echo "\033[1;32mTest 1 passed\033[0m"

echo "\033[1mTESTING when we remove a file from src/folder\033[0m"

mkdir testing/src/folder
touch testing/src/folder/file.c

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/folder/file.c"

if [ $? -ne 84 ]; then
    echo "When the file was removed the line on Makefile need to be removed too"
    exit 84
fi

echo "\033[1;32mTest 2 passed\033[0m"

echo "\033[1mTESTING when we remove a file from tests\033[0m"

touch testing/tests/file.c

rm testing/tests/file.c

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/file.c"

if [ $? -ne 84 ]; then
    echo "When the file was removed the line on Makefile need to be removed too"
    exit 84
fi

echo "\033[1;32mTest 3 passed\033[0m"

echo "\033[1mTESTING when we remove a file from tests/folder\033[0m"

mkdir testing/tests/folder
touch testing/tests/folder/file.c

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/folder/file.c"

if [ $? -ne 84 ]; then
    echo "When the file was removed the line on Makefile need to be removed too"
    exit 84
fi

echo "\033[1;32mTest 4 passed\033[0m"

echo "\033[1mTESTING when we remove a file from lib/my\033[0m"

touch testing/lib/my/file.c

rm testing/lib/my/file.c

python3 ./ci/tests/find_file.py "./testing/lib/my/" "SRC\t=" "file.c"

if [ $? -ne 84 ]; then
    echo "When the file was removed the line on Makefile need to be removed too"
    exit 84
fi

echo "\033[1;32mTest 5 passed\033[0m"

echo "\033[1mTESTING when we remove a file from lib/my/folder\033[0m"

mkdir testing/lib/my/folder
touch testing/lib/my/folder/file.c

python3 ./ci/tests/find_file.py "./testing/lib/my/" "SRC\t=" "folder/file.c"

if [ $? -ne 84 ]; then
    echo "When the file was removed the line on Makefile need to be removed too"
    exit 84
fi

echo "\033[1;32mTest 6 passed\033[0m"

