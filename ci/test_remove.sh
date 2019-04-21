#!/bin/bash

touch testing/src/file.c

rm testing/src/file.c

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/file.c"

if [ $? -ne 84 ]; then
    echo "When the file was removed the line on Makefile need to be removed too"
    exit 84
fi

mkdir testing/src/folder
touch testing/src/folder/file.c

python3 ./ci/tests/find_file.py "./testing/" "SRC\t=" "/folder/file.c"

if [ $? -ne 84 ]; then
    echo "When the file was removed the line on Makefile need to be removed too"
    exit 84
fi

touch testing/tests/file.c

rm testing/tests/file.c

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/file.c"

if [ $? -ne 84 ]; then
    echo "When the file was removed the line on Makefile need to be removed too"
    exit 84
fi

mkdir testing/tests/folder
touch testing/tests/folder/file.c

python3 ./ci/tests/find_file.py "./testing/" "TESTS\t=" "/folder/file.c"

if [ $? -ne 84 ]; then
    echo "When the file was removed the line on Makefile need to be removed too"
    exit 84
fi

touch testing/lib/my/file.c

rm testing/lib/my/file.c

python3 ./ci/tests/find_file.py "./testing/lib/my/" "SRC\t=" "file.c"

if [ $? -ne 84 ]; then
    echo "When the file was removed the line on Makefile need to be removed too"
    exit 84
fi

mkdir testing/lib/my/folder
touch testing/lib/my/folder/file.c

python3 ./ci/tests/find_file.py "./testing/lib/my/" "SRC\t=" "folder/file.c"

if [ $? -ne 84 ]; then
    echo "When the file was removed the line on Makefile need to be removed too"
    exit 84
fi

