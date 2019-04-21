#!/bin/bash

echo "\033[1mTESTING when we move a file from src to src/folder \033[0m"

touch testing/src/file.c
mkdir testing/src/folder

mv testing/src/file.c testing/src/folder/file.c

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/folder/file.c"

if [ $? -ne 0 ]; then
    echo "When a file is moved, the name has to change"
    exit 84
fi

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/file.c"

if [ $? -ne 0 ]; then
    echo "When a file is moved, the old name has to be removed"
    exit 84
fi

echo "\033[1;32mTest 1 passed\033[0m"

echo "\033[1mTESTING when we move a file from src/folder to src \033[0m"

mkdir testing/src/folder
touch testing/src/folder/file.c

mv testing/src/folder/file.c testing/src/file.c

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/file.c"

if [ $? -ne 0 ]; then
    echo "When a file is moved, the name has to change"
    exit 84
fi

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/folder/file.c"

if [ $? -ne 0 ]; then
    echo "When a file is moved, the old name has to be removed"
    exit 84
fi

echo "\033[1;32mTest 2 passed\033[0m"

echo "\033[1mTESTING when we move a file from tests to tests/folder \033[0m"

touch testing/tests/file.c
mkdir testing/tests/folder

mv testing/tests/file.c testing/tests/folder/file.c

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/folder/file.c"

if [ $? -ne 0 ]; then
    echo "When a file is moved, the name has to change"
    exit 84
fi

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/file.c"

if [ $? -ne 0 ]; then
    echo "When a file is moved, the old name has to be removed"
    exit 84
fi

echo "\033[1;32mTest 3 passed\033[0m"

echo "\033[1mTESTING when we move a file from tests/folder to tests \033[0m"

mkdir testing/tests/folder
touch testing/tests/folder/file.c

mv testing/tests/folder/file.c testing/tests/file.c

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/file.c"

if [ $? -ne 0 ]; then
    echo "When a file is moved, the name has to change"
    exit 84
fi

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/folder/file.c"

if [ $? -ne 0 ]; then
    echo "When a file is moved, the old name has to be removed"
    exit 84
fi

echo "\033[1;32mTest 4 passed\033[0m"

echo "\033[1mTESTING when we move a file from lib/my to lib/my/folder \033[0m"

touch testing/lib/my/file.c
mkdir testing/lib/my/folder

mv testing/lib/my/file.c testing/lib/my/folder/file.c

python3 ./ci/tests/find_file.py "./testing/lib/my/" "SRC\t=" "folder/file.c"

if [ $? -ne 0 ]; then
    echo "When a file is moved, the name has to change"
    exit 84
fi

python3 ./ci/tests/find_file.py "./testing/lib/my/" "SRC\t=" "file.c"

if [ $? -ne 0 ]; then
    echo "When a file is moved, the old name has to be removed"
    exit 84
fi

echo "\033[1;32mTest 5 passed\033[0m"

echo "\033[1mTESTING when we move a file from lib/my/folder to lib/my \033[0m"

mkdir testing/lib/my/folder
touch testing/lib/my/folder/file.c

mv testing/lib/my/folder/file.c testing/lib/my/file.c

python3 ./ci/tests/find_file.py "./testing/lib/my/" "SRC\t=" "file.c"

if [ $? -ne 0 ]; then
    echo "When a file is moved, the name has to change"
    exit 84
fi

python3 ./ci/tests/find_file.py "./testing/lib/my/" "SRC\t=" "folder/file.c"

if [ $? -ne 0 ]; then
    echo "When a file is moved, the old name has to be removed"
    exit 84
fi

echo "\033[1;32mTest 6 passed\033[0m"
