#!/bin/bash

echo -e "\033[1mTESTING when we move a file from src to src/folder \033[0m"

touch testing/src/file.c
mkdir testing/src/folder

sleep 4

mv testing/src/file.c testing/src/folder/file.c

sleep 4

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/folder/file.c"

if [ $? -ne 0 ]; then
    echo -e "When a file is moved, the name has to change"
    exit 84
fi

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/file.c"

if [ $? -ne 84 ]; then
    echo -e "When a file is moved, the old name has to be removed"
    exit 84
fi

rm testing/src/folder/file.c

echo -e "\033[1;32mTest 1 passed\033[0m"

echo -e "\033[1mTESTING when we move a file from src/folder to src \033[0m"

touch testing/src/folder/file.c

sleep 4

mv testing/src/folder/file.c testing/src/file.c

sleep 4

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/file.c"

if [ $? -ne 0 ]; then
    echo -e "When a file is moved, the name has to change"
    exit 84
fi

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/folder/file.c"

if [ $? -ne 84 ]; then
    echo -e "When a file is moved, the old name has to be removed"
    exit 84
fi

rm testing/src/file.c

echo -e "\033[1;32mTest 2 passed\033[0m"

echo -e "\033[1mTESTING when we move a file from tests to tests/folder \033[0m"

touch testing/tests/file.c
mkdir testing/tests/folder

sleep 4

mv testing/tests/file.c testing/tests/folder/file.c

sleep 4

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/folder/file.c"

if [ $? -ne 0 ]; then
    echo -e "When a file is moved, the name has to change"
    exit 84
fi

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/file.c"

if [ $? -ne 84 ]; then
    echo -e "When a file is moved, the old name has to be removed"
    exit 84
fi

rm testing/tests/folder/file.c

echo -e "\033[1;32mTest 3 passed\033[0m"

echo -e "\033[1mTESTING when we move a file from tests/folder to tests \033[0m"

touch testing/tests/folder/file.c

sleep 4

mv testing/tests/folder/file.c testing/tests/file.c

sleep 4

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/file.c"

if [ $? -ne 0 ]; then
    echo -e "When a file is moved, the name has to change"
    exit 84
fi

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/folder/file.c"

if [ $? -ne 84 ]; then
    echo -e "When a file is moved, the old name has to be removed"
    exit 84
fi

rm testing/tests/file.c

echo -e "\033[1;32mTest 4 passed\033[0m"

echo -e "\033[1mTESTING when we move a file from lib/my to lib/my/folder \033[0m"

touch testing/lib/my/file.c
mkdir testing/lib/my/folder

sleep 4

mv testing/lib/my/file.c testing/lib/my/folder/file.c

sleep 4

python3 ./ci/tests/find_file.py "./testing/lib/my/" "SRC\t=" "folder/file.c"

if [ $? -ne 0 ]; then
    echo -e "When a file is moved, the name has to change"
    exit 84
fi

python3 ./ci/tests/find_file.py "./testing/lib/my/" "SRC\t=" "file.c"

if [ $? -ne 84 ]; then
    echo -e "When a file is moved, the old name has to be removed"
    exit 84
fi

rm testing/lib/my/folder/file.c

echo -e "\033[1;32mTest 5 passed\033[0m"

echo -e "\033[1mTESTING when we move a file from lib/my/folder to lib/my \033[0m"

touch testing/lib/my/folder/file.c

sleep 4

mv testing/lib/my/folder/file.c testing/lib/my/file.c

sleep 4

python3 ./ci/tests/find_file.py "./testing/lib/my/" "SRC\t=" "file.c"

if [ $? -ne 0 ]; then
    echo -e "When a file is moved, the name has to change"
    exit 84
fi

python3 ./ci/tests/find_file.py "./testing/lib/my/" "SRC\t=" "folder/file.c"

if [ $? -ne 84 ]; then
    echo -e "When a file is moved, the old name has to be removed"
    exit 84
fi

rm testing/lib/my/file.c

echo -e "\033[1;32mTest 6 passed\033[0m"
